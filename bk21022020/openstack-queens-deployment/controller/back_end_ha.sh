#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}

#Import source 
	source password/passwd.env
	#vim /etc/hostname
	
# Sau khi da chay make_repo
#keystone


function install_haproxy_n_keepalived {
    echocolor "+ Install haproxy and keepalived"
 
	yum install -y haproxy keepalived
    cat /etc/sysctl.conf > /etc/sysctl.conf.orig
    echo "net.ipv4.ip_nonlocal_bind = 1" > /etc/sysctl.conf
    sysctl -p
    echocolor "+ Configure haproxy"
    mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg_bu
    cp haproxy_keepalive/haproxy.cfg /etc/haproxy/


    sed -i -e "s|VIP_PUBLIC|${VIP_PUBLIC}|g" -e "s|HAPROXY_STATS_PORT|${HAPROXY_STATS_PORT}|g" -e "s|HAPROXY_STATS_USER|${HAPROXY_STATS_USER}|g" -e "s|HAPROXY_STATS_PASS|${HAPROXY_STATS_PASS}|g" /etc/haproxy/haproxy.cfg 
    for service in ${!SERVICES[@]}; do
        echo "listen ${service}" >> /etc/haproxy/haproxy.cfg
        #echo "  bind ${VIP_PRIVATE}:${SERVICES[${service}]}" >> /etc/haproxy/haproxy.cfg
        echo "  bind ${VIP_PUBLIC}:${SERVICES[${service}]}" >> /etc/haproxy/haproxy.cfg
        if [[ ! -z "${CONFIG[${service}]}" ]]; then
            IFS='|' read -r -a cfg <<< "${CONFIG[${service}]}"
            for i in "${!cfg[@]}"; do
                echo "  ${cfg[i]}" >> /etc/haproxy/haproxy.cfg
            done
        fi
        for controller in ${!CONTROLLERS[*]}; do
            echo "  server ${controller} ${CONTROLLERS[${controller}]}:${SERVICES[${service}]} check inter 2000 rise 2 fall 5" >> /etc/haproxy/haproxy.cfg
        done
    done

    echocolor "+ Configure keepalived"
    mv /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf_bu
    cp haproxy_keepalive/keepalived.conf  /etc/keepalived/

    sed -i -e "s|KEEPALIVED_PRIOR|${KEEPALIVED_PRIORS[`hostname`]}|g" /etc/keepalived/keepalived.conf 
    sed -i -e "s|VIP_PRIVATE_INF|${VIP_PRIVATE_INF}|g" -e "s|VIP_PUBLIC_INF|${VIP_PUBLIC_INF}|g" /etc/keepalived/keepalived.conf
    sed -i -e "s|VIP_PRIVATE|${VIP_PRIVATE}|g" -e "s|VIP_PUBLIC|${VIP_PUBLIC}|g" /etc/keepalived/keepalived.conf
    sed -i -e "s|MY_IP|${MY_IP}|g" /etc/keepalived/keepalived.conf
    sed -i -e "s|ROUTER_ID|${ROUTER_ID}|g" /etc/keepalived/keepalived.conf

    systemctl restart keepalived
    systemctl restart haproxy
    systemctl enable keepalived
    systemctl enable haproxy
  
}


#rabbitmq
function install_rabbitmq {
        yum install -y rabbitmq-server
        systemctl enable rabbitmq-server.service
        systemctl start rabbitmq-server.service
        systemctl stop rabbitmq-server.service
}



function rabbit_cookie_sync {
   cookie_path=/var/lib/rabbitmq/.erlang.cookie
   if [ `hostname` == ${HUB} ]; then
       for remote_controller in ${!CONTROLLERS[@]}; do
           if [ $remote_controller != ${HUB} ]; then
               scp ${cookie_path} ${SSH_USER}@${remote_controller}:${cookie_path}
           fi
       done
   fi
   systemctl start rabbitmq-server
}

function rabbit_join_cluster {
   systemctl start rabbitmq-server
   if [ `hostname` != ${HUB} ]; then
       echocolor "+ Join controllers to hub controller"
       rabbitmqctl stop_app
       # rabbitmqctl reset
       # rm /var/lib/rabbitmq/mnesia
       # rabbitmqctl join_cluster --ram rabbit@${HUB}
       rabbitmqctl join_cluster  rabbit@${HUB}
       rabbitmqctl start_app
   fi
}

#rabbitmqctl status 
# {file_descriptors,[{total_limit,924}, //can tang gia tri nay len de tranh loi luc khoi dong lai
#                    {total_used,21},
#                    {sockets_limit,829},
#                    {sockets_used,19}]},



function rabbit_4_ops {
    echocolor "+ Setup rabbit user for OpenStack"
    #rabbitmqctl set_policy ha-all '^(?!amq\.).*' '{"ha-mode": "all"}'
    rabbitmqctl set_policy ha-all '.*' '{"ha-mode": "all"}'
    

    rabbitmqctl delete_user openstack
    rabbitmqctl add_user openstack Y2g8AiB6DjwpvQRKqdU7mXcolwPHNQUT
    rabbitmqctl set_user_tags openstack administrator
    rabbitmqctl set_permissions openstack ".*" ".*" ".*"
}



function backend_rabbitMQ_cluster {
	printcolor "+ Setup RABBITMQ ?\n+ 1.RABBITMQ COOKIE SYNC\n+ 2. RABBITMQ JOIN CLUSTER\n+ 3. SETUP RABBITMQ OpenStack\n+ 4. Test RABBITMQ CLUSTER  \n+
	+ Note: Chay sync tren HUB, chay JOIN CLUSTER tren cac remote_controller
	Your action: "
	read rb_action
  if [ $rb_action == 1 ]; then
	     echocolor "+ RABBITMQ COOKIE SYNC"
      rabbit_cookie_sync
      sleep 3
  elif [ $rb_action == 2 ]; then
	     echocolor "+ RABBITMQ JOIN CLUSTER"
       rabbit_join_cluster
	sleep 2
  elif [ $rb_action == 3 ]; then
  	   echocolor "+ SETUP RABBITMQ OpenStack"
  	   rabbit_4_ops
	sleep 2
  elif [ $rb_action == 4 ]; then
  	   echocolor "+ Test RABBITMQ CLUSTER"
       rabbitmqctl cluster_status
	sleep 2

  fi
}






#PERCONADB
function install_perconadb {
	#yum remove  mariadb mariadb-server python2-PyMySQL
	#yum erase mariadb-config-3:10.1.20-2.el7.x86_64
	#yum erase mariadb-common-3:10.1.20-2.el7.x86_64
	#rm -rf /etc/my.cnf
	#rm -rf /etc/my.cnf.d/
	#rm -rf /usr/lib64/mysql
	#rm -rf /var/lib/mysql/
 	echocolor "+ Install MySQL"
	yum install Percona-XtraDB-Cluster-57

  systemctl stop mysql
  systemctl enable mysql

  CONTROLLER_LIST=$(echo ${CONTROLLERS[*]} | sed "s|\s|,|g")
  mv /etc/percona-xtradb-cluster.conf.d/wsrep.cnf /etc/percona-xtradb-cluster.conf.d/wsrep.cnf_bu
  cp percona/wsrep.cnf /etc/percona-xtradb-cluster.conf.d/
  
  #sed -i "s|VIP_PRIVATE|${VIP_PRIVATE}|g" /etc/mysql/my.cnf 
  sed -i "s|HOST|${HOST}|g"  /etc/percona-xtradb-cluster.conf.d/wsrep.cnf
  sed -i "s|CONTROLLER_LIST|${CONTROLLER_LIST}|g" /etc/percona-xtradb-cluster.conf.d/wsrep.cnf
  sed -i "s|SQL_WSREP_CLUSTER_NAME|${SQL_WSREP_CLUSTER_NAME}|g" /etc/percona-xtradb-cluster.conf.d/wsrep.cnf
  sed -i "s|MY_IP|${MY_IP}|g" /etc/percona-xtradb-cluster.conf.d/wsrep.cnf
  sed -i "s|SQL_SST_USER|${SQL_SST_USER}|g" /etc/percona-xtradb-cluster.conf.d/wsrep.cnf
  sed -i "s|SQL_SST_PASSWD|${SQL_SST_PASSWD}|g" /etc/percona-xtradb-cluster.conf.d/wsrep.cnf
    
  #get password sql
	#grep 'temporary password' /var/log/mysqld.log
	#ALTER USER 'root'@'localhost' IDENTIFIED BY 'Vttek@123';

    if [ `hostname` == ${HUB} ]; then
        systemctl start  mysql@bootstrap.service
        root_password=$(cat /var/log/mysqld.log | grep "A temporary password is generated for" | tail -1 | sed -n 's/.*root@localhost: //p')
        echocolor "+ Current root_password: + $root_password"
        echocolor "+ Please change password to ${SQL_ROOT_PASSWD}: "
        mysql_secure_installation

        echocolor "mysql -u root -p${SQL_ROOT_PASSWD} -e CREATE USER '${SQL_SST_USER}'@'localhost' IDENTIFIED BY '${SQL_SST_PASSWD}'"
        mysql -u root -p${SQL_ROOT_PASSWD} -e "CREATE USER '${SQL_SST_USER}'@'localhost' IDENTIFIED BY '${SQL_SST_PASSWD}'"
        mysql -u root -p${SQL_ROOT_PASSWD} -e "GRANT RELOAD, LOCK TABLES, PROCESS, REPLICATION CLIENT ON *.* TO '${SQL_SST_USER}'@'localhost'"
        # bo password mysql
        mysql -u root -p${SQL_ROOT_PASSWD} -e "SET PASSWORD FOR root@localhost=''"
        mysql -e "FLUSH PRIVILEGES"
    fi

    if [ `hostname` != ${HUB} ]; then
        systemctl start mysql
    fi


    #perconadb chay rieng khong lien quan gi den HAPROXY, chi dung VIR_IP de bind 0.0.0.0

}






function main_backend_ha_controller  {
  printcolor "+ do what?\n+ 1. Install RabbitMQ \n+ 2. Install PerconaDB\n+ 3. Install HAPROXY and keepalived\n+ 
  +
  Your action: "
  
  read action
  if [ $action == 1 ]; then
        echocolor "+ INSTALL RABBITMQ"
        backend_rabbitMQ_cluster
        sleep 3
    elif [ $action == 2 ]; then
        echocolor "+ INSTALL PERCONADB"
        install_perconadb
    sleep 2
    elif [ $action == 3 ]; then
       echocolor "+ INSTALL HAPROXY AND KEEPALIVED"
        install_haproxy_n_keepalived
    sleep 2
  
    else
        echocolor "+ Invalid action! InSTALL ALL !!"
        echocolor "+ INSTALL RABBITMQ"
           backend_rabbitMQ_cluster
        sleep 2 
        echocolor "+ INSTALL PERCONADB"
        install_perconadb
        sleep 2
        echocolor "+ INSTALL HAPROXY AND KEEPALIVED"
        install_haproxy_n_keepalived
    
    fi
  
} 



set global max_connections = 10000;
# show variables like "max_connections";
function restore mysql {

  node 1: 
  vim /etc/percona-xtradb-cluster.conf.d/wsrep.cnf

  wsrep_cluster_address= gcomm://

  vim /var/lib/mysql//grastate.dat
    version: 2.1
    uuid:    ed44856b-10c7-11ea-ad83-e6fa96e55bb7
    seqno:   -1
    safe_to_bootstrap: 0
  systemctl start mysql@bootstrap

  node 2 + node 3: 
  rm -rf /var/lib/mysql//grastate.dat
  systemctl start mysql


  systemctl start mysql@bootstrap
  wsrep_cluster_address= gcomm://172.16.29.193,172.16.29.194,172.16.29.195
  systemctl start mysql


}


docker stop  keystone  glance-api  glance-registry  neutron-server horizon cinder-api  cinder-registry   nova-consoleauth  nova-api  nova-scheduler nova-conductor  nova-novncproxy nova-placement-api 

docker start  keystone  glance-api  glance-registry  neutron-server horizon cinder-api  cinder-registry   nova-consoleauth  nova-api  nova-scheduler nova-conductor  nova-novncproxy nova-placement-api 












