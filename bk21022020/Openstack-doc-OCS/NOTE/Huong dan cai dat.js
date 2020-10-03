Huong dan cai dat :
	
1. Sua file controller/env.list || compute/env.list
	KEYSTONE_START=BOOTSTRAP

	# Sua thanh dia chi cua OS-CONTROLLER
	CONTROLLER_HOST=os-controller 

	#Sua thanh admin_password
	ADMIN_PASS=Vttek@123
	REGION_NAME=North_VN
	CELL_NAME=cell1

2. Sua file controller/password/passwd.env || compute/passwd.env

	#sed -i "s|NAME|${NAME}|g" /etc/X.conf

	KEYSTONE_START=BOOTSTRAP

	#Sua thanh dia chi cua OS-CONTROLLER
	CONTROLLER_HOST=os-controller

	#Sua thanh dia chi HOST de bind mysql
	HOST=controller01 #host-ip bind mysql
	
	#Sua theo ADMIN_PASS da dat o tren 
	ADMIN_PASS=Vttek@123
	REGION_NAME=North_VN
	CELL_NAME=cell1


	#Dia chi IP dung cho dai mang API
	MY_IP=172.16.30.166 #host-ip bind nova-api, neutron-server
	

	#rabbitmq
	RB_OPENSTACK=KFTA8eHMgiX4DDUcCKSsoTpZFGnCoBrA

	#keystone
	#PASSWORD cho cac User trong Openstack
	DEMO_PASS=Vttek@123
	GLANCE_PASS=Vttek@123_glance
	NOVA_PASS=Vttek@123_nova
	PLACEMENT_PASS=Vttek@123_placement
	NEUTRON_PASS=Vttek@123_neutron
	METADATA_SECRET=Vttek@123_metadata

	#mysql
	#PASSWORD cho mysql
	MQ_GLANCE=Tl1bMfzOdSJYi9HZx2ic47rxbPKPXk4q
	MQ_KEYSTONE=LybBmiQk2t0djlrNf2zLrR1vjih4LrZK
	MQ_NOVA=o45OyDJ9b5jvD4fJzUBcLQI9qH4GrYUh
	MQ_NEUTRON=3fjWwEnE803MWeq4hJOE23GPQAgEDVc8

3. Sua file chrony.conf, /etc/hosts, /etc/hostname

3. Tren ca controller va compute chay 
	bash make_repo/make_repo.sh

4. Tren cac controller node chay:  
	cd controller

	-- Buoc 1: Cai dat cac backend: 
		source back_end.sh; main_backend_controller
		+ Lan luot cai dat:
			- python-openstackclient
			- docker
			- chrony
			- rabbitmq
			- memcached
		** Lua chon 0 de chay het 1 lan 

	//Sau khi da cai du back_end.sh tren 3 controller node : controller01, controller02, controller03

	-- Buoc 2: Cai dat haproxy
		** Tien hanh cai dat ha_backend
		source back_end_ha.sh;	main_backend_ha_controller
		+ Lan luot cai dat:
			- rabbitmq-cluster
				+ rabbitmq sync tren node controller01
				+ rabbitmq join tren node controller02, controller03
			- perconadb-cluster

			- haproxy
			- keepalived 
			-
	-- Buoc 3: Cai dat cac service openstack 
	 	** Cai dat cho HUB CONTROLLER 
		source controller_01.sh; main_controller
		+ Lan luot cai dat:
			- keystone
			- glance 
			- nova 
			- neutron 
			- horizon
			- cinder
	-- Buoc 4: Cai dat cac service openstack 
		** Cai dat cho backup controller
		source controller_02.sh; main_controller
		+ Lan luot cai dat:
			- keystone
			- glance 
			- nova 
			- neutron 
			- horizon
			- cinder
		** Lua chon 0 de chay het 1 lan



5. Tren cac compute node chay:  
	cd compute
	source backend.sh; main_backend_compute

		** Lua chon 0 de chay het 1 lan 

	source compute.sh; main_compute
	
		** Lua chon 0 de chay het 1 lan


	source compute.sh; install_neutron
	source compute.sh; start_neutron




TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=none
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=em1
UUID=61added2-eafd-4050-9875-645a737be342
DEVICE=em1
ONBOOT=yes
IPADDR=172.16.30.82
PREFIX=24
GATEWAY=172.16.30.254



TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=none
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=p1p1
UUID=5b49fc2f-5a2c-4d1d-86cf-41a44410decc
DEVICE=p1p1
ONBOOT=yes
IPADDR=172.16.32.82
PREFIX=24
NETMASK=255.255.255.0





