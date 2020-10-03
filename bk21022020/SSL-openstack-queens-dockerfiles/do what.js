1. Sua cac file cau hinh 




 sudo service apache2 restart 
 docker cp keystone.conf  keystone:/etc/apache2/sites-enabled/


  

Country Name (2 letter code) [XX]:VN
State or Province Name (full name) []:HN
Locality Name (eg, city) [Default City]:HN
Organization Name (eg, company) [Default Company Ltd]:Viettel
Organizational Unit Name (eg, section) []:OCS
Common Name (eg, your name or your server's hostname) []:*.controller
Email Address []:lamtv10@Viettel.com.vn



rm -rf cert_req.pem key.pem rootCA.key rootCA.pem rootCA.srl server.pem


openssl genrsa -des3 -out rootCA_Haproxy.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 2048 -out rootCA.pem



cert_req.conf

[ req ]
default_bits            = 2048
default_keyfile         = keystonekey.pem
default_md              = default

prompt                  = no
distinguished_name      = distinguished_name

[ distinguished_name ]
countryName             = VN
stateOrProvinceName     = HN
localityName            = HaNoi
organizationName        = Viettel
organizationalUnitName  = OCS
commonName              = *.controller
emailAddress            = lamtv10@viettel.com.vn


openssl req -newkey rsa:2048 -keyout private_key.pem -keyform PEM -out cert_req.pem -outform PEM -config cert_req.conf -nodes

openssl x509 -req -in cert_req.pem -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server_cert.pem  -outform PEM  -days 2048 -sha256 -extfile v3.ext


bash remake.sh 
cd ..
bash reload.sh
bash ~/first_run.sh 

curl --cacert ca.pem https://controller:5000/
openssl x509 -in cert.pem -noout -subject

v3.ext 
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = controller




vim /etc/ssl/certs/ca-bundle.crt


# keystone-manage db_sync
# keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
# keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password Vttek@123 \
  --bootstrap-admin-url https://controller:5000/v3/ \
  --bootstrap-internal-url https://controller:5000/v3/ \
  --bootstrap-public-url https://controller:5000/v3/ \ll
  --bootstrap-region-id NorthVN


select * from keystone.endpoint  order by url;





-		Doi ten o1.controller ==> o3.controller

Sua lai /etc/hosts:

o1.controller	10.255.26.100
o2.controller	10.255.26.101
o3.controller	10.255.26.102
os.controller	10.255.26.60




/usr/lib/python2.7/site-packages:

/osprofiler/reporter.py (file khởi tạo reporter gồm các hàm consume, submit ,...)
/osprofiler/local_agent_net.py (file mà cái ioloop khởi tạo khác nhau từ threadloop
/threadloop/threadloop.py (file thread loop tạo từ tornado.io_loop)




- Sua lai vi tri dat file log 
- Bo xung log folder



2. Build lai docker

//docker tag docker-registry:4000/masakari:q masakari_v1:q
docker tag docker-registry:4000/keystone:q keystone_v1:q

docker tag docker-registry:4000/base:q base_v1:q
docker tag docker-registry:4000/glance:q glance_v1:q

docker tag docker-registry:4000/horizon:q horizon_v1:q
docker tag docker-registry:4000/nova:q nova_v1:q
docker tag docker-registry:4000/neutron:q neutron_v1:q

docker tag docker-registry:4000/cinder_scheduler:q cinder_scheduler_v1:q
docker tag docker-registry:4000/cinder_api:q cinder_api_v1:q
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





3.
Tao folder apache log
mkdir -p /u01/apache2/glance/
mkdir -p /u01/apache2/neutron/
mkdir -p /u01/apache2/glance/
mkdir -p /u01/apache2/glance/
mkdir -p /u01/apache2/glance/
mkdir -p /u01/apache2/glance/
mkdir -p /u01/apache2/glance/
mkdir -p /u01/apache2/glance/
mkdir -p /u01/apache2/glance/


 Bat keystone:

 sua mysql:

 





 curl -X POST  https://os.controller:5000/v3/auth/tokens -d '{"auth":{"passwordCredentials":{"username": "admin", "password":"Vttek@123"}, "tenantId":"cef9b0558863409a8d33a13956f4c6ad"}}' -H 'Content-type: application/json'


 docker run   --name=openstack_exporter_v1  --network=host       --env-file openstack_env  -v /etc/ssl/certs:/etc/ssl/certs/  prometheous:q


docker run -d --name glance-api --network=host --restart unless-stopped -v $VAR_LOG_DIR/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_API' docker-registry:4000/glance:q
	



mkdir -p /usr/share/docker/ops_exporter/certs 
cat /etc/ssl/certs/ca-bundle.crt  >  /usr/share/docker/ops_exporter/certs/ca-certificates.crt 
cat prometheous_q.tar | docker load

docker run   --name=openstack_exporter_v1  --network=host       --env-file  /usr/share/docker/ops_exporter/openstack_env  -v /usr/share/docker/ops_exporter/certs/:/etc/ssl/certs/  -p 9103:9103  -it  prometheous:q 

ops_exporter_env 
OS_AUTH_URL=https://os.controller:5000/v3
OS_PASSWORD=Vttek@123
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




