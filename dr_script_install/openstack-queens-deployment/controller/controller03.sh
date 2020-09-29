#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}

#Import source 
	source password/passwd.env
	
# Sau khi da chay make_repo
#keystone
function install_keystone {
	docker pull docker-registry:4000/keystone:q 
	sed -i "s|MQ_KEYSTONE|${MQ_KEYSTONE}|g" sql/keystone.sql
	mysql  < sql/keystone.sql 

	sed -i "s|MQ_KEYSTONE|${MQ_KEYSTONE}|g" /usr/share/docker/keystone/keystone/keystone.conf
	

	detailtask "+Keystone BOOTSTRAP\n"
	docker run  --network=host  -u root -v /var/log/dir/apache2:/var/log/apache2  -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime --env-file="env.list" -e KEYSTONE_START='BOOTSTRAP' docker-registry:4000/keystone:q
	
	docker stop keystone;
	docker rm keystone;
	detailtask "+Create Docker Keystone Container\n"




	docker run  -d --name ssl_keystone_new1 --network=host  --restart unless-stopped -u root -v /u01/docker/docker_log/apache2:/var/log/apache2 -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime   -e KEYSTONE_START='START_KEYSTONE' docker-registry:4000/keystone_elas:qll

	


	cp ./open.rc /root/



	docker run -d --name horizon_ssl_v8 --network=host  -u root -v /var/log/docker/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e HORIZON_START='START_HORIZON' docker-registry:4000/ssl_horizon_v2:q




############################22112019################################
RUN apt-get update -y && apt-get -y install vim net-tools
RUN apt-get -y install iputils-ping
RUN apt-get -y install telnet 
RUN apt-get -y install python-elasticsearch
RUN pip install --upgrade pip 
RUN apt-get install -y python-openstackclient 
RUN pip install osprofiler


docker-registry:4000/ssl_keystone_api_ln:q
docker-registry:4000/ssl_glance_api_ln:q
docker-registry:4000/ssl_neutron_server_ln:q
docker-registry:4000/ssl_cinder_api_ln:q
docker-registry:4000/ssl_cinder_scheduler_ln:q
docker-registry:4000/ssl_nova_ln:q



docker run  -d --name ln_ssl_keystone --network=host  --restart unless-stopped -u root -v /u01/docker/docker_log/keystone:/var/log/apache2 -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime   -e KEYSTONE_START='START_KEYSTONE' --env-file  ./env.list   docker-registry:4000/ssl_keystone_api_ln:q


docker run -d --name ln_ssl_glance-api --network=host --restart unless-stopped -v /u01/docker/docker_log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_API' docker-registry:4000/ssl_glance_api_ln:q
	
docker run -d --name ln_ssl_glance-registry  --network=host --restart unless-stopped -v /u01/docker/docker_log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_REGISTRY' docker-registry:4000/ssl_glance_api_ln:q


# detailtask "+Create Cinder container\n"
docker run -d --name ln_ssl_cinder-api --network=host --restart unless-stopped -v /u01/docker/docker_log/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder -v /u01/docker/docker_log/apache2:/var/log/apache2  -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e CINDER_START='START_CINDER_API' docker-registry:4000/ssl_cinder_api_ln:q


docker run -d --name ln_ssl_cinder-scheduler --network=host --restart unless-stopped -v /u01/docker/docker_log/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder -v /u01/docker/docker_log/apache2:/var/log/apache2  -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e CINDER_START='START_CINDER_SCHEDULER' docker-registry:4000/ssl_cinder_scheduler_ln:q


docker run -d --name ln_ssl_nova-consoleauth --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_CONSOLEAUTH' docker-registry:4000/ssl_nova_ln:q
docker run -d --name ln_ssl_nova-api --network=host --privileged --restart unless-stopped -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_API' docker-registry:4000/ssl_nova_ln:q
docker run -d --name ln_ssl_nova-scheduler --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_SCHEDULER' docker-registry:4000/ssl_nova_ln:q
docker run -d --name ln_ssl_nova-conductor --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_CONDUCTOR' docker-registry:4000/ssl_nova_ln:q
docker run -d --name ln_ssl_nova-novncproxy --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_NOVNCPROXY' docker-registry:4000/ssl_nova_ln:q
docker run -d --name ln_ssl_nova-placement-api --network=host --restart unless-stopped --privileged -u root -v /u01/docker/docker_log/apache2:/var/log/apache2 -v /u01/docker/docker_log/nova/:/var/log/nova/ -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_PLACEMENT_API' docker-registry:4000/ssl_nova_ln:q

docker run -d --name ln_ssl_neutron-server --network=host --restart unless-stopped --privileged -v /u01/docker/docker_log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u neutron -e NEUTRON_START='START_NEUTRON_SERVER'  docker-registry:4000/ssl_neutron_server_ln:q





##################################################################







	sed -i "s|ADMIN_PASS|${ADMIN_PASS}|g" ~/open.rc

	detailtask "+Create Demo Project\n"
	source ~/open.rc
	openstack project create --domain default --description "Service Project" service
	openstack project create --domain default --description "Demo Project" demo
	openstack user create --domain default --password DEMO_PASS demo
	openstack role create user
	openstack role add --project demo --user demo user
}

#glance
function install_glance {
	# docker pull docker-registry:4000/glance:q
	# sed -i "s|MQ_GLANCE|${MQ_GLANCE}|g" sql/glance.sql
	# mysql < sql/glance.sql 

	detailtask "+Create glance service\n"
	source ~/open.rc
	openstack user create --domain default --password JBNpfryKwey6kcsditbd77LptDWEiZfD glance
	openstack role add --project service --user glance admin
	openstack service create --name glance  --description "OpenStack Image" image
	openstack endpoint create --region North_VN  image public https://controller:9292
	openstack endpoint create --region North_VN  image admin  https://controller:9292
	openstack endpoint create --region North_VN  image internal  https://controller:9292
	

 	detailtask "+Glance  BOOTSTRAP\n"
	docker run   --network=host -v /var/log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='BOOTSTRAP' docker-registry:4000/glance:q
	



	# detailtask "+Create Glance container\n"
	docker run -d --name ssl_glance-api --network=host --restart unless-stopped -v /u01/docker/docker_log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_API' docker-registry:4000/ssl_glance_v1:q
	




	docker run -d --name ssl_glance-registry --network=host --restart unless-stopped -v /u01/docker/docker_log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_REGISTRY' docker-registry:4000/ssl_glance_v1:q
	


	#openstack image create "rhel76_ping" --file rhel76_ping.img --disk-format raw --container-format bare --public
    #openstack image list

    openstack image create "cirros" --file  cirros-0.4.0-x86_64-disk.img --disk-format qcow2 --container-format bare --public
}


function install_cinder {
	# docker pull docker-registry:4000/cinder_api:q
	# docker pull docker-registry:4000/cinder_scheduler:q
	# sed -i "s|MQ_CINDER|${MQ_CINDER}|g" sql/cinder.sql
	# mysql < sql/cinder.sql 

	detailtask "+Create cinder service\n"
	source ~/open.rc
	openstack user create --domain default --password tdy0llhzHk2DnQbQcuXZ5KV4EUobdY3o cinder 
	openstack role add --project service --user cinder admin 
	openstack service create --name cinderv2 --description "OpenStack Block Storage" volumev2
	openstack service create --name cinderv3 --description "OpenStack Block Storage" volumev3
	openstack endpoint create --region North_VN  volumev2 public https://controller:8776/v2/%\(project_id\)s
	openstack endpoint create --region North_VN  volumev2 admin  https://controller:8776/v2/%\(project_id\)s
	openstack endpoint create --region North_VN  volumev2 internal  https://controller:8776/v2/%\(project_id\)s


UPDATE keystone.endpoint SET url = "http://controller:8776/v2/%\(project_id\)s" WHERE url="https://controller:8776/v2/%\(project_id\)s";



	openstack endpoint create --region North_VN  volumev3 public https://controller:8776/v3/%\(project_id\)s
	openstack endpoint create --region North_VN  volumev3 admin  https://controller:8776/v3/%\(project_id\)s
	openstack endpoint create --region North_VN  volumev3 internal  https://controller:8776/v3/%\(project_id\)s

UPDATE keystone.endpoint SET url = "http://controller:8776/v3/%\(project_id\)s" WHERE url="https://controller:8776/v3/%\(project_id\)s";



	# sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /usr/share/docker/cinder/cinder/cinder.conf
	# sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/cinder/cinder/cinder.conf
	# sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/cinder/cinder/cinder.conf 
	# sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /usr/share/docker/cinder/cinder/cinder.conf 
	# sed -i "s|MQ_CINDER|${MQ_CINDER}|g" /usr/share/docker/cinder/cinder/cinder.conf 
	# sed -i "s|CINDER_PASS|${CINDER_PASS}|g" /usr/share/docker/cinder/cinder/cinder.conf  
	
	

	# docker stop cinder-api
	# docker stop cinder-scheduler
	# docker rm cinder-api
	# docker rm cinder-scheduler

 	detailtask "+CINDER  BOOTSTRAP\n"
	docker run   --network=host -v /var/log/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u cinder -e CINDER_START='BOOTSTRAP' docker-registry:4000/cinder_scheduler:q
	
	# detailtask "+Create Cinder container\n"
	docker run -d --name ssl_cinder-api --network=host --restart unless-stopped -v /u01/docker/docker_log/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder -v /u01/docker/docker_log/apache2:/var/log/apache2  -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e CINDER_START='START_CINDER_API' docker-registry:4000/ssl_cinder_api_v1:q


	docker run -d --name ssl_cinder-scheduler --network=host --restart unless-stopped -v /u01/docker/docker_log/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder -v /u01/docker/docker_log/apache2:/var/log/apache2  -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e CINDER_START='START_CINDER_SCHEDULER' docker-registry:4000/ssl_cinder_scheduler_v1:q



	#openstack image create "cirros" --file  cirros-0.4.0-x86_64-disk.img --disk-format qcow2 --container-format bare --public
    #openstack image list
}

#nova
function install_nova {
	# docker pull docker-registry:4000/nova:q 
	# sed -i "s|MQ_NOVA|${MQ_NOVA}|g" sql/nova.sql 
	# mysql < sql/nova.sql 
	
	# detailtask "+Create nova service\n"
	# source ~/open.rc
	openstack user create --domain default --password CVVW5ThnUFuAXFCF3OLk1gj6atg9NB5m nova
	openstack role add --project service --user nova admin
	openstack service create --name nova --description "OpenStack Compute" compute
	openstack endpoint create --region North_VN compute public https://controller:8774/v2.1
	openstack endpoint create --region North_VN compute internal  https://controller:8774/v2.1
	openstack endpoint create --region North_VN compute admin https://controller:8774/v2.1
	
	detailtask "+Create placement service\n"
	openstack user create --domain default --password sQWRKWbkbB3RcmMT4aXe2lntXOIubGvj placement
	openstack role add --project service --user placement admin
	openstack service create --name placement --description "Placement API" placement
	openstack endpoint create --region North_VN placement public https://controller:8778
	openstack endpoint create --region North_VN placement internal  https://controller:8778
	openstack endpoint create --region North_VN placement admin  https://controller:8778
		
	# sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /usr/share/docker/nova/nova/nova.conf
	# sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/nova/nova/nova.conf
	# sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/nova/nova/nova.conf 
 # 	sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /usr/share/docker/nova/nova/nova.conf 
	# sed -i "s|MQ_NOVA|${MQ_NOVA}|g" /usr/share/docker/nova/nova/nova.conf 
	# sed -i "s|NOVA_PASS|${NOVA_PASS}|g" /usr/share/docker/nova/nova/nova.conf 
	# sed -i "s|PLACEMENT_PASS|${PLACEMENT_PASS}|g" /usr/share/docker/nova/nova/nova.conf 
	# sed -i "s|NEUTRON_PASS|${NEUTRON_PASS}|g" /usr/share/docker/nova/nova/nova.conf 
	# sed -i "s|METADATA_SECRET|${METADATA_SECRET}|g" /usr/share/docker/nova/nova/nova.conf
	


	# docker stop nova-api
	# docker stop nova-scheduler
	# docker stop nova-conductor
	# docker stop nova-novncproxy
	# docker stop nova-placement-api
	# docker rm nova-api
	# docker rm nova-scheduler
	# docker rm nova-conductor
	# docker rm nova-novncproxy
	# docker rm nova-placement-api
/etc/ssl/certs/ca-certificates.crt 


	detailtask "+Nova BOOTSTRAP\n"
	docker run  --network=host --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime --env-file="env.list" -e NOVA_START='BOOTSTRAP' docker-registry:4000/nova:q
	
	# detailtask "+Create Nova Container\n"
	docker run -d --name ssl_nova-consoleauth --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_CONSOLEAUTH' docker-registry:4000/ssl_nova_v1:q
	docker run -d --name ssl_nova-api --network=host --privileged --restart unless-stopped -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_API' docker-registry:4000/ssl_nova_v1:q
	docker run -d --name ssl_nova-scheduler --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_SCHEDULER' docker-registry:4000/ssl_nova_v1:q
	docker run -d --name ssl_nova-conductor --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_CONDUCTOR' docker-registry:4000/ssl_nova_v1:q
	docker run -d --name ssl_nova-novncproxy --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_NOVNCPROXY' docker-registry:4000/ssl_nova_v1:q
	docker run -d --name ssl_nova-placement-api --network=host --restart unless-stopped --privileged -u root -v /u01/docker/docker_log/apache2:/var/log/apache2 -v /u01/docker/docker_log/nova/:/var/log/nova/ -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_PLACEMENT_API' docker-registry:4000/ssl_nova_v1:q
	
	#openstack compute service list --service nova-compute
}

#neutron
function install_neutron_server {	
	# docker pull docker-registry:4000/neutron:q 
	# sed -i "s|MQ_NEUTRON|${MQ_NEUTRON}|g" sql/neutron.sql 
	# mysql < sql/neutron.sql 
	
	detailtask "+Create neutron project\n"
	source ~/open.rc
	openstack user create --domain default --password ATqCSRFyZs28lOUHdAmzSxtSN7jht2bL neutron
	openstack role add --project service --user neutron admin
	openstack service create --name neutron --description "OpenStack Networking" network
	openstack endpoint create --region North_VN network public https://controller:9696
	openstack endpoint create --region North_VN network internal  https://controller:9696
	openstack endpoint create --region North_VN network admin  https://controller:9696
	


	# sed -i "s|TRANSPORT_URL|${TRANSPORT_URL}|g" /usr/share/docker/neutron/neutron/neutron.conf
	# sed -i "s|MEMCACHED_SERVERS|${MEMCACHED_SERVERS}|g" /usr/share/docker/neutron/neutron/neutron.conf
	# sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/neutron/neutron/neutron.conf 
 # 	sed -i "s|RB_OPENSTACK|${RB_OPENSTACK}|g" /usr/share/docker/neutron/neutron/neutron.conf 
	# sed -i "s|MQ_NEUTRON|${MQ_NEUTRON}|g" /usr/share/docker/neutron/neutron/neutron.conf 
	# sed -i "s|NOVA_PASS|${NOVA_PASS}|g" /usr/share/docker/neutron/neutron/neutron.conf 
	# sed -i "s|NEUTRON_PASS|${NEUTRON_PASS}|g" /usr/share/docker/neutron/neutron/neutron.conf
	
	# sed -i "s|MY_IP|${MY_IP}|g" /usr/share/docker/neutron/neutron/plugins/ml2/openvswitch_agent.ini
	# sed -i "s|METADATA_SECRET|${METADATA_SECRET}|g" /usr/share/docker/neutron/neutron/metadata_agent.ini
	
	
	# docker stop neutron-server
	# docker rm neutron-server

	detailtask "+Neutron BOOTSTRAP\n"
	docker run --network=host --privileged -v /var/log/docker/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u neutron -e NEUTRON_START='BOOTSTRAP' docker-registry:4000/neutron:q
	
	# detailtask "+Create Neutron Container\n"
	docker run -d --name ssl_neutron-server --network=host --restart unless-stopped --privileged -v /u01/docker/docker_log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u neutron -e NEUTRON_START='START_NEUTRON_SERVER'  docker-registry:4000/ssl_neutron_v1:q




}

#horizon
function install_horizon {
	docker pull docker-registry:4000/horizon:q
		
	docker stop horizon
	docker rm horizon
	docker run -d --name ssl_horizon_v8 --network=host --restart unless-stopped -u root -v /u01/docker/docker_log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e HORIZON_START='START_HORIZON' docker-registry:4000/ssl_horizon_v1:q


	#django
		docker run -d --name ssl_horizon_v8 --network=host --restart unless-stopped -u root -v /u01/docker/docker_log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e HORIZON_START='START_HORIZON' docker-registry:4000/ssl_horizon_django_v1:q
}





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



docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift   -v /etc/swift/:/etc/swift/ -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root  -e SWIFT_START='SWIFT_BOOTSTRAP' docker-registry:4000/swift_proxy_v3:q


	docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift  -v /etc/swift/:/etc/swift/  -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root  -e SWIFT_START='SWIFT_INITIAL_ACCOUNT_RINGS' -e  STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS=172.16.30.168   -e         DEVICE_NAME=xxx   -e  DEVICE_WEIGHT=100 docker-registry:4000/swift_proxy_v3:q
	docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift  -v /etc/swift/:/etc/swift/ -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='SWIFT_INITIAL_CONTAINER_RINGS'  -e  STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS=172.16.30.168   -e         DEVICE_NAME=xxx   -e  DEVICE_WEIGHT=100 docker-registry:4000/swift_proxy_v3:q
	docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift  -v /etc/swift/:/etc/swift/ -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='SWIFT_INITIAL_OBJECT_RINGS'  -e  STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS=172.16.30.168   -e         DEVICE_NAME=xxx   -e  DEVICE_WEIGHT=100 docker-registry:4000/swift_proxy_v3:q
		
	
	#Copy the account.ring.gz, container.ring.gz, and object.ring.gz files to the /etc/swift directory on each storage node and any additional nodes running the proxy service.



	docker run --network=host --privileged -v $VAR_LOG_DIR/swift:/var/log/swift -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u swift -e SWIFT_START='SWIFT_VERIFY' docker-registry:4000/swift_proxy:q
	
	docker run    --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift    -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='START_SWIFT_PROXY' docker-registry:4000/swift_proxy_v6:q
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
		
		
		
		
		
		
		
		
		
