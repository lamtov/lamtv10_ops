#!/bin/sh
INFO_SQL_MSG=`/usr/bin/mysql -e "show databases;" 2>/dev/null`
if [ "$INFO_SQL_MSG" == "" ] ;then
	echo "MySQL Node is Down"
	exit 1

else
	INFO_CLUSTER_MSG=`curl http://127.0.0.1:9200`
	if [[ "$INFO_CLUSTER_MSG" == *"Percona XtraDB Cluster Node is synced"* ]]  ; then
		exit 0
	else
		echo "MySQL Node is not synced"
		exit 1
	fi
fi
