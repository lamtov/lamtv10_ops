

docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift   -v /usr/share/docker/swift/swift/:/etc/swift/ -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root  -e SWIFT_START='SWIFT_BOOTSTRAP' docker-registry:4000/swift_proxy_v6:q


docker run --network=host --privileged    -v /usr/share/docker/swift/swift/:/etc/swift/ -v /u01/docker/docker_log/swift:/var/log/swift -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='SWIFT_INITIAL_ACCOUNT_RINGS' -e STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS=172.16.30.59   -e       DEVICE_NAME=sdb -e DEVICE_WEIGHT=100 docker-registry:4000/swift_proxy_v6:q


docker run --network=host --privileged    -v /usr/share/docker/swift/swift/:/etc/swift/ -v /u01/docker/docker_log/swift:/var/log/swift -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='SWIFT_INITIAL_CONTAINER_RINGS' -e STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS=172.16.30.59   -e       DEVICE_NAME=sdb  -e DEVICE_WEIGHT=100 docker-registry:4000/swift_proxy_v6:q


docker run --network=host --privileged    -v /usr/share/docker/swift/swift/:/etc/swift/ -v /u01/docker/docker_log/swift:/var/log/swift -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='SWIFT_INITIAL_OBJECT_RINGS' -e STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS=172.16.30.59   -e       DEVICE_NAME=sdb  -e DEVICE_WEIGHT=100 docker-registry:4000/swift_proxy_v6:q


        #Copy the account.ring.gz, container.ring.gz, and object.ring.gz files to the /etc/swift directory on each storage node and any additional nodes running the proxy service.

docker run  --network=host --privileged    -v /usr/share/docker/swift/swift/:/etc/swift/ -v /u01/docker/docker_log/swift:/var/log/swift -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='SWIFT_VERIFY' docker-registry:4000/swift_proxy_v6:q

docker run -d --network=host --privileged  -v /usr/share/docker/swift/swift/:/etc/swift/  -v /dev/log/:/dev/log -v /u01/docker/docker_log/swift:/var/log/swift -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e SWIFT_START='START_SWIFT_PROXY' --env-file  open.rc  --name  swift-proxy docker-registry:4000/swift_proxy_v6:q




}


docker run --network=host --privileged -v /u01/docker/docker_log/swift:/var/log/swift -v /dev/log/:/dev/log -v /var/cache/:/var/cache/ -v /srv/node/:/srv/node -v /var/lock/:/var/lock -v /var/lib/swift:/var/lib/swift -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u swift -e SWIFT_START='START_SWIFT_STORAGE' docker-registry:4000/swift_storage_v4:q


*********************



swift-ring-builder account.builder create 10 1 1
 swift-ring-builder account.builder add --region 1 --zone 1 --ip 172.16.30.172  --port 6202 --device vdc --weight 100
 swift-ring-builder account.builder
 swift-ring-builder account.builder rebalance

swift-ring-builder container.builder create 10 1 1
swift-ring-builder container.builder add --region 1 --zone 1 --ip 172.16.30.172 --port 6201 --device vdc --weight 100
swift-ring-builder container.builder
swift-ring-builder container.builder rebalance


 swift-ring-builder object.builder create 10 1 1
  swift-ring-builder object.builder add --region 1 --zone 1 --ip  172.16.30.172 --port 6200  --device vdc --weight 100
swift-ring-builder object.builder
 swift-ring-builder object.builder rebalance










************************************


openstack user create --domain default --password MqWRKWbkbB3RcmMT4aXe2lntXOIubGvJ swift
openstack role add --project service --user swift admin
openstack service create --name swift  --description "OpenStack Object Storage" object-store
openstack endpoint create --region North_VN object-store public http://os-controller:8080/v1/AUTH_%\(project_id\)s
openstack endpoint create --region North_VN object-store internal http://os-controller:8080/v1/AUTH_%\(project_id\)s
openstack endpoint create --region North_VN object-store admin http://os-controller:8080/v1



************************************


systemctl enable openstack-swift-account.service openstack-swift-account-auditor.service  openstack-swift-account-reaper.service openstack-swift-account-replicator.service
systemctl restart openstack-swift-account.service openstack-swift-account-auditor.service  openstack-swift-account-reaper.service openstack-swift-account-replicator.service
 systemctl enable openstack-swift-container.service openstack-swift-container-auditor.service openstack-swift-container-replicator.service 
  openstack-swift-container-updater.service
 systemctl restart openstack-swift-container.service  openstack-swift-container-auditor.service openstack-swift-container-replicator.service  openstack-swift-container-updater.service
 systemctl enable openstack-swift-object.service openstack-swift-object-auditor.service openstack-swift-object-replicator.service openstack-swift-object-updater.service



systemctl restart openstack-swift-object.service openstack-swift-object-auditor.service  openstack-swift-object-replicator.service openstack-swift-object-updater.service


systemctl status openstack-swift-object.service openstack-swift-object-auditor.service  openstack-swift-object-replicator.service openstack-swift-object-updater.service



2019-07-11 23:05:36.808 c.v.c.e.l.MetricsBenchmark [INFO] [main] Metrics : Obj Sender All| t 36850457 |avgTps 368,430.884 |minT 0 |maxT 5 |avgT 0.003 current|1851532 |curTps 370,232.354 |min 347,597.281 |max 372,060.188 |minT 0.0 |maxT 1.0 |avgT 0.003 | Threshold  |0-2=36850453 |2-10=4
2019-07-11 23:05:37.210 c.v.c.e.c.EventClient [INFO] [EventClient.reader=0,host=172.16.32.115,port=8888] throughput 736 MB/s tps 373692 lastSeq 36999999 total 37000000 max 8334442 curMaxT 1928501 avgT 365121 curAvgT 422017 min 151601
2019-07-11 23:05:38.573 c.v.c.e.c.EventClient [INFO] [EventClient.reader=0,host=172.16.32.115,port=8888] throughput 724 MB/s tps 367107 lastSeq 37499999 total 37500000 max 8334442 curMaxT 1483940 avgT 365449 curAvgT 389677 min 151601
2019-07-11 23:05:39.917 c.v.c.e.c.EventClient [INFO] [EventClient.reader=0,host=172.16.32.115,port=8888] throughput 733 MB/s tps 371747 lastSeq 37999999 total 38000000 max 8334442 curMaxT 1195984 avgT 365346 curAvgT 357635 min 151601
2019-07-11 23:05:41.259 c.v.c.e.c.EventClient [INFO] [EventClient.reader=0,host=172.16.32.115,port=8888] throughput 734 MB/s tps 372578 lastSeq 38499999 total 38500000 max 8334442 curMaxT 2039112 avgT 366025 curAvgT 417615 min 151601


 cat > vf6.xml << END
<interface type='hostdev' managed='yes'>
 <source>
 <address type='pci' domain='0x0000' bus='0x82' slot='0x11' function='0x5' />
 </source>
</interface>
END




address type='pci' domain='0x0000' bus='0x82' slot='0x11' function='0x5'

Device = "0000:82:11.5"


# modprobe bonding mode=1 primary=eth0 max_bonds=1 arp_interval=100   fail_over_mac=1
# ip link set bond0 up
# ifenslave bond0 eth0 eth1
# ip addr add 172.16.32.14/25 dev bond0
# ip route replace default via <public-gateway>




p1p1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.16.32.84  netmask 255.255.255.0  broadcast 172.16.32.255
        inet6 fe80::a236:9fff:fec2:ec80  prefixlen 64  scopeid 0x20<link>
        ether a0:36:9f:c2:ec:80  txqueuelen 1000  (Ethernet)
        RX packets 118  bytes 7080 (6.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 656 (656.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

p1p2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::a236:9fff:fec2:ec82  prefixlen 64  scopeid 0x20<link>
        ether a0:36:9f:c2:ec:82  txqueuelen 1000  (Ethernet)
        RX packets 262  bytes 16326 (15.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 656 (656.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0



p1p1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::a236:9fff:fec2:ec80  prefixlen 64  scopeid 0x20<link>
        ether a0:36:9f:c2:ec:80  txqueuelen 1000  (Ethernet)
        RX packets 182  bytes 11034 (10.7 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 13  bytes 1034 (1.0 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

p1p2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.16.32.84  netmask 255.255.255.0  broadcast 172.16.32.255
        inet6 fe80::a236:9fff:fec2:ec82  prefixlen 64  scopeid 0x20<link>
        ether a0:36:9f:c2:ec:82  txqueuelen 1000  (Ethernet)
        RX packets 340  bytes 21032 (20.5 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 20  bytes 1160 (1.1 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0




