#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}
#Import source 
	source password/passwd.env
	
# Sau khi da chay make_repo
function init_repo {
	


	groupadd -g 99 nobody
	useradd -u 99 -g 99 nobody

#	cp yum.conf /etc/
#	yum remove -y iptables
#	yum install -y iptables
#	yum install -y iptables-services
	systemctl stop firewalld
	systemctl disable firewalld
	systemctl stop iptables
	systemctl disable iptables
	#bash ../make_repo/make_repo.sh
	
	#Install Enviroment
	yum install -y python-openstackclient

	############# STOP ...
	detailtask "+STOP selinux\n"
	rm -rf /etc/selinux/config
	cp ./selinux/config /etc/selinux/
	sudo setenforce 0
	sestatus 

	bash password/first_set.sh
}


#Install Docker
function install_docker { 


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
		systemctl enable chronyd.service
		systemctl start chronyd.service
		sleep 2
	fi
	
}

function main_backend_compute {
	printcolor "+ do what?\n+ 1. Init repo and Python-OpenstackClient\n+ 2. Install Docker\n+ 3. Install Chrony\n+
	Your action: "
	
	read action
	if [ $action == 1 ]; then
        init_repo
        sleep 3
    elif [ $action == 2 ]; then
        install_docker
		sleep 2
    elif [ $action == 3 ]; then
        install_chrony
		sleep 2
    else
        echocolor "+ Invalid action! InSTALL ALL !!"
        init_repo
        sleep 2	
        install_docker
		sleep 2
        install_chrony
		sleep 2
	
    fi
	
}	


		
