#!/bin/bash
# 
#



#docker run  --network=host  --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_OVS_AGENT'   docker-registry:4000/neutron:q 


#	
#iptables -L 
#modprobe ip_tables



DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}
#Import source 
	source password/passwd.env
	
# Sau khi da chay make_repo


#nova
function install_nova {
	detailtask "+yum install -y openstack-nova-compute\n"
	

	#yum remove qemu
	#yum remove qemu-kvm
    #virsh -c qemu:///system version --daemon
    #/usr/libexec/qemu-kvm --version
	yum install -y openstack-nova-compute

	cp ./open.rc /root/
	sed -i "s|ADMIN_PASS|${ADMIN_PASS}|g" ~/open.rc
	source ~/open.rc
	rm -rf /etc/nova/nova.conf
	cp ./config/nova.conf /etc/nova/ 


	sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /etc/nova/nova.conf 
	sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /etc/nova/nova.conf 
	sed -i "s|OS_CONTROLLER|${OS_CONTROLLER}|g" /etc/nova/nova.conf 
	sed -i "s|MY_IP|${MY_IP}|g" /etc/nova/nova.conf 
 	sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /etc/nova/nova.conf 
	sed -i "s|MQ_NOVA|${MQ_NOVA}|g" /etc/nova/nova.conf 
	sed -i "s|NOVA_PASS|${NOVA_PASS}|g" /etc/nova/nova.conf
	sed -i "s|PLACEMENT_PASS|${PLACEMENT_PASS}|g" /etc/nova/nova.conf 
	sed -i "s|NEUTRON_PASS|${NEUTRON_PASS}|g" /etc/nova/nova.conf
	sed -i "s|METADATA_SECRET|${METADATA_SECRET}|g" /etc/nova/nova.conf
	sed -i "s|REGION_NAME|${REGION_NAME}|g" /etc/nova/nova.conf
	




	detailtask "+systemctl start libvirtd.service openstack-nova-compute.service\n"
	systemctl enable libvirtd.service openstack-nova-compute.service
	systemctl start libvirtd.service openstack-nova-compute.service
	#openstack compute service list --service nova-compute


    ###
        #Trong truogn hop loi phai xoa quemu //yum remove qemu
    ###
}

#neutrony

#
#	docker run  --name cinder-volume --network=host  -v /var/log/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder  -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u cinder -e CINDER_START='START_CINDER_VOLUME' docker-registry:4000/cinder_volume:q

function install_neutron {


        #detailtask "+yum install -y openvswitch\n"
        #yum install -y openvswitch
        #systemctl enable openvswitch.service
        #systemctl start openvswitch.service

        docker pull docker-registry:4000/neutron:q
        #detailtask "+ifconfig eth1 promisc\n"
        #ifconfig eth1 promisc
        #ip link set eth1 promisc on
        #systemctl restart network.service



        #ifconfig $FLAT_INTERFACE 0
        #systemctl restart openvswitch.service
        #detailtask "+ovs-vsctl show\n"
        #ovs-vsctl show
        #detailtask "+ovs-vsctl add-br br-flat\n"
        #ovs-vsctl add-br br-flat
        #detailtask "+ovs-vsctl add-br br-vlan\n"
        #ovs-vsctl add-br br-vlan
        #detailtask "+ovs-vsctl add-port br-flat eth1\n"
        #ovs-vsctl add-port br-flat $FLAT_INTERFACE


        sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /usr/share/docker/neutron/neutron/neutron.conf
        sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/neutron/neutron/neutron.conf
        sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/neutron/neutron/neutron.conf
        sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /usr/share/docker/neutron/neutron/neutron.conf
        sed -i "s|MQ_NEUTRON|${MQ_NEUTRON}|g" /usr/share/docker/neutron/neutron/neutron.conf
        sed -i "s|NOVA_PASS|${NOVA_PASS}|g" /usr/share/docker/neutron/neutron/neutron.conf
        sed -i "s|NEUTRON_PASS|${NEUTRON_PASS}|g" /usr/share/docker/neutron/neutron/neutron.conf

        sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/neutron/neutron/plugins/ml2/openvswitch_agent.ini
        sed -i "s|METADATA_SECRET|${METADATA_SECRET}|g" /usr/share/docker/neutron/neutron/metadata_agent.ini
     
        echo "=====================> CHECK OVS_VSCT SHOW XEM CO BR_VLAN"


         /etc/init.d/ovs-dpdk start

        ovs-vsctl --no-wait -- --may-exist add-br br-vlan -- set Bridge br-vlan datapath_type=netdev




}

function start_neutron {


      
        docker stop ovs-agent
        docker stop dhcp-agent
        docker stop metadata-agent
        docker rm metadata-agent
        docker rm ovs-agent
        docker rm dhcp-agent
        detailtask "+Create container ovs-agent dhcp-agent metadata-agent\n"
        docker run -d --name ovs-agent --network=host --privileged --user neutro
        n -v $VAR_LOG_DIR/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_OVS_AGENT'   docker-registry:4000/neutron:q





        docker run -d --name dhcp-agent --network=host  --privileged --user neutron -v $VAR_LOG_DIR/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_DHCP_AGENT' docker-registry:4000/neutron:q
	# --restart unless-stopped
        docker run -d --name metadata-agent --network=host  --privileged --user neutron -v $VAR_LOG_DIR/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run/netns:/run/netns:shared -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_METADATA_AGENT' docker-registry:4000/neutron:q



}


function finish_neutron {

	
        docker stop ovs-agent
        docker stop dhcp-agent
        docker stop metadata-agent
        docker rm metadata-agent
        docker rm ovs-agent
        docker rm dhcp-agent
        detailtask "+Create container ovs-agent dhcp-agent metadata-agent\n"
        docker run -d --name ovs-agent --network=host    --restart unless-stopped       --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_OVS_AGENT'   docker-registry:4000/neutron:q

        docker run -d --name dhcp-agent --network=host       --restart unless-stopped    --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_DHCP_AGENT' docker-registry:4000/neutron:q
        # --restart unless-stopped
        docker run -d --name metadata-agent --network=host    --restart unless-stopped       --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run/netns:/run/netns:shared -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_METADATA_AGENT' docker-registry:4000/neutron:q

}





function install_cinder_hand {
        yum install lvm2 device-mapper-persistent-data
        #systemctl enable lvm2-lvmetad.service
        #systemctl start lvm2-lvmetad.service
        #pvcreate /dev/sdb #physical volume

        #vgcreate cinder-volumes /dev/sdb

        yum install python-zope-interface-4.0.5-4.el7.x86_64.rpm

        #yum remove qemu-kvm
        yum install openstack-cinder targetcli python-keystone


        #systemctl enable openstack-cinder-volume.service target.service
        #systemctl start openstack-cinder-volume.service target.service
}



function install_cinder_volume {
        yum install ceph-common
        docker pull docker-registry:4000/cinder_volume:q
        cp ./config/cinder.conf /usr/share/docker/cinder/cinder/cinder.conf

        sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /usr/share/docker/cinder/cinder/cinder.conf
        sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/cinder/cinder/cinder.conf
        sed -i "s|OS_CONTROLLER|${OS_CONTROLLER}|g" /usr/share/docker/cinder/cinder/cinder.conf
        sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/cinder/cinder/cinder.conf
        sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /usr/share/docker/cinder/cinder/cinder.conf
        sed -i "s|MQ_CINDER|${MQ_CINDER}|g" /usr/share/docker/cinder/cinder/cinder.conf
        sed -i "s|CINDER_PASS|${CINDER_PASS}|g" /usr/share/docker/cinder/cinder/cinder.conf


        sed -i "s|METADATA_SECRET|${METADATA_SECRET}|g" /usr/share/docker/cinder/cinder/cinder.conf
        sed -i "s|REGION_NAME|${REGION_NAME}|g" /usr/share/docker/cinder/cinder/cinder.conf


         scp /usr/share/docker/cinder/cinder/cinder.conf /etc/cinder/


        #docker run -d --name cinder-volume --network=host --restart unless-stopped --privileged  -v /run/lvm/:/run/lvm/  -v $VAR_LOG_DIR/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder  -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u cinder -e CINDER_START='START_CINDER_VOLUME' docker-registry:4000/cinder_volume:q

}



function install_swift_storage {
    yum install xfsprogs rsync
    mkfs.xfs /dev/sda
    # mkfs.xfs /dev/sdc
    mkdir -p /srv/node/sda
    # mkdir -p /srv/node/sdc
    /dev/sdc /srv/node/sdc xfs noatime,nodiratime,nobarrier,logbufs=8 0 2
    #/dev/sdc /srv/node/sdc xfs noatime,nodiratime,nobarrier,logbufs=8 0 2
    mount /srv/node/sda
    # mount /srv/node/sdc

    cp ./config/rsyncd.conf /etc/
    sed -i "s|MY_IP|${MY_IP}|g" /etc/rsyncd.conf
    systemctl enable rsyncd.service
    systemctl restart rsyncd.service

    sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/swift/swift/account-server.conf 
    sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/swift/swift/container-server.conf 
    sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/swift/swift/object-server.conf

    #docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift -v /var/cache/:/var/cache/ -v /srv/node/:/srv/node -v /var/lock/:/var/lock -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u swift -e SWIFT_START='START_SWIFT_STORAGE' docker-registry:4000/swift_storage:q
    
    echo "/dev/sdb /srv/node/sdb xfs noatime,nodiratime,nobarrier,logbufs=8 0 2" >> /etc/fstab
    mount /srv/node/sdb

    yum install openstack-swift-account openstack-swift-container openstack-swift-object
    chown -R swift:swift /srv/node
    mkdir -p /var/cache/swift
    chown -R root:swift /var/cache/swift
    chmod -R 775 /var/cache/swift

    # systenctl status openstack-swift-container

}


function main_compute {
	printcolor "+ do what?\n+ 
	4. Install Nova\n +5. Install Neutron\n +
	Your action: "
	
	read action
	if [ $action == 4 ]; then
		install_nova
		sleep 2
	elif [ $action == 5 ]; then
		install_neutron
		sleep 2
    else
        echocolor "+ Invalid action! InSTALL ALL !!"
		install_nova
		sleep 2
		install_neutron
		sleep 2
    fi
	
}	


		
		
		
		
		
		
		
		
		
		
