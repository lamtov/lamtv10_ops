

mkdir -p /usr/share/docker/ops_exporter/certs 


docker cp openstack_exporter_v1:/usr/local/bin/exporter/main.py ./
cat /etc/ssl/certs/ca-bundle.crt  >  /usr/share/docker/ops_exporter/certs/ca-certificates.crt 
cat prometheous_q.tar | docker load


docker run -d  --name=openstack_exporter_v1  --network=host       --env-file  /usr/share/docker/ops_exporter_service/ops_exporter_env  -v /usr/share/docker/ops_exporter_service/certs/:/etc/ssl/certs/    -it  prometheous:q 


docker cp check_os_api.py openstack_exporter_v1:/usr/local/bin/exporter/check_os_api.py
docker cp osclient.py openstack_exporter_v1:/usr/local/bin/exporter/osclient.py
docker cp openstack_exporter_v1:/usr/local/bin/exporter/main.py ./



docker restart openstack_exporter_v1

ops_exporter_env 
OS_AUTH_URL=https://os.controller:5000/v3
OS_PASSWORD=VHT_OCS@123
OS_PROJECT_NAME=admin
OS_USERNAME=admin
OS_USER_DOMAIN_NAME=default
OS_REGION_NAME=North_VN
TIMEOUT_SECONDS=20
OS_POLLING_INTERVAL=60
OS_RETRIES=100
LISTEN_PORT=9103
OS_CPU_OC_RATIO=1
OS_RAM_OC_RATIO=1
OS_PROJECT_DOMAIN_NAME=default
OS_USER_DOMAIN_NAME=default

OS_IDENTITY_API_VERSION=3
OS_IMAGE_API_VERSION=2
OS_PROJECT_DOMAIN_ID=default
OS_USER_DOMAIN_ID=default


