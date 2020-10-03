#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}

#Import source 
	source password/passwd.env
	
# Sau khi da chay make_repo
#keystone
function install_keystone {
	docker pull docker-registry:4000/keystone:q 


	sed -i "s|MQ_KEYSTONE|${MQ_KEYSTONE}|g" /usr/share/docker/keystone/keystone/keystone.conf
	

	docker stop keystone;
	docker rm keystone;

	detailtask "+Create Docker Keystone Container\n"
	docker run  -d --name keystone --network=host --restart unless-stopped -u root -v $VAR_LOG_DIR/apache2:/var/log/apache2 -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e KEYSTONE_START='START_KEYSTONE' docker-registry:4000/keystone:q

	rm -rf /etc/keystone/*
	echocolor "scp -r ${SSH_USER}@${HUB}:/etc/keystone/* /etc/keystone/"
    scp -r    ${SSH_USER}@${HUB}:/etc/keystone/* /etc/keystone/
    docker restart keystone

	cp ./open.rc /root/
	sed -i "s|ADMIN_PASS|${ADMIN_PASS}|g" ~/open.rc

	detailtask "+Create Demo Project\n"
	source ~/open.rc
}

#glance
function install_glance {
	docker pull docker-registry:4000/glance:q

	detailtask "+Create glance service\n"
	
	sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/glance/glance/glance-api.conf 
	sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/glance/glance/glance-registry.conf  
	sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /usr/share/docker/glance/glance/glance-api.conf 
	sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/glance/glance/glance-api.conf 
	sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /usr/share/docker/glance/glance/glance-registry.conf 
	sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/glance/glance/glance-registry.conf 
	sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /usr/share/docker/glance/glance/glance-api.conf 
	sed -i "s|MQ_GLANCE|${MQ_GLANCE}|g" /usr/share/docker/glance/glance/glance-api.conf 
	sed -i "s|GLANCE_PASS|${GLANCE_PASS}|g" /usr/share/docker/glance/glance/glance-api.conf 
	sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /usr/share/docker/glance/glance/glance-registry.conf 
	sed -i "s|MQ_GLANCE|${MQ_GLANCE}|g" /usr/share/docker/glance/glance/glance-registry.conf 
	sed -i "s|GLANCE_PASS|${GLANCE_PASS}|g" /usr/share/docker/glance/glance/glance-registry.conf
	

	docker stop glance-api
	docker stop glance-registry
	docker rm glance-api
	docker rm glance-registry

	detailtask "+Create Glance container\n"
	docker run -d --name glance-api --network=host --restart unless-stopped -v $VAR_LOG_DIR/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_API' docker-registry:4000/glance:q
	docker run -d --name glance-registry --network=host --restart unless-stopped -v $VAR_LOG_DIR/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_REGISTRY' docker-registry:4000/glance:q
	#openstack image create "cirros" --file  cirros-0.4.0-x86_64-disk.img --disk-format qcow2 --container-format bare --public
    #openstack image list

    #openstack image create "ubuntu16.04" --file  xenial-server-cloudimg-amd64-disk1.img --disk-format qcow2 --container-format bare --public
}


function install_cinder {
	docker pull docker-registry:4000/cinder_api:q
	docker pull docker-registry:4000/cinder_scheduler:q
	
	detailtask "+Create cinder service\n"
	source ~/open.rc

	sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /usr/share/docker/cinder/cinder/cinder.conf
	sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/cinder/cinder/cinder.conf
	sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/cinder/cinder/cinder.conf 
	sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /usr/share/docker/cinder/cinder/cinder.conf 
	sed -i "s|MQ_CINDER|${MQ_CINDER}|g" /usr/share/docker/cinder/cinder/cinder.conf 
	sed -i "s|CINDER_PASS|${CINDER_PASS}|g" /usr/share/docker/cinder/cinder/cinder.conf  
	
	

	docker stop cinder-api
	docker stop cinder-scheduler
	docker rm cinder-api
	docker rm cinder-scheduler

 	
	detailtask "+Create Cinder container\n"
	docker run -d --name cinder-api --network=host --restart unless-stopped -v $VAR_LOG_DIR/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder -v $VAR_LOG_DIR/apache2:/var/log/apache2  -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e CINDER_START='START_CINDER_API' docker-registry:4000/cinder_api:q


	docker run -d --name cinder-scheduler --network=host --restart unless-stopped -v $VAR_LOG_DIR/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder -v $VAR_LOG_DIR/apache2:/var/log/apache2  -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u cinder -e CINDER_START='START_CINDER_SCHEDULER' docker-registry:4000/cinder_scheduler:q



	#openstack image create "cirros" --file  cirros-0.4.0-x86_64-disk.img --disk-format qcow2 --container-format bare --public
    #openstack image list
}

#nova
function install_nova {
	docker pull docker-registry:4000/nova:q 
	
	detailtask "+Create nova service\n"
	
		
	sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /usr/share/docker/nova/nova/nova.conf
	sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/nova/nova/nova.conf
	sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/nova/nova/nova.conf 
 	sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /usr/share/docker/nova/nova/nova.conf 
	sed -i "s|MQ_NOVA|${MQ_NOVA}|g" /usr/share/docker/nova/nova/nova.conf 
	sed -i "s|NOVA_PASS|${NOVA_PASS}|g" /usr/share/docker/nova/nova/nova.conf 
	sed -i "s|PLACEMENT_PASS|${PLACEMENT_PASS}|g" /usr/share/docker/nova/nova/nova.conf 
	sed -i "s|NEUTRON_PASS|${NEUTRON_PASS}|g" /usr/share/docker/nova/nova/nova.conf 
	sed -i "s|METADATA_SECRET|${METADATA_SECRET}|g" /usr/share/docker/nova/nova/nova.conf
	


	docker stop nova-api
	docker stop nova-scheduler
	docker stop nova-conductor
	docker stop nova-novncproxy
	docker stop nova-placement-api
	docker rm nova-api
	docker rm nova-scheduler
	docker rm nova-conductor
	docker rm nova-novncproxy
	docker rm nova-placement-api

	detailtask "+Create Nova Container\n"
	docker run -d --name nova-consoleauth --network=host --restart unless-stopped --privileged -u nova -v $VAR_LOG_DIR/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_CONSOLEAUTH' docker-registry:4000/nova:q
	docker run -d --name nova-api --network=host --privileged --restart unless-stopped -u nova -v $VAR_LOG_DIR/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_API' docker-registry:4000/nova:q
	docker run -d --name nova-scheduler --network=host --restart unless-stopped --privileged -u nova -v $VAR_LOG_DIR/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_SCHEDULER' docker-registry:4000/nova:q
	docker run -d --name nova-conductor --network=host --restart unless-stopped --privileged -u nova -v $VAR_LOG_DIR/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_CONDUCTOR' docker-registry:4000/nova:q
	docker run -d --name nova-novncproxy --network=host --restart unless-stopped --privileged -u nova -v $VAR_LOG_DIR/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_NOVNCPROXY' docker-registry:4000/nova:q
	docker run -d --name nova-placement-api --network=host --restart unless-stopped --privileged -u root -v $VAR_LOG_DIR/apache2:/var/log/apache2 -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_PLACEMENT_API' docker-registry:4000/nova:q
	
	#openstack compute service list --service nova-compute
}

#neutron
function install_neutron_server {	
	docker pull docker-registry:4000/neutron:q 

	
	detailtask "+Create neutron project\n"
	
	


	sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /usr/share/docker/neutron/neutron/neutron.conf
	sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/neutron/neutron/neutron.conf
	sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/neutron/neutron/neutron.conf 
 	sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /usr/share/docker/neutron/neutron/neutron.conf 
	sed -i "s|MQ_NEUTRON|${MQ_NEUTRON}|g" /usr/share/docker/neutron/neutron/neutron.conf 
	sed -i "s|NOVA_PASS|${NOVA_PASS}|g" /usr/share/docker/neutron/neutron/neutron.conf 
	sed -i "s|NEUTRON_PASS|${NEUTRON_PASS}|g" /usr/share/docker/neutron/neutron/neutron.conf
	
	sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/neutron/neutron/plugins/ml2/openvswitch_agent.ini
	sed -i "s|METADATA_SECRET|${METADATA_SECRET}|g" /usr/share/docker/neutron/neutron/metadata_agent.ini
	
	
	docker stop neutron-server
	docker rm neutron-server

	
	detailtask "+Create Neutron Container\n"
	docker run -d --name neutron-server --network=host --restart unless-stopped --privileged -v $VAR_LOG_DIR/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u neutron -e NEUTRON_START='START_NEUTRON_SERVER'  docker-registry:4000/neutron:q
}

#horizon
function install_horizon {
	docker pull docker-registry:4000/horizon:q
		
	docker stop horizon
	docker rm horizon
	docker run -d --name horizon --network=host --restart unless-stopped -u root -v $VAR_LOG_DIR/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e HORIZON_START='START_HORIZON' docker-registry:4000/horizon:q
}

function main_controller {
	printcolor "+ do what?\n +5. Install Keystone\n + 6. Install Glance\n + 7. Install Nova\n +8. Install Neutron\n +9. Install Horizon\n +10. Install Cinder\n 
	Your action: "
	
	read action
	
	if [ $action == 5 ]; then
		echocolor "+ INSTALL KEYSTONE"
		install_keystone
		sleep 2
	elif [ $action == 6 ]; then
		echocolor "+ INSTALL GLANCE"
		install_glance
		sleep 2
	elif [ $action == 7 ]; then
		echocolor "+ INSTALL NOVA"
		install_nova
		sleep 2
	elif [ $action == 8 ]; then
		echocolor "+ INSTALL NEUTRON"
		install_neutron_server
		sleep 2
	elif [ $action == 9 ]; then 
		echocolor "+ INSTALL HORIZON"
		install_horizon
		sleep 2
	elif [ $action == 10 ]; then 
		echocolor "+ INSTALL CINDER"
		install_cinder
		sleep 2
    else
        echocolor "+ Invalid action! InSTALL ALL !!"
		
		echocolor "+ INSTALL KEYSTONE"
		install_keystone
		sleep 2
		echocolor "+ INSTALL GLANCE"
		install_glance
		sleep 2
		echocolor "+ INSTALL NOVA"
		install_nova
		sleep 2
		echocolor "+ INSTALL NEUTRON"
		install_neutron_server
		sleep 2
		echocolor "+ INSTALL HORIZON"
		install_horizon
		sleep 2 
    fi
	
}
		
		
		
		
		
		
		
