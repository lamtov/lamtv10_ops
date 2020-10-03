systemctl stop mysql
systemctl stop keepalived
systemctl stop haproxy
systemctl stop rabbitmq-server
systemctl stop chronyd
yum remove rabbitmq-server
rm -rf /var/log/rabbitmq 
rm -rf /var/lib/rabbitmq

rm -rf /etc/my.cnf
rm -rf /etc/my.cnf.d/
rm -rf /usr/lib64/mysql
rm -rf /var/lib/mysql/
yum remove  Percona-XtraDB-Cluster-57


systemctl stop openstack-nova-compute
systemctl stop openvswitch


docker stop $(docker ps -a -q -f status=running)
docker rm  $(docker ps -a -q -f status=exited)