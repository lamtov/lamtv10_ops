#!/bin/bash

sudo -E copy_file.sh
if [ "$RABBITMQ_START" = "BOOTSTRAP" ]; then
        service rabbitmq-server start
        rabbitmqctl set_policy ha-all '.*' '{"ha-mode": "all"}'
        rabbitmqctl delete_user openstack
        rabbitmqctl add_user openstack "$OPENSTACK_PASSWORD"
        rabbitmqctl set_user_tags openstack administrator
        rabbitmqctl set_permissions openstack ".*" ".*" ".*"
        rabbitmq-plugins enable rabbitmq_management

        tail -f /var/log/rabbitmq/rabbit@*.log
elif [ "$RABBITMQ_START" = "INIT_RABBITMQ_CLUSTER" ]; then
        cat /var/lib/rabbitmq/.erlang.cookie
        service rabbitmq-server start
        rabbitmqctl stop_app
        # rabbitmqctl reset
        # rm /var/lib/rabbitmq/mnesia
        # rabbitmqctl join_cluster --ram rabbit@${HUB}
        rabbitmqctl join_cluster  rabbit@${RABBITMQ_HUB}
        rabbitmqctl start_app
        tail -f /var/log/rabbitmq/rabbit@*.log
elif [ "$RABBITMQ_START" = "START_RABBITMQ" ]; then
        service rabbitmq-server start
        tail -f /var/log/rabbitmq/rabbit@*.log
else
 echo "RABBITMQ_START is set to '$RABBITMQ_START'"
fi




chown -R ${SERVICE}.${SERVICE} /var/run/mysqld/
          






# Lam nhu the nay tren tat ca cac node
rm -rf /usr/share/docker/rabbitmq/rabbitmq/
rm -rf /u01/docker/docker_log/rabbitmq/
rm -rf  /var/lib/rabbitmq
mkdir -p /u01/docker/docker_log/rabbitmq/
mkdir  -p  /usr/share/docker/rabbitmq/rabbitmq/rabbitmq-data/
echo  "VZDYBEEEQDCBCHSKENTY" > /usr/share/docker/rabbitmq/rabbitmq/.erlang.cookie 
chown -R 1014:1012 /usr/share/docker/rabbitmq/
chown -R 1014:1012 /u01/docker/docker_log/rabbitmq/




# Lam nhu nay cho node dau tien
docker run  -d  --network=host --privileged  -v /u01/docker/docker_log/rabbitmq:/var/log/rabbitmq   -v /usr/share/docker/:/usr/share/docker/  -v /var/lib/rabbitmq:/var/lib/rabbitmq:shared   -u root -e RABBITMQ_START='BOOTSTRAP'   -e OPENSTACK_PASSWORD="opspassword"   docker-registry:4000/rabbitmq_v43:q

# Lam nhu nay cho node thu hai
docker run  -d  --network=host --privileged  -v /u01/docker/docker_log/rabbitmq:/var/log/rabbitmq    -v /usr/share/docker/:/usr/share/docker/  -v /var/lib/rabbitmq:/var/lib/rabbitmq:shared  -u root -e RABBITMQ_START='INIT_RABBITMQ_CLUSTER'   -e RABBITMQ_HUB="compute03"  docker-registry:4000/rabbitmq_v43:q

# Khoi dong lai docker de vao mode chay thuc
docker run  -d  --name rabbitmq --network=host --privileged -v /u01/docker/docker_log/rabbitmq:/var/log/rabbitmq  -v /var/lib/rabbitmq/:/var/lib/rabbitmq/:shared  -v /usr/share/docker/:/usr/share/docker/    -u root -e RABBITMQ_START='START_RABBITMQ'   -e RABBITMQ_HUB="compute03"  docker-registry:4000/rabbitmq_v43:q



docker run  -d  --network=host --privileged -v /u01/docker/docker_log/rabbitmq:/var/log/ -v /usr/share/docker/mysql/mysql-data/:/var/lib/mysql:shared     -v /usr/share/docker/:/usr/share/docker/    -u root -e PXC_START='START_MYSQL'   -e SQL_SST_USER="sstuser" -e SQL_SST_PASSWD="fPWOWrsMGLaBaP74iK57XoOyJy8aAEew"  docker-registry:4000/mysqlp_v32:q



docker run    --network=host --privileged -v /u01/docker/docker_log/mysql:/var/log/    -v /var/lib/mysql:/var/lib/mysql -v /usr/share/docker/:/usr/share/docker/ -u mysql -e PXC_START='BOOTSTRAP'  -e PXC_ROOT_PASSWORD="root"   docker-registry:4000/percona_v6:q sudo -E copy_file.sh && /etc/init.d/mysql bootstrap-pxc




[mysql]
prompt='mysql [compute03] > '


[mysqld]
#bind-address = 10.255.26.100

bind-address = 0.0.0.0


# Path to Galera library
wsrep_provider=/usr/lib/libgalera_smm.so

server_id=1
log_bin=percona-bin
log_slave_updates
binlog_format = ROW
expire-logs-days = 8

wsrep_slave_threads= 8
wsrep_log_conflicts



wsrep_cluster_address= gcomm://172.16.29.196,172.16.29.197,172.16.29.198
wsrep_cluster_name= pxc-cluster_2
wsrep_node_name= compute03
wsrep_node_address= 172.16.29.198

pxc_strict_mode=ENFORCING

# SST method
wsrep_sst_method=xtrabackup-v2

#Authentication for SST method
wsrep_sst_auth="sstuser:fPWOWrsMGLaBaP74iK57XoOyJy8aAEew"
wsrep_provider_options="pc.weight=40"


# MyISAM storage engine has only experimental support
default_storage_engine=InnoDB
# InnoDB config
innodb_locks_unsafe_for_binlog = 1
innodb_autoinc_lock_mode = 2
# Using default innodb_buffer_pool_size since memory is below 32G
innodb_buffer_pool_size = 128M
innodb_large_prefix=off
