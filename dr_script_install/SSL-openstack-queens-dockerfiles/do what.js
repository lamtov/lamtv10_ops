1. Sua cac file cau hinh 
-		Doi ten o1.controller ==> o3.controller

Sua lai /etc/hosts:

10.255.26.100		o1.controller
10.255.26.101		o2.controller
10.255.26.102		o3.controller	
10.255.26.60			os.controller



/etc/





- Sua lai vi tri dat file log 
- Bo xung log folder



2. Build lai docker

//docker tag docker-registry:4000/masakari:q masakari_v1:q
docker tag localhost:4000/keystone:q keystone_v1:q

docker tag localhost:4000/base:q base_v1:q
docker tag localhost:4000/glance:q glance_v1:q

docker tag localhost:4000/horizon:q horizon_v1:q
docker tag localhost:4000/nova:q nova_v1:q
docker tag localhost:4000/neutron_dpdk:q neutron_v1:q

docker tag localhost:4000/cinder_scheduler:q cinder_scheduler_v1:q
docker tag localhost:4000/cinder_api:q cinder_api_v1:q
//docker tag docker-registry:4000/cinder_volume:q cinder_volume_v1:q




cd keystone_docker/
docker build -t ssl_keystone_v1:q -f Dockerfile .
docker tag ssl_keystone_v1:q localhost:4000/ssl_keystone_v1:q
docker push localhost:4000/ssl_keystone_v1:q

cd ../horizon-docker/
docker build -t ssl_horizon_v1:q -f Dockerfile .
docker tag ssl_horizon_v1:q localhost:4000/ssl_horizon_v1:q
docker push localhost:4000/ssl_horizon_v1:q


cd ../glance_docker/
docker build -t ssl_glance_v1:q -f Dockerfile .
docker tag ssl_glance_v1:q localhost:4000/ssl_glance_v1:q
docker push localhost:4000/ssl_glance_v1:q

cd ../neutron_docker/
docker build -t ssl_neutron_v1:q -f Dockerfile .
docker tag ssl_neutron_v1:q localhost:4000/ssl_neutron_v1:q
docker push localhost:4000/ssl_neutron_v1:q


cd ../nova_docker/
docker images
docker build -t ssl_nova_v1:q -f Dockerfile .
docker tag ssl_nova_v1:q localhost:4000/ssl_nova_v1:q
docker push localhost:4000/ssl_nova_v1:q


cd ../cinder_api_docker/
docker build -t ssl_cinder_api_v1:q -f Dockerfile .
docker tag ssl_cinder_api_v1:q localhost:4000/ssl_cinder_api_v1:q
docker push localhost:4000/ssl_cinder_api_v1:q

cd ../cinder_scheduler_docker/
docker build -t ssl_cinder_scheduler_v1:q -f Dockerfile .
docker tag ssl_cinder_scheduler_v1:q localhost:4000/ssl_cinder_scheduler_v1:q
docker push localhost:4000/ssl_cinder_scheduler_v1:q




docker pull docker-registry:4000/ssl_keystone_v1:q

docker pull docker-registry:4000/ssl_horizon_v1:q

docker pull docker-registry:4000/ssl_glance_v1:q

docker pull docker-registry:4000/ssl_neutron_v1:q

docker pull docker-registry:4000/ssl_nova_v1:q

docker pull docker-registry:4000/ssl_cinder_api_v1:q

docker pull docker-registry:4000/ssl_cinder_scheduler_v1:q



UPDATE DB
# UPDATE keystone.endpoint SET url="https://os.controller:8080/v1" WHERE url="http://10.255.26.103:8080/v1";
# UPDATE keystone.endpoint SET url="https://os.controller:8080/v1/AUTH_%(project_id)s" WHERE url="http://10.255.26.103:8080/v1/AUTH_%(project_id)s";
UPDATE keystone.endpoint SET url="https://os.controller:8774/v2.1" WHERE url="http://os-controller:8774/v2.1";
UPDATE keystone.endpoint SET url="https://os.controller:8776/v2/%(project_id)s" WHERE url="http://os-controller:8776/v2/%(project_id)s";
UPDATE keystone.endpoint SET url="https://os.controller:8776/v3/%(project_id)s" WHERE url="http://os-controller:8776/v3/%(project_id)s";
UPDATE keystone.endpoint SET url="https://os.controller:8778" WHERE url="http://os-controller:8778";
UPDATE keystone.endpoint SET url="https://os.controller:9292" WHERE url="http://os-controller:9292";
UPDATE keystone.endpoint SET url="https://os.controller:9696" WHERE url="http://os-controller:9696";






3.
Tao folder apache log
mkdir -p /u01/apache2/glance/
mkdir -p /u01/apache2/neutron/
mkdir -p /u01/apache2/nova/



 Bat keystone:

 sua mysql:

 





4. compute

vim /etc/hosts
#ssl
10.255.26.100   o1.controller
10.255.26.101   o2.controller
10.255.26.103   o3.controller
10.255.26.60    os.controller

vim ca-certificates.crt 

-----BEGIN CERTIFICATE-----
MIID5TCCAs2gAwIBAgIJAMP8oVArSC3OMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYD
VQQGEwJWTjELMAkGA1UECAwCSE4xDjAMBgNVBAcMBUhhTm9pMRAwDgYDVQQKDAdW
aWV0dGVsMQwwCgYDVQQLDANPQ1MxFTATBgNVBAMMDCouY29udHJvbGxlcjElMCMG
CSqGSIb3DQEJARYWbGFtdHYxMEB2aWV0dGVsLmNvbS52bjAeFw0xOTA4MjAwNzA3
NDBaFw0yNTAzMjkwNzA3NDBaMIGIMQswCQYDVQQGEwJWTjELMAkGA1UECAwCSE4x
DjAMBgNVBAcMBUhhTm9pMRAwDgYDVQQKDAdWaWV0dGVsMQwwCgYDVQQLDANPQ1Mx
FTATBgNVBAMMDCouY29udHJvbGxlcjElMCMGCSqGSIb3DQEJARYWbGFtdHYxMEB2
aWV0dGVsLmNvbS52bjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOHB
ALE1yM+zKj9/iTAx/cGSZF/RWwthKs0rKztxMFzJMfFOrDZDAdlOQskP45YEwpof
pvpWdujZUd6Otjh6PToHbu5lu1x8FlQq+5swavHTztQHjI1M/LVjwTnXtqA7SXjl
qji3w/HqjMpfLVqwpn/GP4yFatpGpd06e/vVRWrBhQMQ6ViXyn2Ff7Trk+2iHlPF
1ZjhCWJrQJsjTKJdrFCJlRmqLQ2SzuSi+vF60Wggd4CSvcrbd9nkNu6tMBnfuxcL
X5GnEB4+GhVri8pToDRVUdLFaAwfSib6He9AFQphEu0vWQxMMQdAGiOIIchWwnm4
FZiW/FesWDjrgcRZoU0CAwEAAaNQME4wHQYDVR0OBBYEFGry6HZDrXaTjoClpH93
GrFTMZ1wMB8GA1UdIwQYMBaAFGry6HZDrXaTjoClpH93GrFTMZ1wMAwGA1UdEwQF
MAMBAf8wDQYJKoZIhvcNAQELBQADggEBAKgxSAtfDxb7U2Tg+RKNCx+J48nD1Zdn
EljQ197sWmPc8j2ERu5k8IDQF7MX3wp4cqyIHi5PVvydXvBFbHQdOhCwMSVKbqoO
fr6v2zje2GFumJ2Au8ISHIxmkE9Bltgjny+W/vuFjXH+B2843DBXCXvemZV6gO+n
xsp42uLSUkhKigUyjavBz3pRMkqXcBvSujwGxwwBjSLqijHuND5lT9KKx/ch1Rgv
DxzryTd5UBC3Lp6wGW/qIq91MA/GNUlaj4TZnDCVBsi19EQHUo+Zt1s6pY3Di0R9
yZbMZUJd3ZvmFoGZM+Emp8nTS+k1hKBNxngdkFjxczQemFZ+5jX/h2A=
-----END CERTIFICATE-----


vim /etc/ssl/certs/ca-bundle.crt


docker cp ca-certificates.crt ovs-agent:/etc/ssl/certs/ca-certificates.crt 
docker cp ca-certificates.crt dhcp-agent:/etc/ssl/certs/ca-certificates.crt 
docker cp ca-certificates.crt metadata-agent:/etc/ssl/certs/ca-certificates.crt 

cd /etc/nova/

mv nova.conf nova.conf.bk
vim nova.conf 


cd /usr/share/docker/neutron/neutron/
mv neutron.conf neutron.conf.bk 
vim neutron.conf
vim metadata-agent.ini


systemctl restart openstack-nova-compute
docker restart ovs-agent dhcp-agent metadata-agent 



tail -f /var/log/nova/nova-compute.log
tail -f /u01/docker/docker_log/neutron/neutron-openvswitch-agent.log



insert iptables:
vim  /etc/sysconfig/iptables

-A OUTPUT -d 10.255.26.74/32 -p tcp -m state --state NEW -m tcp -m multiport --dports 6200,6201,6202 -m comment --comment "FOR Swift container" -j ACCEPT

docker cp ca-certificates.crt swift_proxy:/etc/ssl/certs/
systemctl restart memcached
docker restart swift_proxy

Tren compute node : 

 949  swift-init all status
  950  swift-init all restart
  951  swift-init all status
netstat -nap | grep 6200 6201 6202
