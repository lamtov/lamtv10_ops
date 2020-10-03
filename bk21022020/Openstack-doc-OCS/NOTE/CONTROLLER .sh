CONTROLLER .sh 


Node 			IP – DCN 		IP – MPBN 		IP – INTERNAL 	IP – CEPH
controller01 	172.16.30.168 	10.10.1.168 	
	
controller02 	172.16.30.169 	10.10.1.169 	
	
controller03 	172.16.30.170 	10.10.1.170 	
	
compute01 		172.16.30.171 	10.10.1.171 	10.10.2.171 	10.10.3.171
compute02 		172.16.30.172 	10.10.1.172 	10.10.2.172 	10.10.3.172
ceph01 			172.16.30.173 	10.10.1.173 	10.10.3.173
ceph02 			172.16.30.174 	10.10.1.174 	10.10.3.174
ceph03 			172.16.30.175 	10.10.1.175 	10.10.3.175
registry 		172.16.30.82 	10.10.1.82 	
	
repository 		172.16.30.89 	
	

  ifconfig 
 1996  ip link  show 
 1997  ifconfig ens17 10.10.1.82/24
 1998  route -n
 1999  route add default gw 172.16.30.254


 scp -r root@172.16.30.171:/root/rdo-release-rocky-0.noarch.rpm
 scp -r root@172.16.30.171:/etc/yum.repos.d/* ./

****************

loi chu hoa chu thuong




****************



 1799  cd /var/www/html/
 1800  ll
 1801  ln -s /repo/centos centos 
 1802  ll
 1803  ln -s /repo/epel7server/ epel7server
 1804  ll
 1805  locate docker-py
 1806  cd /repo/pip/
 1807  ll
 1808  pip --help
 1809  pip install --help
 1810  pip install python-py
 1811  echo $LC_ALL
 1812  exit
 1813  locate setuptoo;s
 1814  locate setuptools
 1815  localte setuptools.tar.gz
 1816  locate setuptools.tar.gz
 1817  find /repo/ -type f -name "*setup*"
 1818  locate setuptools-40.6.3.zip




[docker]
name=docker
baseurl=http://172.16.30.89/docker.centos.7.x86_64
enabled=1
gpgcheck=0


************************************ FIX REPO FOR ROCKY IN redhat ****************
wget -r --no-parent 

####################   rdo-qemu-ev.repo  ########################################

[rdo-qemu-ev]
name=RDO CentOS-7 - QEMU EV
#baseurl=http://mirror.centos.org/centos/7/virt/x86_64/kvm-common/
baseurl=http://172.16.30.89/centos.7.virt.x86_64.kvm-common/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-Virtualization-RDO

[rdo-qemu-ev-test]
name=RDO CentOS-7 - QEMU EV Testing
#baseurl=http://buildlogs.centos.org/centos/7/virt/x86_64/kvm-common/
baseurl=http://172.16.30.89/buildlogs.centos.7.virt.x86_64.kvm-common/
gpgcheck=0
enabled=0

#####***********************************************************************###



####################   rdo-release.repo ######################################

[openstack-rocky]
name=OpenStack Rocky Repository
#baseurl=http://mirror.centos.org/centos/7/cloud/x86_64/openstack-rocky/
baseurl=http://172.16.30.89/centos.7.cloud.x86_64.openstack-rocky/                           $$$$$$$$$$$$$$$$$$
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-Cloud



#####****************************************************************########


##########################    rdo-testing.repo   ############################

[openstack-rocky-testing]
name=OpenStack Rocky Testing
#baseurl=https://buildlogs.centos.org/centos/7/cloud/$basearch/openstack-rocky/
baseurl=https://172.16.30.89/buildlogs.centos.7.cloud.x86_64.openstack-rocky/                   $$$$$$$$$$$$
gpgcheck=0
enabled=1

[rdo-trunk-rocky-tested]
name=OpenStack Rocky Trunk Tested
#https://trunk.rdoproject.org/centos7-rocky/current-passed-ci/
baseurl=https://172.16.30.89/trunk.centos7-rocky.current-passed-ci/
gpgcheck=0
enabled=0

######****************************************************************#######




























****************************************************************************************






-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAvBkRmRs/orn00Do8w0/DVLDB2g38YR5nZCkKTROMOeAl1Hq8
bXLWF0Fvzg7IGGf4ZPJq8Am6MLDN6Bk3lSMuAkL+rZLctpCGkct0BXEes+Eslt9R
3V+xIK8ctqPJZoZ/FT29L6AZCiAD/BLTrlWwJi39GW3HF5E0t7PEZYB3Y97Y096T
ohZ8Fp/Hh5WcislPh/1+Vd1uWHQVnkvgqhMGYjS3UG4Gelt3NPik11pEYLqB9CSb
fyyqLAHTsEQ8rG356HBV7WROpzsPdtsbsSuoxVP4H3tzhAfBYVRS8+lmkEpmxMCV
SQZfRdXf8OTKMdoGlz0w0M/+vf8bJtftj3Xa2QIDAQABAoIBAHYQhitEHz1U24WY
CGvPtRuDlyn3fWK4Ys1LtVuL2Yi6WQR1xbAtVJRkTnlYbeBj4lX6k4T3lhbZ42S7
71d9LXPd+V2ZwVAWh2EcA0cnKc5emE5a/lelqNiLEcrSI6hm433Bsu4h35WrYtTm
PFhBEL/mPeeoMD9qtVxZSf0sFcRpFyz7TROiZR7cA+g/QWiP8j1MsIRH6BQiLQar
rX1AAuRuxYhgIwBS60O0rybU82g43GmpnD/zAnSZAozded6f2Cq3anjpYa4o4JcN
ObD2tgIqkSyIa9Io1ineDr9oixVq/0wDSH9dxnnk14BDIwkf8pM2+09/YUa/o3gd
2s5woAECgYEA9OdpReKXsauO8NaZTuxOEWzfeqQ5jd8Du6LaSvM9wazI/r7z0sdw
olhOrAm/SgRhWxIrrT5VVD3H76pWY/4pyXcTl0g16qFvcmf/RRHdtJuBcI22Wy4p
Hr+7wzkUUmgMasnxXzGjUPP40tsIrZvaERiSIUxDKLxVqwebGBrip0ECgYEAxJ7G
ymtCsbduOFhYvuIumrmkjMx44mQRDcEjyweAiBdjsXREdjXRXlRzFwBclQONmPoI
B2KzRoyS9ptJgqy2WzFwhvt8fSrevThk2FOHEJX0Q4R3k3C5pGgd1b6rl2fuMpno
33J0185bmUBPmEcewOapYId4hLesj4nfBMZzpZkCgYBHrVb9UjVNlcWPLW/PTpAG
v5OkxF3n7OadyysSlqBzh8uH64FXJnILwca8yVmII0IPMoFAAiddMXvL5FHGkEPQ
qB4+v66wDjGdDV0D7RezXXQD6iX+B8OXMUyV9aXB/JvtwU74qoF/FvizVdHzZdLs
AAH85uIdEQoNtXsqEexWQQKBgEqrpgFPtNd7Ox+o5aMwkNRv9j8GlE4eBJ/9npNH
eRe2EkVdS3a9P5McbUzp9T8eR1M2eYAcissbLeD73nIDF4oQf5Szw3Zhpo+j8CB7
sEqrOEW/9A2JfOckJ1h6ff4VGVAcRWU+uYMPupe75b6GG/bUYrTnHe0BOEaW7JyK
pXbZAoGBAIGq+KBijeaQj7aGcSpBqx0/qb/KZNtQgxBmSPN2CGgLRt87hvTzu/jG
iCftJiRr2WZiooxeY5Hzkt85LxtKqJveHU8veXohdWMQhTLDru/mgOnCM9rI/xfO
WJKOfhUWmVB6goPbf6QjurN8SXDfsdlEqA/fR8lIXkm5J5SXfQos
-----END RSA PRIVATE KEY-----




https://docs.openstack.org/install-guide/environment-messaging-ubuntu.html
https://docs.openstack.org/queens/install/
INSTALL DOCKER

ENV https_proxy=https://172.16.30.81:3128
ENV http_proxy=http://172.16.30.81:3128



			 1273  apt update
			 1274  curl -fsSL  https://get.docker.com -o get-docker.sh
			 1275  sudo sh get-docker.sh
			 1276  export https_proxy=https://172.16.30.81:3128
			 1277  export http_proxy=http://172.16.30.81:3128
			 1278  sudo sh get-docker.sh
			 1279  sh get-docker.sh



			 vim /etc/systemd/system/docker.service.d/http-proxy.conf 
			[Service]
			Environment="HTTP_PROXY=http://172.16.30.81:3128/" "NO_PROXY=172.16.30.0/24"



** Install docker-compose
			sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
			sudo chmod +x /usr/local/bin/docker-compose
			$ docker-compose --version
			docker-compose version 1.23.1, build 1719ceb







Enable the Ubuntu Cloud Archive pocket as needed¶
					OpenStack Rocky for Ubuntu 18.04 LTS:

					# apt install software-properties-common
					# add-apt-repository cloud-archive:rocky
					OpenStack Queens for Ubuntu 16.04 LTS:

		apt install software-properties-common
		add-apt-repository cloud-archive:queens
					OpenStack Pike for Ubuntu 16.04 LTS:

		 * apt install software-properties-common
		 * add-apt-repository cloud-archive:pike
					 Note

					For a full list of supported Ubuntu OpenStack releases, see “Ubuntu OpenStack release cycle” at https://www.ubuntu.com/about/release-cycle.

					Finalize the installation¶
					Upgrade the packages on all nodes:

					# apt update && apt dist-upgrade
					 Note

					If the upgrade process includes a new kernel, reboot your host to activate it.

					Install the OpenStack client:

					# apt install python-openstackclient


		--- Chu y phai cai dat theo file initservice.sh




		/home/vttek/Downloads/Tai lieu van hanh Openstack ANM(2)/openstack-docs-and_scripts/ops_container_deployment/openstack-client


INSTALL BASE

			

			 apt-get update \
			    && apt-get -y upgrade \
			    && apt-get -y dist-upgrade \
			    && apt-get -y install --no-install-recommends \
			        apt-utils \
			        curl \
			        gawk \
			        iproute2 \
			        kmod \
			        lvm2 \
			        netbase \
			        open-iscsi \
			        python \
			        python-memcache \
			        git \
			        python-pip \
			        python-pymysql \
			        sudo \
			        nano \
			        tgt \
			    && apt-get clean



			 apt-get install -y --no-install-recommends software-properties-common

			#Add openstack pike packages
			#COPY ubuntu_cloud_archive_canonical_com_ubuntu.list /etc/apt/sources.list.d/
 			apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 391A9AA2147192839E9DB0315EDB1B62EC4926EA

 			apt-get -y update && apt-get -y dist-upgrade


 			\\\\\\\\ BASE:QUEENS 
 		
 			docker build -t base:queens --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 . 


 				docker build -t base:R --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 .
			Finalize the installation¶
			Upgrade the packages on all nodes:

			# apt update && apt dist-upgrade
			 Note

			If the upgrade process includes a new kernel, reboot your host to activate it.

			Install the OpenStack client:

			# apt install python-openstackclient


#############################################
##############################################


		INSTALL ENVIRONMENT : https://docs.openstack.org/install-guide/environment.html

###########################################

INSTALL MARIADB 


		*******************https://docs.openstack.org/install-guide/environment-sql-database-rdo.html

		 apt install mariadb-server python-pymysql
		 service mysql restart


		 yum install mariadb mariadb-server python2-PyMySQL
		systemctl start mariadb


		 	Create and edit the /etc/mysql/mariadb.conf.d/99-openstack.cnf file and complete the following actions:

			Create a [mysqld] section, and set the bind-address key to the management IP address of the controller node to enable access by other nodes via the management network. Set additional keys to enable useful options and the UTF-8 character set:

			[mysqld]
			bind-address = 172.16.30.82

			default-storage-engine = innodb
			innodb_file_per_table = on
			max_connections = 4096
			collation-server = utf8_general_ci
			character-set-server = utf8
			Finalize installation¶
			Restart the database service:

			# service mysql restart










		    MariaDB [(none)]> create database keystone;
			Query OK, 1 row affected (0.00 sec)

			MariaDB [(none)]> grant all privileges on keystone.* to 'keystone'@'localhost' identified by 'LybBmiQk2t0djlrNf2zLrR1vjih4LrZK';
			Query OK, 0 rows affected (0.00 sec)

			MariaDB [(none)]> grant all privileges on keystone.* to 'keystone'@'%' identified by 'LybBmiQk2t0djlrNf2zLrR1vjih4LrZK';
			Query OK, 0 rows affected (0.00 sec)

			MariaDB [(none)]> exit



			***CHECK BY: 			ss -lntp | grep 3306


			Create and edit the /etc/my.cnf.d/openstack.cnf file (backup existing configuration files in /etc/my.cnf.d/ if needed) and complete the following actions:

			Create a [mysqld] section, and set the bind-address key to the management IP address of the controller node to enable access by other nodes via the management network. Set additional keys to enable useful options and the UTF-8 character set:

			[mysqld]
			bind-address = 10.0.0.11

			default-storage-engine = innodb
			innodb_file_per_table = on
			max_connections = 4096
			collation-server = utf8_general_ci
			character-set-server = utf8


Start the database service and configure it to start when the system boots:

 systemctl enable mariadb.service
 systemctl start mariadb.service
Secure the database service by running the mysql_secure_installation script. In particular, choose a suitable password for the database root account:

 mysql_secure_installation





INSTALL PERCONADB
		
		yum install Percona-XtraDB-Cluster-57

		service mysql start

		// C

INSTALL NETTIMEPROTOCOL
		yum install chrony

		vim /etc/chrony
		server NTP_SERVER iburst
		allow 10.0.0.0/24 //tai server


INSTALL RABBITMQ
		yum install rabbitmq-server

		systemctl enable rabbitmq-server.service
		
		systemctl start rabbitmq-server.service


		rabbitmqctl add_user openstack KFTA8eHMgiX4DDUcCKSsoTpZFGnCoBrA //RABBITMQ_PASS

		rabbitmqctl set_permissions openstack ".*" ".*" ".*"



INSTALL memcached_servers


			apt install memcached python-memcache


			Edit the /etc/memcached.conf file and configure the service to use the management IP address of the controller node. This is to enable access by other nodes via the management network:

			-l 10.0.0.11
			 Note

			Change the existing line that had -l 127.0.0.1




			yum install memcached python-memcached

			Edit the /etc/sysconfig/memcached file and complete the following actions:

			Configure the service to use the management IP address of the controller node. This is to enable access by other nodes via the management network:

			OPTIONS="-l 127.0.0.1,::1,controller"
			 Note

			Change the existing line OPTIONS="-l 127.0.0.1,::1".



			systemctl enable memcached.service
			 systemctl start memcached.service


			 	***  CHAY CHAM> STUCK TAI Starting new HTTP connection (1): os-controller
http://os-controller:9292 "GET /v2/images HTTP/1.1" 200 932
 			====> Kiem tra memcached

sudo docker run -d -t -i -e REDIS_NAMESPACE='staging' \ 
-e POSTGRES_ENV_POSTGRES_PASSWORD='foo' \
-e POSTGRES_ENV_POSTGRES_USER='bar' \
-e POSTGRES_ENV_DB_NAME='mysite_staging' \
-e POSTGRES_PORT_5432_TCP_ADDR='docker-db-1.hidden.us-east-1.rds.amazonaws.com' \
-e SITE_URL='staging.mysite.com' \
-p 80:80 \
--link redis:redis \  
--name container_name dockerhub_id/image_name
Or, if you don't want to have the value on the command-line where it will be displayed by ps, etc., -e can pull in the value from the current environment if you just give it without the =:

sudo PASSWORD='foo' docker run  [...] -e PASSWORD [...]
If you have many environment variables and especially if they're meant to be secret, you can use an env-file:

$ docker run --env-file ./env.list ubuntu bash
The --env-file flag takes a filename as an argument and expects each line to be in the VAR=VAL format, mimicking the argument passed to --env. Comment lines need only be prefixed with #




INSTALL KEYSTONE:


			SETUP KEYSTONE in db

				Use the database access client to connect to the database server as the root user:

				connection = mysql+pymysql://keystone:LybBmiQk2t0djlrNf2zLrR1vjih4LrZK@os-controller/keystone //////////////////// theo file keystone.conf 


				# mysql
				Create the keystone database:

				MariaDB [(none)]> CREATE DATABASE keystone;
				Grant proper access to the keystone database:

				MariaDB [(none)]> GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'LybBmiQk2t0djlrNf2zLrR1vjih4LrZK';
				MariaDB [(none)]> GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'LybBmiQk2t0djlrNf2zLrR1vjih4LrZK';




				***** Loi so 1: Su dung -v -v /usr/share/docker/keystone:/usr/share/docker/keystone -P  ====> Dung file share va port share, dung -P khi ben trong da co EXPOSE port ==> dung --network=hosts 

				***** Loi so 2: Bo xung ENV SHARED_CONF_DIR /usr/share/docker
				
				***** Loi so 3: EXPOSE 5000 35357 va run -P
				
				***** Loi so 4: cp -r ${SHARED_CONF_DIR}/${SERVICE}/hosts /etc/hosts Trong file copy.sh phai bo xung phan /etc/hosts 
				
				***** Loi so 5: Phai tu tao cac thu muc nhu /usr/share/docker/keystone/backup va chuyen cac file ve thu muc /usr/share/docker/keystone..

				***** Loi so 6: Phai dung base queens (docker image base:q) thi luc cai moi ra phien ban queens

				***** Loi so 7: VERSION Keystone tu queens tro di se bo port 35357 ====> chuyen het 35357 trong cac file cau hinh ve 5000

				***** Loi so 8: Bo xung vao cac file Docker_file: RUN apt-get update && apt-get -y install --no-install-recommends apache2 keystone libapache2-mod-wsgi vim net-tools



 				docker build -t nova:q --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 . 

 				docker build -t keystone:R --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 . 






				docker run  --env-file env.list -v /usr/share/docker/keystone:/usr/share/docker/keystone -P keystone:queens 




****Loi IOError: [Errno 2] No usable temporary directory found in ['/tmp', '/var/tmp', '/usr/tmp', '/home/noiv'] do full disk




#docker run   --network=host -u root -v /var/log/apache2:/var/log/apache2 -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e KEYSTONE_START='DBCHECK' docker-registry:4000/keystone:r



#docker run -d --name keystone  --restart unless-stopped -u root -v /var/log/apache2:/var/log/apache2 -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e KEYSTONE_START='START_KEYSTONE' docker-registry:4000/keystone:q






#docker run --name glance-api_test  -v /var/log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_API' glance:q





				cp -r /etc/${SERVICE} ${SHARED_CONF_DIR}/${SERVICE}/backup/${SERVICE}-$(date +%Y%m%d-%H%M%S)


				docker run  --env-file envfile.txt -v /usr/share/docker/keystone:/usr/share/docker/keystone -P keystone:queens
				


				docker run   --network=host  -u root -v /var/log/apache2:/var/log/apache2  -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime --env-file="env.list" -e KEYSTONE_START='BOOTSTRAP' docker-registry:4000/keystone:R
				


				docker run  --name keystone --network=host --restart unless-stopped -u root -v /var/log/apache2:/var/log/apache2 -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e KEYSTONE_START='START_KEYSTONE' docker-registry:4000/keystone:R



				docker run -d --name keystone




				--network=host 
				-u root
				-v /var/log/apache2:/var/log/apache2 
				-v /etc/keystone/credential-keys:/etc/keystone/credential-keys 
				-v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys 
				-v /usr/share/docker/:/usr/share/docker/ 
				-v /etc/localtime:/etc/localtime 
				--env-file="./general.env" 
				-e KEYSTONE_START='BOOTSTRAP' 
				ops-services-registry:4000/keystone:<tag>




						-p 5000:5000 




				[keystone_authtoken]
				auth_uri = http://os-controller:5000
				auth_url = http://os-controller:35357
				auth_type = password
				project_domain_name = Default
				user_domain_name = Default
				project_name = service
				username = nova
				password = 2md1gLgBXezyJjo2YNVtZMnu5YNhRVT2
				memcached_servers = controller01:11211,controller02:11211,controller03:11211

********************************************

export OS_PROJECT_DOMAIN_NAME=Default
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=qeokZAEsIltfykEf6hEyehDopG6680lw
export OS_AUTH_URL=http://os-controller:5000
export OS_IDENTITY_API_VERSION=3

openstack project create --domain default --description "Service Project" service
openstack project create --domain default --description "Demo Project" lamtv
openstack user create --domain default --password-prompt lamtv
openstack role create user
openstack role add --project lamtv --user lamtv user

 keystone-manage bootstrap --bootstrap-password Vttek@123 \
  --bootstrap-admin-url http://os-controller:5000/v3/ \
  --bootstrap-internal-url http://os-controller:5000/v3/ \
  --bootstrap-public-url http://os-controller:5000/v3/ \
  --bootstrap-region-id North_VN











INSTALL NOVA ON CONTROLLER
					FROM base:q
					MAINTAINER lamtv@viettel.com.vn

					LABEL openstack_version="queens"
					ENV DEBIAN_FRONTEND noninteractive
					ENV SERVICE nova
					ENV SHARED_CONF_DIR /usr/share/docker

					#Clear cache apt
					RUN apt-get clean \
					    && rm -rf /var/lib/apt/lists/* \
					    && apt-get update -y

					#install nova server
					RUN apt-get update -y \
					  && apt-get -y install --no-install-recommends nova-api nova-conductor nova-consoleauth nova-novncproxy nova-scheduler nova-placement-api apache2 libapache2-mod-wsgi \
					  && apt-get clean

					#copy sudoer file
					COPY nova_sudoers /etc/sudoers.d/nova_sudoers

					#copy script
					COPY copy_file.sh /usr/local/bin/copy_file.sh
					COPY start.sh /usr/local/bin/start.sh
					RUN chmod +x /usr/local/bin/*.sh

					#config apache2 for placement-api
					RUN a2dissite 000-default.conf \
					  && echo > /etc/apache2/ports.conf \
					  && echo ServerName localhost >> /etc/apache2/apache2.conf

					VOLUME ["/var/log/nova", "/var/lib/nova", "/var/log/apache2"]

					EXPOSE 8774 8775 6080 8778

					USER nova

					CMD ["start.sh"]

		https://docs.openstack.org/nova/queens/install/controller-install-ubuntu.html


		# mysql
		Create the nova_api, nova, and nova_cell0 databases:

		MariaDB [(none)]> CREATE DATABASE nova_api;
		MariaDB [(none)]> CREATE DATABASE nova;
		MariaDB [(none)]> CREATE DATABASE nova_cell0;
		MariaDB [(none)]> CREATE DATABASE placement;
		Grant proper access to the databases:

		MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' IDENTIFIED BY 'o45OyDJ9b5jvD4fJzUBcLQI9qH4GrYUh';
		MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' IDENTIFIED BY 'o45OyDJ9b5jvD4fJzUBcLQI9qH4GrYUh';

		MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost'  IDENTIFIED BY 'o45OyDJ9b5jvD4fJzUBcLQI9qH4GrYUh';
		MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' IDENTIFIED BY 'o45OyDJ9b5jvD4fJzUBcLQI9qH4GrYUh';

		MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'localhost' IDENTIFIED BY 'o45OyDJ9b5jvD4fJzUBcLQI9qH4GrYUh';
		MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'%' IDENTIFIED BY 'o45OyDJ9b5jvD4fJzUBcLQI9qH4GrYUh';

		MariaDB [(none)]> GRANT ALL PRIVILEGES ON placement.* TO 'nova'@'localhost' IDENTIFIED BY 'o45OyDJ9b5jvD4fJzUBcLQI9qH4GrYUh';
		MariaDB [(none)]> GRANT ALL PRIVILEGES ON placement.* TO 'nova'@'%' IDENTIFIED BY 'o45OyDJ9b5jvD4fJzUBcLQI9qH4GrYUh';


		openstack user create --domain default --password-prompt nova
		User Password: 
		Vttek@123_nova

		openstack role add --project service --user nova admin


		openstack service create --name nova --description "OpenStack Compute" compute
		openstack endpoint create --region North_VN compute public http://os-controller:8774/v2.1
		openstack endpoint create --region North_VN compute internal  http://os-controller:8774/v2.1
		openstack endpoint create --region North_VN compute admin http://os-controller:8774/v2.1


		openstack user create --domain default --password-prompt placement
		Vttek@123_placement



		openstack role add --project service --user placement admin
		openstack service create --name placement --description "Placement API" placement
		openstack endpoint create --region North_VN placement public http://os-controller:8778
		openstack endpoint create --region North_VN placement internal  http://os-controller:8778
		openstack endpoint create --region North_VN placement admin  http://os-controller:8778



		username = nova
		password = Vttek@123_nova

		username = placement
		password = Vttek@123_placement

		username = neutron
		password = Vttek@123_neutron





	---------------------------------------------
	docker build -t nova:R --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 .
	docker run  --network=host --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime --env-file="env.list" -e NOVA_START='BOOTSTRAP' docker-registry:4000/nova:R





### Run Nova api
```
docker run  --name nova-api --network=host --privileged --restart unless-stopped -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_API' docker-registry:4000/nova:R




### Run Nova scheduler
```
docker run -d --name nova-scheduler --network=host --restart unless-stopped --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_SCHEDULER' docker-registry:4000/nova:R



```




	### Run Nova conductor
```
docker run -d --name nova-conductor --network=host --restart unless-stopped --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_CONDUCTOR' docker-registry:4000/nova:R





### Run Nova consoleauth
```
###bo o rocky ###docker run -d --name nova-consoleauth --network=host --restart unless-stopped --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_CONSOLEAUTH' nova:q




### Upgrade nova at controller
```
docker run -d --network=host --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='UPGRADE' nova:q



```



******************************

Phai cap quyen cho /etc/nova 
****************************





```



### Run Nova novncproxy
```
docker run -d --name nova-novncproxy --network=host --restart unless-stopped --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_NOVNCPROXY' docker-registry:4000/nova:R



```


### Run Nova placement api
```
docker run -d --name nova-placement-api --network=host --restart unless-stopped --privileged -u root -v /var/log/apache2:/var/log/apache2 -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_PLACEMENT_API' docker-registry:4000/nova:R




```


0d4e244deb5d62acba95bfb896fada7160ec37149968b0e776eac29abb875892
root@controller01:/var/log/nova# docker run -d --name nova-scheduler --network=host --restart unless-stopped --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_SCHEDULER' nova:q
c262466528e7aebf17a6887891f7a9603c27adb711ec788dd48cb5e6810a1069
root@controller01:/var/log/nova# docker run -d --name nova-consoleauth --network=host --restart unless-stopped --privileged -u nova -v /var/log/nova:/var/log/nova -v /



```







docker run -d --network=host --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='UPGRADE' nova:q









SAU KHI CAI XONG NOVA THI SU DUNG LENH SAU DE CHECK :


		openstack compute service list --service nova-compute
		+----+-------+--------------+------+-------+---------+----------------------------+
		| ID | Host  | Binary       | Zone | State | Status  | Updated At                 |
		+----+-------+--------------+------+-------+---------+----------------------------+
		| 1  | node1 | nova-compute | nova | up    | enabled | 2017-04-14T15:30:44.000000 |
		+----+-------+--------------+------+-------+---------+----------------------------+





	-------------------------------------------


*********** INSTALL GLANCE
openstack --os-username glance --os-password Fo1e9mG1c2wZ5vL1zg3JppZNa5bteuiI --os-project-name service image list

connection = mysql+pymysql://glance:Tl1bMfzOdSJYi9HZx2ic47rxbPKPXk4q@os-controller/glance



MariaDB [(none)]> CREATE DATABASE glance;
Grant proper access to the glance database:

MariaDB [(none)]> GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost'  IDENTIFIED BY 'Tl1bMfzOdSJYi9HZx2ic47rxbPKPXk4q';
MariaDB [(none)]> GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%'  IDENTIFIED BY 'Tl1bMfzOdSJYi9HZx2ic47rxbPKPXk4q';




openstack user create --domain default --password-prompt glance

username = glance
password = Vttek@123_glance
openstack user set --password-prompt glance




openstack role add --project service --user glance admin

openstack service create --name glance  --description "OpenStack Image" image


openstack endpoint create --region North_VN  image public http://os-controller:9292

openstack endpoint create --region North_VN  image admin  http://os-controller:9292
openstack endpoint create --region North_VN  image internal  http://os-controller:9292



docker build -t glance:R --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 .


docker run  --network=host  -v /var/log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_API' glance:root16



### Bootstrap
```
docker run   --network=host -v /var/log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='BOOTSTRAP' docker-registry:4000/glance:R



```


docker run -d --name glance-api-redhat --network=host --restart unless-stopped -v /var/log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_API' glance:root34



docker run -d --name glance-registry-redhat --network=host --restart unless-stopped -v /var/log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_REGISTRY' glance:root34


VERIFY:
		wget http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img
		openstack image create "cirros" --file  cirros-0.4.0-x86_64-disk.img --disk-format qcow2 --container-format bare --public
        openstack image list


         *** Neu bi loi luc bat docker ---> check config bind host, ... 
         **** loi luc openstack image list ---> xoa cache keystone







*********** INSTALL NEUTRON




		###############################################################
		##############################################################
		#############################################################
		+ Cac loai network trong openstack:
			- Self-Service networking: User trong  1 project co the tao networking topology, hoan toan bi cach biet so voi cac project khac trong cung cloud thong qu su ho tro cua overlapping IPs.
									   User tao mot neutron router, ket noi toi internal va external 
			- Provider network: Thay vi L3 agent, tunneling, floating IPs, NAT thi admin tao mot hoac nhieu hon provider networks, cu the su dung VLANs, chia se voi users cua cloud 
			- External network: Subset cua provider networks voi mot extra flag enabled. 

				+ local network: Co lap khoi cac network khac va node khac. Instance ket noi toi local network co the nhin thay instance khac tren cung compute node nhu lai khong the nhin thay instance tren cung network khac  host.
				+ flat network: khong VLAN tagging hoac other network segregation . Trong mot so configuration, instance co the reside tren cung mang nhu hostmachine
				+ VLAN:  Muc dich chinh la segregate network traffic. Instace tren cung 1 VLAN duoc can nhac la mot phan cua cung mot network va trong cung 1 layer 2 broadcast domain.
				+ VXLAN: VLAN tren L3 

			- Mot OVS bridge hoat dong nhu mot physical switch. Neutron ket noi interface su dungj boi DHCP va instance tap interface toi OVS bridge ports. 
			- Khi ket noi two Open vSwitch bridge mot port tren moi switch duoc su dung nhu mot patch port. Patch port duoc cau hinh voi mot peer name tuong ung voi patch port tren switch khac.




			- interface:
				+ tap interface: ket noi virtual machine toi hostmachine
				+ physical interface: Interface tren host cam vao physical network
				+ VLAN interface: ket noi voi physical interface
				+ VXLAN interface: virtual interface su dung de ma hoa va chuyen traffic 
				Neutron ket noi cac giao dien duoc su dung boi DHCP hoac router namespace va instance tap interface toi OVS bridge port. Port  Port cos the duoc cau hinh nhu mot physical switch port. 
				openvswitch duy tri thong tin ve cac thiet bi duoc ket noi, bao gom MAC address va interface statistics. 
				openvswitch co loai cong tich hop bat chuoc hoat dong cua LInux veth cable nhung no duoc toi uu cho su dung voi cac OVS bride, khi ket noi 2 Open vSwitch bridges, mot port tren moi switch duoc 
				su dung nhu mot patch port, patch ports duoc cau hinh voi mot peer name tuong ung toi patchport tren switch khac. 







docker run -d --name neutron-serverssss --restart unless-stopped --privileged -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u neutron -e NEUTRON_START='START_NEUTRON_SERVER' neutron:q 

#
docker run  --network=host  --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_OVS_AGENT'   docker-registry:4000/neutron:R 




https://docs.openstack.org/python-openstackclient/pike/cli/command-objects/network-agent.html
https://docs.openstack.org/neutron/queens/install/overview.html



	MariaDB [(none)] CREATE DATABASE neutron;
Grant proper access to the neutron database, replacing NEUTRON_DBPASS with a suitable password:

MariaDB [(none)]> GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' IDENTIFIED BY '3fjWwEnE803MWeq4hJOE23GPQAgEDVc8';
MariaDB [(none)]> GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' IDENTIFIED BY '3fjWwEnE803MWeq4hJOE23GPQAgEDVc8';

	





openstack user create --domain default --password-prompt neutron
	project_name = service
	username = neutron
	password = Vttek@123_neutron
	service_metadata_proxy = true
	metadata_proxy_shared_secret = metadata:WJKOfhUWmVB6goPbf6QjurN8SXDfsdlEqA

openstack role add --project service --user neutron admin
openstack service create --name neutron --description "OpenStack Networking" network
openstack endpoint create --region North_VN network public http://os-controller:9696
openstack endpoint create --region North_VN network internal  http://os-controller:9696
openstack endpoint create --region North_VN network admin  http://os-controller:9696

docker build -t neutron:R --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 .


docker run --network=host --privileged -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u neutron -e NEUTRON_START='BOOTSTRAP' docker-registry:4000/neutron:R




docker run -d --name neutron-server --network=host --restart unless-stopped --privileged -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u neutron -e NEUTRON_START='START_NEUTRON_SERVER'  docker-registry:4000/neutron:R



docker run -d --name ovs-agent --network=host --restart unless-stopped --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_OVS_AGENT'   docker-registry:4000/neutron:R 


docker run -d --name dhcp-agent --network=host --restart unless-stopped --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_DHCP_AGENT'  docker-registry:4000/neutron:R 



docker run -d --name metadata-agent --network=host --restart unless-stopped --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run/netns:/run/netns:shared -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_METADATA_AGENT'  docker-registry:4000/neutron:R



******************** Tren cac compute node phai bat br-flat ,br-.... restart vm sau khi cau hinh 


					************ Loi so 1: loi ko hien hypervisor =====> vao trong nova.conf xoa doan rhd o libvirtd
					************ Loi so 2: Loi ko tao dc instance ====> Chua xet quyen cho /etc/nova 
					************ Loi so 3: Loi Khong tao duoc network ====> openstack network create --share --debug --provider-physical-network flat_net --provider-network-type flat flatnet1 //flat_net chu ko phai br-flat //chu y phai add vao ens8


								** buoc 1: Cai openvswitch : 
								253  apt install python-openstackclient
  								297  apt-get install openvswitch-switch

  								** buoc 2: Sua file cau hinh /etc/network/interfaces
  									# This file describes the network interfaces available on your system
									# and how to activate them. For more information, see interfaces(5).

									source /etc/network/interfaces.d/*

									# The loopback network interface
									auto lo
									iface lo inet loopback

									auto ens3
									iface ens3 inet static
									address 172.16.30.176
									netmask 255.255.255.0
									gateway 172.16.30.254

									auto ens8
									iface ens8 inet manual
									        up ip link set dev $IFACE up
									        down ip link set dev $IFACE down
									        post-up ip link set promisc on dev $IFACE

									auto ens10
									iface ens10 inet static
									address 172.16.2.176
									netmask 255.255.255.0


								** buoc 3: tao flat_net, vlan_net:
									311  ovs-vsctl add-br br-flat
  								 	312  ovs-vsctl add-br br-vlan
  								 	313	 ovs-vsctl add-port br-flat ens8
  								 	314  ovs-vsctl show ( //phai restart lai libvirtd, ovs-vsctl moi an dc)
  								** buoc 4: mapping br-flat voi flat_net 
  								** buoc 5: openstack network create --share --debug --provider-physical-network flat_net --provider-network-type flat flatnet1 



									//trong redhat
									 ifconfig [interface] promisc
									 ip link set [interface] promisc on
									To identify if the NIC has been set in Promiscuous Mode, use the ifconfig command.

									# ifconfig eth1
									eth1      Link encap:Ethernet  HWaddr 08:00:27:CD:20:16
									          inet addr:192.168.200.56  Bcast:192.168.255.255  Mask:255.255.0.0
									          inet6 addr: 2606:b400:c10:6044:a00:27ff:fecd:2016/64 Scope:Global
									          inet6 addr: fe80::a00:27ff:fecd:2016/64 Scope:Link
									          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1                     
									          RX packets:22685771 errors:0 dropped:83424 overruns:0 frame:0
									          TX packets:13461 errors:0 dropped:0 overruns:0 carrier:0
									          collisions:0 txqueuelen:1000
									          RX bytes:1604651517 (1.4 GiB)  TX bytes:1475694 (1.4 MiB)




----------------------
























-------------------------



----loi network thi kiem tra br mapping, xem flat net 

*-------------------- Loi metadata service khi khoi tao instace 
			https://ask.openstack.org/en/question/32261/metadata-service-not-reachable-from-instance-in-neutron-single-flat-provider-network/

				++ Cau hinh enabled_isolated_matadata su dung khi mot physical network device nhu firewall hoac router phuc vu nhu default gateway cho instance. (Ben canh do neutron van can cung cap metadata service)
				++ Neutron su dung share secret de ky Instance-ID header cua metadata request de chan gia mao.
				++ ip link set dev eth2 up
					Neu interface up, it ready for use in Linux or Open vSwitch bridge
					Vi interface se duoc su dung trong mot bridge, mot IP address khong the applied truc tiep. Neu chi co mot IP address applied toi eth2, noo se khong the truy cap duoc mot khi interface duoc place trong bridge






				openstack network create --share --provider-physical-network flat_net --provider-network-type flat Flat

openstack subnet create --subnet-range 203.0.113.0/24 --gateway none --network Flat --allocation-pool start=203.0.113.11,end=203.0.113.250 --dns-nameserver 8.8.4.4 Flat-v4

openstack subnet create --subnet-range fd00:203:0:113::/64 --gateway none  --ip-version 6 --ipv6-address-mode slaac --network Flat  --dns-nameserver 2001:4860:4860::8844 Flat-v6
$ openstack router add subnet router1 Flat-v4
$ openstack router add subnet router1 Flat-v6


Sending discover...
Sending select for 203.0.113.24...
Lease of 203.0.113.24 obtained, lease time 86400
route: SIOCADDRT: File exists
WARN: failed: route add -net "0.0.0.0/0" gw "203.0.113.1"
checking http://169.254.169.254/2009-04-04/instance-id



fail

# ip netns
qdhcp-8b868082-e312-4110-8627-298109d4401c

$ openstack security group rule create --proto icmp 409113fa-1a7b-4d48-bedd-14edadc4a377



$ openstack security group rule create --ethertype IPv6 --proto ipv6-icmp 409113fa-1a7b-4d48-bedd-14edadc4a377



$ openstack security group rule create --proto tcp --dst-port 22 409113fa-1a7b-4d48-bedd-14edadc4a377


$ openstack security group rule create --ethertype IPv6 --proto tcp --dst-port 22 409113fa-1a7b-4d48-bedd-14edadc4a377







************************* INSTALL HORIZON

	docker build -t horizon_masakari:R  --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 .




	docker run -d --name horizon --network=host --restart unless-stopped -u root -v /var/log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e HORIZON_START='START_HORIZON' docker-registry:4000/horizon:




----------------***************
		INSTALL MASAKARI 
			1. Create masakari user: $ openstack user create --password-prompt masakari (give password as masakari)

			2. Add admin role to masakari user: $ openstack role add --project service --user masakari admin

*******************************
		***********>>>>>>> loi khi cai dat python-masakariclient tren oepnstack queens 
					https://bugs.launchpad.net/masakari/+bug/1779752

					>>>>> khong the update va dung ban 5.1.0 vi 
						https://github.com/openstack/python-masakariclient/blob/5.1.0/requirements.txt
						yeu cau openstacksdk cua ban rocky
					>>>>> 


		*** reQ.txt 


			openstacksdk==0.11.3
			keystonemiddleware==4.21.0
			taskflow==3.1.0

			oslo.cache==1.28.0
			oslo.concurrency==3.25.1
			oslo.config==5.2.0
			oslo.context==2.20.0
			oslo.db==4.33.0
			oslo.i18n==3.19.0
			oslo.log==3.36.0
			oslo.messaging==5.35.0
			oslo.middleware==3.34.0
			oslo.policy==1.33.1
			oslo.privsep==1.27.0
			oslo.reports==1.26.0
			oslo.rootwrap==5.13.0
			oslo.serialization==2.24.0
			oslo.service==1.29.0
			oslo.utils==3.35.0
			oslo.versionedobjects==1.31.2

			osc_lib==1.9.0
			os-client-config==1.29.0
			dnspython==1.15.0
			libvirt-python==4.0.0
			msgpack-python==0.5.6
			python-barbicanclient==4.6.0
			python-ceilometerclient==2.9.0
			python-cinderclient==3.5.0
			python-dateutil==2.7.5
			python-editor==1.0.3
			python-glanceclient==2.9.1
			python-keystoneclient==3.15.0
			python-memcached==1.53
			python-mimeparse==0.1.4
			python-neutronclient==6.7.0
			python-novaclient==10.1.0
			python-openid==2.2.5
			python-openstackclient==3.14.3
https://releases.openstack.org/queens/index.html

****************


Create Masakariservice :

openstack user create --password-prompt masakari
openstack role add --project service  --user admin admin 
openstack role assignment list --user admin
openstack service create --name masakari --description "OpenStack High Availability" ha   /* Khoi tao mot Service voi ten la "masakari"  va endpoint la "ha" */


Crate Masakari endpoint: 

	openstack endpoint create --region North_VN ha public http://172.16.30.82:15868/v1/%\(tenant_id\)s        
	openstack endpoint create --region North_VN ha admin http://172.16.30.82:15868/v1/%\(tenant_id\)s         
	openstack endpoint create --region North_VN ha internal http://172.16.30.82:15868/v1/%\(tenant_id\)s      


Create Masakari segment:

	masakari segment-create --name masakariTest --description  Masakari4Test --recovery-method  auto --service-type ha

	masakari segment-list
	masakari host-create --segment-id  fa232903-a091-43dc-980b-56b109fc69f5   --control-attributes  SSH --name compute01 --type QEMU --reserved True --on-maintenance False 
	


	masakari host-update --segment-id  fa232903-a091-43dc-980b-56b109fc69f5   --id  5ec7a98c-66ca-4ce0-b9d3-fee1514a4e1e  --control-attributes  SSH --name compute01 --type QEMU --reserved True --on-maintenance False 
	


	masakari host-update --segment-id  fa232903-a091-43dc-980b-56b109fc69f5   --id 7a2458bc-06b9-4d51-96c5-ef738a493d64  --control-attributes  SSH --name compute02 --type QEMU --reserved True --on-maintenance False 
	
	masakari host-list --segment-id fa232903-a091-43dc-980b-56b109fc69f5







			3. Create new service: $ openstack service create --name masakari --description "masakari high availability" masakari

			4. Create endpoint for masakari service: $ openstack endpoint create --region RegionOne masakari --publicurl http://<ip-address>:<port>/v1/%(tenant_id)s --adminurl http://<ip-address>:<port>/v1/%(tenant_id)s --internalurl http://<ip-address>:<port>/v1/%(tenant_id)s

			5. Clone masakari using $ git clone https://github.com/openstack/masakari.git

			6. Run setup.py from masakari $ sudo python setup.py install

			Create masakari directory in /etc/
			Copy masakari.conf, api-paste.ini and policy.json file from masakari/etc/ to /etc/masakari folder

			[database]
connection = mysql+pymysql://masakari:B4PEOrVcWMDAqI9UkLzOBbiOnmsrXtbf@os-controller/masakari?charset=utf8



			9. To run masakari-api simply use following binary: $ masakari-api

			Configure masakari database
			Create 'masakari' database
			After running setup.py for masakari '$ sudo python setup.py install'
			run 'masakari-manage' command to sync the database $ masakari-manage db sync

		MariaDB [(none)]> GRANT ALL PRIVILEGES ON masakari.* TO 'masakari'@'localhost' IDENTIFIED BY 'Vttek@123';
		MariaDB [(none)]> GRANT ALL PRIVILEGES ON masakari.* TO 'masakari'@'%' IDENTIFIED BY 'Vttek@123';



			docker build -t masakari:q --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 .


			docker build -t testMasakariMonitor:q --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 .



docker run --network=host --privileged -v /var/log/masakari:/var/log/masakari -v /var/lib/masakari:/var/lib/masakari -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u masakari -e MASAKARI_START='BOOTSTRAP' masakari:q




			docker run -d --name masakari-api --network=host --restart unless-stopped -u root -v /var/log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e MASAKARI_START='START_MASAKARI_API' masakari:q



			docker run -d --name masakari-engine --network=host --restart unless-stopped -u root -v /var/log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e MASAKARI_START='START_MASAKARI_ENGINE' masakari:q






			docker run -d --name masakari-pythonmonitor --network=host -u root -v /var/log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime testmasakarimonitor:q




docker run  --network=host -u root -v /var/log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime testmasakarimonitor:q    masakari host-create --segment-id 0f10184f-a000-47e7-9e7b-46c9da0bbec8    --control-attributes  SSH --name compute01 --type QEMU --reserved true --on-maintenance false 




docker run -d --name masakari-monitor --network=host -u -restart unless-stopped root -v /var/log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime 172.16.30.82:4000/masakari-monitor 



docker run  -it --network=host  -u root -v /var/log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime 172.16.30.82:4000/masakari-monitor:q



openstacksdk 0.11.3 has requirement jsonpatch!=1.20,>=1.16, but you'll have jsonpatch 1.10 which is incompatible.
python-novaclient 9.1.1 has requirement Babel!=2.4.0,>=2.3.4, but you'll have babel 2.4.0 which is incompatible.
flask 1.0.2 has requirement Jinja2>=2.10, but you'll have jinja2 2.8 which is incompatible.
python-openstackclient 3.14.2 has requirement Babel!=2.4.0,>=2.3.4, but you'll have babel 2.4.0 which is incompatible.
oslo-i18n 3.19.0 has requirement Babel!=2.4.0,>=2.3.4, but you'll have babel 2.4.0 which is incompatible.
keystone 13.0.2 has requirement Babel!=2.4.0,>=2.3.4, but you'll have babel 2.4.0 which is incompatible.
requests 2.18.4 has requirement certifi>=2017.4.17, but you'll have certifi 2015.11.20.1 which is incompatible.
osc-lib 1.9.0 has requirement Babel!=2.4.0,>=2.3.4, but you'll have babel 2.4.0 which is incompatible.
python-glanceclient 2.9.1 has requirement warlock<2,>=1.2.0, but you'll have warlock 1.1.0 which is incompatible.




jsonpatch!=1.20,>=1.16
Babel!=2.4.0,>=2.3.4
Jinja2>=2.10
certifi>=2017.4.17
warlock<2,>=1.2.0


====== OpenStacksdk==0.10.0
	root@controller01:~# masakari segment-list
("global name 'service_description' is not defined", <open file '<stderr>', mode 'w' at 0x7fbca34f61e0>)


===== openstacksdk==0.11.0
		Expecting to find domain in project. The server could not comply with the request since it is either malformed or otherwise incorrect. The client is assumed to be in error. (HTTP 400) (Request-ID: req-9fc0acae-2776-440e-bf3a-23394ff59bdf)

		??? v2.0 
		Stderr: u'Failed to restart masakari-instancemonitor.service: Unit masakari-instancemonitor.service not found.\n': ProcessExecutionError: Unexpected error while running command.
	2018-11-30 05:12:22.557 11983 INFO masakarimonitors.ha.masakari [-] Send a notification. {'notification': {'hostname': 'controller01', 'type': 'PROCESS', 'payload': {'process_name': '/usr/bin/python /usr/local/bin/masakari-instancemonitor', 'event': 'STOPPED'}, 'generated_time': datetime.datetime(2018, 11, 30, 10, 12, 22, 557519)}}
	2018-11-30 05:12:22.599 11983 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. ((http://os-controller:5000/v2.0/tokens): The resource could not be found. (HTTP 404) (Request-ID: req-3655973a-3bbc-4379-afd0-d172a6df35c5)): NotFound: (http://os-controller:5000/v2.0/tokens): The resource could not be found. (HTTP 404) (Request-ID: req-3655973a-3bbc-4379-afd0-d172a6df35c5)
	2018-11-30 05:12:32.613 11983 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. ((http://os-controller:5000/v2.0/tokens): The resource could not be found. (HTTP 404) (Request-ID: req-1b51cec7-5ee7-4f16-b6f9-35cc605dc5ae)): NotFound: (http://os-controller:5000/v2.0/tokens): The resource could not be found. (HTTP 404) (Request-ID: req-1b51cec7-5ee7-4f16-b6f9-35cc605dc5ae)

======= openstacksdk==0.11.3
	 masakari segment-list
	("'Connection' object has no attribute 'ha'", <open file '<stderr>', mode 'w' at 0x7fbd80bbc1e0>)
	***********> loi version 

******************* Masakari : < 5.00


Stdout: u''
Stderr: u'Failed to restart masakari-instancemonitor.service: Unit masakari-instancemonitor.service not found.\n': ProcessExecutionError: Unexpected error while running command.
2018-11-30 22:00:05.824 10437 ERROR masakarimonitors.processmonitor.process_handler.handle_process [-] Unexpected error while running command.
Command: systemctl restart masakari-instancemonitor
Exit code: 5
Stdout: u''
Stderr: u'Failed to restart masakari-instancemonitor.service: Unit masakari-instancemonitor.service not found.\n': ProcessExecutionError: Unexpected error while running command.
2018-11-30 22:00:10.836 10437 ERROR masakarimonitors.processmonitor.process_handler.handle_process [-] Unexpected error while running command.
Command: systemctl restart masakari-instancemonitor
Exit code: 5
Stdout: u''
Stderr: u'Failed to restart masakari-instancemonitor.service: Unit masakari-instancemonitor.service not found.\n': ProcessExecutionError: Unexpected error while running command.
2018-11-30 22:00:15.848 10437 ERROR masakarimonitors.processmonitor.process_handler.handle_process [-] Unexpected error while running command.
Command: systemctl restart masakari-instancemonitor
Exit code: 5
Stdout: u''
Stderr: u'Failed to restart masakari-instancemonitor.service: Unit masakari-instancemonitor.service not found.\n': ProcessExecutionError: Unexpected error while running command.
2018-11-30 22:00:20.851 10437 INFO masakarimonitors.ha.masakari [-] Send a notification. {'notification': {'hostname': 'controller01', 'type': 'PROCESS', 'payload': {'process_name': '/usr/bin/python /usr/local/bin/masakari-instancemonitor', 'event': 'STOPPED'}, 'generated_time': datetime.datetime(2018, 12, 1, 3, 0, 20, 851132)}}
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process [-] Exception caught: 'NoneType' object has no attribute 'auth_url': AttributeError: 'NoneType' object has no attribute 'auth_url'
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process Traceback (most recent call last):
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process   File "/usr/local/lib/python2.7/dist-packages/masakarimonitors/processmonitor/process.py", line 75, in main
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process     self.process_handler.restart_processes(down_process_list)
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process   File "/usr/local/lib/python2.7/dist-packages/masakarimonitors/processmonitor/process_handler/handle_process.py", line 203, in restart_processes
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process     event)
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process   File "/usr/local/lib/python2.7/dist-packages/masakarimonitors/ha/masakari.py", line 81, in send_notification
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process     user_domain_id=CONF.api.user_domain_id)
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process   File "/usr/local/lib/python2.7/dist-packages/masakarimonitors/ha/masakari.py", line 53, in _get_connection
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process     profile=prof)
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process   File "/usr/local/lib/python2.7/dist-packages/openstack/connection.py", line 195, in __init__
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process     profile, authenticator, **kwargs)
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process   File "/usr/local/lib/python2.7/dist-packages/openstack/profile.py", line 50, in _get_config_from_profile
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process     name = urllib.parse.urlparse(authenticator.auth_url).hostname
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process AttributeError: 'NoneType' object has no attribute 'auth_url'
2018-11-30 22:00:20.852 10437 ERROR masakarimonitors.processmonitor.process 
^C2018-11-30 22:01:26.843 10437 INFO oslo_service.service [-] Caught SIGINT signal, instantaneous exiting


			Masakari == 5.1.0
			
			Stdout: u''
Stderr: u'Failed to restart masakari-instancemonitor.service: Unit masakari-instancemonitor.service not found.\n': ProcessExecutionError: Unexpected error while running command.
2018-11-30 22:04:54.072 15433 INFO masakarimonitors.ha.masakari [-] Send a notification. {'notification': {'hostname': 'compute02', 'type': 'PROCESS', 'payload': {'process_name': '/usr/bin/python /usr/local/bin/masakari-instancemonitor', 'event': 'STOPPED'}, 'generated_time': datetime.datetime(2018, 12, 1, 3, 4, 54, 72244)}}
2018-11-30 22:04:54.113 15433 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. ((http://os-controller:5000/v2.0/tokens): The resource could not be found. (HTTP 404) (Request-ID: req-ffc43149-b874-49b0-987f-8a184f5ef8cf)): NotFound: (http://os-controller:5000/v2.0/tokens): The resource could not be found. (HTTP 404) (Request-ID: req-ffc43149-b874-49b0-987f-8a184f5ef8cf)
2018-11-30 22:05:04.130 15433 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. ((http://os-controller:5000/v2.0/tokens): The resource could not be found. (HTTP 404) (Request-ID: req-dffd936f-64e2-4f95-9ea3-1bf6cae13622)): NotFound: (http://os-controller:5000/v2.0/tokens): The resource could not be found. (HTTP 404) (Request-ID: req-dffd936f-64e2-4f95-9ea3-1bf6cae13622)
2018-11-30 22:05:14.146 15433 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. ((http://os-controller:5000/v2.0/tokens): The resource could not be found. (HTTP 404) (Request-ID: req-ffe962b7-3457-43c0-af02-7ad452c3eb14)): NotFound: (http://os-controller:5000/v2.0/tokens): The resource could not be found. (HTTP 404) (Request-ID: req-ffe962b7-3457-43c0-af02-7ad452c3eb14)
		

		Masakari == 6.0.0
		openstacksdk>=0.13.0 # Apache-2.0
oslo.concurrency>=3.26.0 # Apache-2.0
oslo.config>=5.2.0 # Apache-2.0




 {"versions": {"values": [{"status": "stable", "updated": "2018-02-28T00:00:00Z", "media-types": [{"base": "application/json", "type": "application/vnd.openstack.identity-v3+json"}], "id": "v3.10", "links": [{"href": "http://172.16.30.82:5000/v3/", "rel": "self"}]}, {"status": "deprecated", "updated": "2016-08-04T00:00:00Z", "media-types": [{"base": "application/json", "type": "application/vnd.openstack.identity-v2.0+json"}], "id": "v2.0", "links": [{"href": "http://172.16.30.82:5000/v2.0/", "rel": "self"}, {"href": "https://docs.openstack.org/", "type": "text/html", "rel": "describedby"}]}]}}
 {"versions": {"values": [{"status": "stable", "updated": "2018-02-28T00:00:00Z", "media-types": [{"base": "application/json", "type": "application/vnd.openstack.identity-v3+json"}], "id": "v3.10", "links": [{"href": "http://172.16.30.82:5000/v3/", "rel": "self"}]}, {"status": "deprecated", "updated": "2016-08-04T00:00:00Z", "media-types": [{"base": "application/json", "type": "application/vnd.openstack.identity-v2.0+json"}], "id": "v2.0", "links": [{"href": "http://172.16.30.82:5000/v2.0/", "rel": "self"}, {"href": "https://docs.openstack.org/", "type": "text/html", "rel": "describedby"}]}]}}


Sua cau hinh masakari-monitor 
Stderr: u'Failed to restart masakari-instancemonitor.service: Unit masakari-instancemonitor.service not found.\n': ProcessExecutionError: Unexpected error while running command.
2018-12-01 00:06:53.539 20757 INFO masakarimonitors.ha.masakari [-] Send a notification. {'notification': {'hostname': 'compute02', 'type': 'PROCESS', 'payload': {'process_name': '/usr/bin/python /usr/local/bin/masakari-instancemonitor', 'event': 'STOPPED'}, 'generated_time': datetime.datetime(2018, 12, 1, 5, 6, 53, 539105)}}
2018-12-01 00:06:53.610 20757 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (Expecting to find domain in project.
 The server could not comply with the request since it is either malformed or otherwise incorrect.
  The client is assumed to be in error. (HTTP 400) (Request-ID: req-f66d6d9d-a193-432f-b1e7-3f16c3c49c96)):
   BadRequest: Expecting to find domain in project. 
   The server could not comply with the request since it is either malformed or otherwise incorrect. 
   The client is assumed to be in error. (HTTP 400) (Request-ID: req-f66d6d9d-a193-432f-b1e7-3f16c3c49c96)
2018-12-01 00:07:03.630 20757 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (Expecting to find domain in project. The server could not comply with the request since it is either malformed or otherwise incorrect. The client is assumed to be in error. (HTTP 400) (Request-ID: req-f7804940-3da3-48a2-9c11-c214df0bc3bb)): BadRequest: Expecting to find domain in project. The server could not comply with the request since it is either malformed or otherwise incorrect. The client is assumed to be in error. (HTTP 400) (Request-ID: req-f7804940-3da3-48a2-9c11-c214df0bc3bb)
^C2018-12-01 00:07:08.605 20757 INFO oslo_service.service [-] Caught SIGINT signal, instantaneous exiting

bo xung /v3 https://bugs.launchpad.net/kloudbuster/+bug/1663449
bo xung 
export OS_IMAGE_API_VERSION=2
export OS_PROJECT_DOMAIN_ID=default
export OS_USER_DOMAIN_ID=default

=========> xuat hien loi 
2018-12-01 00:10:12.889951 2018-12-01 00:10:12.889 20 INFO keystone.common.wsgi [req-12e461a6-1315-4fce-b54e-a4073a90a7e2 - - - - -] GET http://os-controller:5000/v3/
2018-12-01 00:10:12.894888 2018-12-01 00:10:12.894 21 INFO keystone.common.wsgi [req-1628e9fb-c319-46a2-9f46-e7a4ccdd6090 - - - - -] POST http://os-controller:5000/v3/auth/tokens
2018-12-01 00:10:13.399238 2018-12-01 00:10:13.398 21 DEBUG keystone.auth.core [req-1628e9fb-c319-46a2-9f46-e7a4ccdd6090 - - - - -] MFA Rules not processed for user `8a4301b6f37c437595043ba7d92133cb`. Rule list: `[]` (Enabled: `True`). check_auth_methods_against_rules /usr/lib/python2.7/dist-packages/keystone/auth/core.py:454
2018-12-01 00:10:13.489707 2018-12-01 00:10:13.489 21 DEBUG keystone.common.token_utils [req-1628e9fb-c319-46a2-9f46-e7a4ccdd6090 - - - - -] Loaded 2 Fernet keys from /etc/keystone/fernet-keys/, but `[fernet_tokens] max_active_keys = 3`; perhaps there have not been enough key rotations to reach `max_active_keys` yet? load_keys /usr/lib/python2.7/dist-packages/keystone/common/token_utils.py:306




https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/installation_guide/s1-s390info-addnetdevice
https://docs.openstack.org/neutron/queens/configuration/metadata-agent.html



Openstack-status
Nova service-list
Neutron agent-list
Cinder service list
Mysqladmin –u root –p status 9xem server hoat dong met moi ntn
