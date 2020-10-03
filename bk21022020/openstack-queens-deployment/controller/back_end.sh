#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}



#Import source 
	source password/passwd.env
	
# Sau khi da chay make_repo
function init_repo {
	#ash ../make_repo/make_repo.sh
	############# STOP ...
	detailtask "+STOP selinux\n"

	rm -rf /etc/selinux/config
	cp ./selinux/config /etc/selinux/
	sudo setenforce 0
	sestatus
	
	
	cp yum.conf /etc/

	#yum remove -y iptables
#	yum install -y iptables
#	yum install -y iptables-services
	systemctl stop firewalld
	systemctl disable firewalld 
	systemctl stop iptables
	systemctl disable iptables
	#Install Enviroment
	yum install -y python-openstackclient


	bash password/first_set.sh

}

#Install Docker 
function install_docker {
	detailtask "+Start  Install Docker\n"


	mkdir /u01/docker
	mkdir /u01/docker/docker_graph
	mkdir /u01/docker/docker_log
	yum install -y docker-ce
	yum install -y docker-compose
	cp ../docker/daemon.json /etc/docker/
	sed -i "s|VAR_LIB_DOCKER|${VAR_LIB_DOCKER}|g"  /etc/docker/daemon.json 
	systemctl enable docker 
	systemctl start docker
	systemctl restart docker 
	cp -r ../docker /usr/share 
	detailtask "+End  Install  Docker\n"
}

#mariadb
function install_mariadb {
	detailtask "+Start  Install Maria\n"
	rm -rf /etc/yum.repos.d/percona-release.repo 
	yum install -y mariadb mariadb-server python2-PyMySQL
	mkdir /etc/my.cnf.d/
	cp mysql/openstack.cnf /etc/my.cnf.d/
	sed -i "s|HOST|${HOST}|g" /etc/my.cnf.d/openstack.cnf
	systemctl enable mariadb.service
	systemctl start mariadb.service
	detailtask "+End  Install Maria\n"
}

#chrony
function install_chrony {
	printcolor "+do what?\n + 1. install Chrony Server\n + 2. Install Chrony Client\n + Your action: "
	read chrony_ac
	if [ $chrony_ac == 1 ]; then
		yum install -y chrony
		cp chrony/server/chrony.conf /etc/
		systemctl enable chronyd.service
		systemctl start chronyd.service
        sleep 3
    else 
		yum install -y chrony
		cp chrony/client/chrony.conf /etc/
		sed -i "s|NTP_NETWORK|${NTP_NETWORK}|g" /etc/chrony.conf
		systemctl enable chronyd.service
		systemctl start chronyd.service
		sleep 2
	fi
	
}

#rabbitmq
function install_rabbitmq {
	yum install -y rabbitmq-server
	systemctl enable rabbitmq-server.service
	systemctl start rabbitmq-server.service
	systemctl stop rabbitmq-server.service
}



function rabbit_4_ops {
    echocolor "+ Setup rabbit user for OpenStack"
    #rabbitmqctl set_policy ha-all '^(?!amq\.).*' '{"ha-mode": "all"}'
    rabbitmqctl set_policy ha-all '.*' '{"ha-mode": "all"}'
    

    rabbitmqctl delete_user guest
    rabbitmqctl add_user openstack ${RB_OPENSTACK}
    rabbitmqctl set_permissions openstack ".*" ".*" ".*"
}



#memcached_servers
function install_memcached_servers {
	yum install -y memcached python-memcached
	cp memcached/memcached /etc/sysconfig/
	sed -i "s|MY_IP|${MY_IP}|g" /etc/sysconfig/memcached
	systemctl enable memcached.service
	systemctl start memcached.service
}

function main_backend_controller  {
	printcolor "+ do what?\n+ 1. Init repo and Python-OpenstackClient\n+ 2. Install Docker\n+ 3. Install MariaDb\n+ 4. Install Chrony_RabbitMQ_Memcached\n+
	+
	Your action: "
	
	read action
	if [ $action == 1 ]; then
		echocolor "+ INIT REPO"
        init_repo
        sleep 3
    elif [ $action == 2 ]; then
		echocolor "+ INSTALL DOCKER"
        install_docker
		sleep 2
    elif [ $action == 3 ]; then
		echocolor "+NO INSTALL MARIADB"
		#install_mariadb
		sleep 2
    elif [ $action == 4 ]; then
		echocolor "+ INSTALL CHRONY"
        install_chrony
		sleep 2
		echocolor "+ INSTALL RABBITMQ"
		install_rabbitmq
		sleep 2
		echocolor "+ INSTALL MEMCACHED"
		install_memcached_servers
		sleep 2
	
    else
        echocolor "+ Invalid action! InSTALL ALL !!"
		echocolor "+ INIT REPO"
       		 init_repo
        sleep 2	
		echocolor "+ INSTALL DOCKER"
        install_docker
		sleep 2
		echocolor "+ INSTALL MARIADB"
        install_mariadb
		sleep 2
		echocolor "+ INSTALL CHRONY"
        install_chrony
		sleep 2
		echocolor "+ INSTALL RABBITMQ"
		install_rabbitmq
		sleep 2
		echocolor "+ INSTALL MEMCACHED"
		install_memcached_servers
		sleep 2
		
    fi
	
}	

		
		
		
		
		
		
		
		
		
