#!/bin/bash

sudo -E copy_file.sh
if [ "$PXC_START" = "BOOTSTRAP" ]; then
        echo "insecureXXXXXXXXXXXX"
        /etc/init.d/mysql bootstrap-pxc
        #netstat -nap | grep 3306
        SQL_ROOT_PASSWD='lamtv10'
        mysql -u root -p${SQL_ROOT_PASSWD} -e "CREATE USER '${SQL_SST_USER}'@'localhost' IDENTIFIED BY '${SQL_SST_PASSWD}'"
        mysql -u root -p${SQL_ROOT_PASSWD} -e "GRANT RELOAD, LOCK TABLES, PROCESS, REPLICATION CLIENT ON *.* TO '${SQL_SST_USER}'@'localhost'"
        mysql -u root -p${SQL_ROOT_PASSWD} -e "SET PASSWORD FOR root@localhost=''"
        mysql -u root -e "FLUSH PRIVILEGES"

        mkdir -p /usr/share/docker/mysql/mysql-data/
        chown -R mysql:mysql /usr/share/docker/mysql/mysql-data/
        cp -r /var/lib/mysql/* /usr/share/docker/mysql/mysql-data/
        tail -f /var/log/mysqld.log
elif [ "$PXC_START" = "INIT_MYSQL_CLUSTER" ]; then
        /etc/init.d/mysql start
                mkdir -p /usr/share/docker/mysql/mysql-data/
        chown -R mysql:mysql /usr/share/docker/mysql/mysql-data/
        cp -r /var/lib/mysql/* /usr/share/docker/mysql/mysql-data/
        tail -f /var/log/mysqld.log
elif [ "$PXC_START" = "START_MYSQL" ]; then
        /etc/init.d/mysql start
        tail -f /var/log/mysqld.log
else
 echo "PXC_START is set to '$PXC_START'"
fi


chown -R ${SERVICE}.${SERVICE} /var/run/mysqld/

~                                                                                                                                                                                                                                                  
~                                                                                                                                                                                                                                                  
~             
# Lam nhu the nay tren tat ca cac node
rm -rf   /usr/share/docker/mysql/mysql-data/*
mkdir  -p  /usr/share/docker/mysql/mysql-data/
mkdir -p /u01/docker/docker_log/mysql/

chown -R 1011:1010 /usr/share/docker/mysql/mysql-data/
chown -R 1011:1010 /u01/docker/docker_log/mysql/


# Lam nhu nay cho node dau tien
docker run  -d  --network=host --privileged -v /u01/docker/docker_log/mysql:/var/log/      -v /usr/share/docker/:/usr/share/docker/    -u mysql -e PXC_START='BOOTSTRAP'   -e SQL_SST_USER="sstuser" -e SQL_SST_PASSWD="fPWOWrsMGLaBaP74iK57XoOyJy8aAEew"  docker-registry:4000/mysqlp_v20:q

# Lam nhu nay cho node thu hai
docker run  -d  --network=host --privileged -v /u01/docker/docker_log/mysql:/var/log/    -v /usr/share/docker/:/usr/share/docker/    -u mysql -e PXC_START='INIT_MYSQL_CLUSTER'   -e SQL_SST_USER="sstuser" -e SQL_SST_PASSWD="fPWOWrsMGLaBaP74iK57XoOyJy8aAEew"  docker-registry:4000/mysqlp_v20:q

# Khoi dong lai docker de vao mode chay thuc
docker run  -d  --name mysql --network=host --privileged -v /u01/docker/docker_log/mysql:/var/log/  -v /usr/share/docker/mysql/mysql-data/:/var/lib/mysql:shared     -v /usr/share/docker/:/usr/share/docker/    -u mysql -e PXC_START='START_MYSQL'   -e SQL_SST_USER="sstuser" -e SQL_SST_PASSWD="fPWOWrsMGLaBaP74iK57XoOyJy8aAEew"  docker-registry:4000/mysqlp_v20:q






CREATE USER 'lamtv10'@'%' IDENTIFIED BY 'lamtv10'
GRANT RELOAD, LOCK TABLES, PROCESS, REPLICATION CLIENT ON *.* TO 'lamtv10'@'localhost'


GRANT ALL PRIVILEGES ON lamtv10.* TO 'lamtv10'@'localhost' IDENTIFIED BY "lamtv10";
GRANT ALL PRIVILEGES ON lamtv10.* TO 'lamtv10'@'%' IDENTIFIED BY "lamtv10";


docker exec -it mysql bash
$ mysql -u lamtv10 -p'lamtv10' < /usr/share/docker/mysql/create_database.sql




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
