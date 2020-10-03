#docker restart keystone

docker start nova-conductor
docker start nova-scheduler
docker start nova-consoleauth
docker start nova-novncproxy
docker start nova-placement-api
docker start nova-api

docker start glance-api
docker start glance-registry
docker start neutron-server
docker start  horizon



docker start masakari-api
docker start masakari-engine


