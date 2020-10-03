
Huong dan cai dat su dung 

function install_swift_proxy {

	source ~/open.rc 
	docker pull docker-registry:4000/swift_proxy:q
	openstack user create --domain default --password MqWRKWbkbB3RcmMT4aXe2lntXOIubGvJ  swift
	openstack role add --project service --user swift admin
	openstack service create --name swift --description "OpenStack Object Storage" object-store
	openstack endpoint create --region North_VN object-store public http://controller:8080/v1/AUTH_%\(project_id\)s
	openstack endpoint create --region North_VN object-store internal http://controller:8080/v1/AUTH_%\(project_id\)s
	openstack endpoint create --region North_VN object-store admin http://controller:8080/v1
	
	sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/swift/swift/proxy-server.conf 
	sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/swift/swift/proxy-server.conf 
	
	sed -i "s|SWIFT_PASS|${SWIFT_PASS}|g" /usr/share/docker/swift/swift/proxy-server.conf 
	sed -i "s|HASH_PATH_SUFFIX|${HASH_PATH_SUFFIX}|g" /usr/share/docker/swift/swift/swift.conf
	sed -i "s|HASH_PATH_SUFFIX|${HASH_PATH_PERFIX}|g" /usr/share/docker/swift/swift/swift.conf 



docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift   -v /etc/swift/:/etc/swift/ -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root  -e SWIFT_START='SWIFT_BOOTSTRAP' docker-registry:4000/swift_proxy_v6:q


	docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift  -v /etc/swift/:/etc/swift/  -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root  -e SWIFT_START='SWIFT_INITIAL_ACCOUNT_RINGS' -e  STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS=172.16.30.168   -e         DEVICE_NAME=xxx   -e  DEVICE_WEIGHT=100 docker-registry:4000/swift_proxy_v6:q
	docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift  -v /etc/swift/:/etc/swift/ -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='SWIFT_INITIAL_CONTAINER_RINGS'  -e  STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS=172.16.30.168   -e         DEVICE_NAME=xxx   -e  DEVICE_WEIGHT=100 docker-registry:4000/swift_proxy_v6:q
	docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift  -v /etc/swift/:/etc/swift/ -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='SWIFT_INITIAL_OBJECT_RINGS'  -e  STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS=172.16.30.168   -e         DEVICE_NAME=xxx   -e  DEVICE_WEIGHT=100 docker-registry:4000/swift_proxy_v6:q
		
	
	#Copy the account.ring.gz, container.ring.gz, and object.ring.gz files to the /etc/swift directory on each storage node and any additional nodes running the proxy service.



	docker run --network=host --privileged -v $VAR_LOG_DIR/swift:/var/log/swift -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u swift -e SWIFT_START='SWIFT_VERIFY' docker-registry:4000/swift_proxy:q
	
	docker run    --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift    -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='START_SWIFT_PROXY' docker-registry:4000/swift_proxy_v6:q
}


function install_swift_storage {
    yum install xfsprogs rsync
    mkfs.xfs /dev/sda
    # mkfs.xfs /dev/sdc
    mkdir -p /srv/node/sda
    # mkdir -p /srv/node/sdc
    /dev/sdb /srv/node/sda xfs noatime,nodiratime,nobarrier,logbufs=8 0 2
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

