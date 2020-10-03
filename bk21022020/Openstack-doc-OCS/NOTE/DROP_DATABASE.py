 nova  --debug boot --flavor 4C8G12G1H   --image rhel76_ems      --nic net-id=37d3a72b-99c7-44d1-82e6-2588ed83bdfb  --availability-zone nova:computealpha  alpha_sriov_4



select * from nova_api.resource_providers;
+---------------------+---------------------+----+--------------------------------------+----------------+------------+----------+------------------+--------------------+
| created_at          | updated_at          | id | uuid                                 | name           | generation | can_host | root_provider_id | parent_provider_id |
+---------------------+---------------------+----+--------------------------------------+----------------+------------+----------+------------------+--------------------+
| 2019-01-22 01:47:18 | 2019-05-21 10:39:21 | * 2 | a13421f0-c047-45fd-9e49-88b9b691e553 | spgm01drcomp1  |       1540 |     NULL |                2 |               NULL |
| 2019-01-22 02:44:39 | 2019-05-22 02:05:41 | * 5 | f65013e4-0a04-4eea-af82-54ddc5a72109 | spgm01drcomp4  |       2065 |     NULL |                5 |               NULL |
| 2019-01-22 08:00:23 | 2019-05-22 02:04:20 | * 8 | 7816f163-2266-43cd-8e3b-c0bafabbf7fb | spgm01drcomp3  |       2586 |     NULL |                8 |               NULL |
| 2019-01-22 08:08:13 | 2019-05-22 02:03:25 | * 11 | 3f3b9d6c-ad75-4a57-82c1-0dbd79b69dda | spgm01drcomp2  |       2156 |     NULL |               11 |               NULL |
| 2019-02-14 09:33:21 | 2019-05-22 02:05:41 | 14 | 48a094b6-3431-4725-a259-bb77a8aed0ee | spgm01drcomp5  |       1945 |     NULL |               14 |               NULL |
| 2019-02-14 09:59:00 | 2019-05-22 02:04:40 | 17 | 46c688c4-400d-45cc-89f2-dc30686d00a6 | spgm01drcomp6  |       1939 |     NULL |               17 |               NULL |
| 2019-02-14 10:09:37 | 2019-05-22 03:04:35 | 20 | a4e3f559-3988-484b-9543-b797b7b1a149 | spgm01drcomp7  |       2065 |     NULL |               20 |               NULL |
| 2019-02-14 10:17:14 | 2019-05-22 02:05:50 | 23 | cd4ec6a0-a68c-4982-b7c7-3716d6199fd6 | spgm01drcomp8  |       1962 |     NULL |               23 |               NULL |
| 2019-02-14 10:29:19 | 2019-05-22 02:04:43 | * 26 | d13b93ed-c027-4c9e-a63d-9d66d3589355 | spgm01drcomp9  |       2044 |     NULL |               26 |               NULL |
| 2019-02-15 03:15:04 | 2019-05-22 03:04:36 | 29 | 055ad22a-c515-4378-bbfb-a0e5d67c694d | spgm01drcomp10 |       2040 |     NULL |               29 |               NULL |
| 2019-02-15 03:27:08 | 2019-05-22 02:04:53 | * 32 | 68f12c91-933e-4ebd-a746-e8a8329e3b80 | spgm01drcomp11 |       2124 |     NULL |               32 |               NULL |
| 2019-02-15 04:22:53 | 2019-05-22 02:05:50 |* 35 | d46e257b-adf5-4299-8f61-d759ae2a8b13 | spgm01drcomp12 |       2285 |     NULL |               35 |               NULL |
| 2019-02-16 03:11:41 | 2019-05-22 02:06:14 | 38 | a4142a40-677e-4a8a-a3c9-1532fa157d02 | spgm01drcomp13 |       2026 |     NULL |               38 |               NULL |
| 2019-02-16 03:43:46 | 2019-05-22 02:03:18 | 41 | ef7169e7-8a77-461c-ab0f-3b294aceaef7 | spgm01drcomp14 |       1807 |     NULL |               41 |               NULL |
| 2019-02-16 03:55:26 | 2019-05-22 02:05:19 | 44 | eecc9c07-de1d-4caa-a3e9-fd40d33014f2 | spgm01drcomp15 |       1795 |     NULL |               44 |               NULL |
| 2019-02-16 04:03:21 | 2019-05-22 02:02:35 | 47 | ac2e025c-b12a-48f1-b6f6-f14603d9688c | spgm01drcomp16 |       1815 |     NULL |               47 |               NULL |
| 2019-02-16 04:11:09 | 2019-05-22 02:05:33 | 50 | 5996ad47-cf36-407d-b409-b8e4aa4ba6de | spgm01drcomp17 |       1909 |     NULL |               50 |               NULL |
| 2019-02-16 04:42:23 | 2019-05-22 02:04:13 | 53 | 26db6cc6-7a6e-44c9-a2bc-b2ff7e0c36d1 | spgm01drcomp18 |       1946 |     NULL |               53 |               NULL |
| 2019-02-16 07:35:02 | 2019-05-22 02:06:12 | 56 | 27a7cbb8-cdfd-4d58-a252-e8c7880cd994 | spgm01drcomp19 |       1939 |     NULL |               56 |               NULL |
| 2019-02-16 07:42:23 | 2019-05-22 02:05:24 | 59 | eca6f7b9-270b-4906-b927-a5d1f0553e63 | spgm01drcomp20 |       1816 |     NULL |               59 |               NULL |
| 2019-02-16 07:48:16 | 2019-05-22 02:04:40 | 62 | b8dcbe41-1260-414a-9f14-288d2ab54e96 | spgm01drcomp21 |       2062 |     NULL |               62 |               NULL |
| 2019-02-16 08:00:50 | 2019-05-22 02:05:25 | 65 | 6ae5ee7a-1f69-4052-b0eb-c3a0a5de83ce | spgm01drcomp22 |       2094 |     NULL |               65 |               NULL |
| 2019-02-16 08:06:30 | 2019-05-22 02:04:40 | 68 | f0b456a7-2845-48c6-b78b-b2fd4fbe0175 | spgm01drcomp23 |       2077 |     NULL |               68 |               NULL |
| 2019-02-16 08:11:47 | 2019-05-22 02:03:15 | 71 | 57eb8c8c-ba1f-492f-b706-f160eef7cb58 | spgm01drcomp24 |       1891 |     NULL |               71 |               NULL |
| 2019-02-16 08:17:44 | 2019-05-22 02:02:27 | 74 | 4796e1d2-392b-4682-b36b-8a7c22513147 | spgm01drcomp25 |       1831 |     NULL |               74 |               NULL |
| 2019-02-16 08:23:31 | 2019-05-22 01:59:21 | 77 | 699db049-4767-4e84-8f1c-5beca0633a00 | spgm01drcomp26 |       1891 |     NULL |               77 |               NULL |
| 2019-02-16 08:29:06 | 2019-05-22 02:55:18 | 80 | 5249d3be-257d-40b6-8987-7d5de30df0b4 | spgm01drcomp27 |       2256 |     NULL |               80 |               NULL |
| 2019-02-16 08:34:44 | 2019-05-22 02:55:17 | 83 | d87a76f5-7657-4c59-8bc6-0ecec9276077 | spgm01drcomp28 |       2251 |     NULL |               83 |               NULL |
+---------------------+---------------------+----+--------------------------------------+----------------+------------+----------+------------------+--------------------+


SELECT   resource_provider_id , count(distinct consumer_id) as count    FROM nova_api.allocations  group by resource_provider_id ;






SELECT * FROM nova_api.allocations where resource_provider_id = 83 order by consumer_id;

select uuid from nova.instances where vm_state = 'active' and host='SPGM01DRCOMP27';

delete FROM nova_api.allocations where resource_provider_id = 83 and consumer_id not in (select uuid from nova.instances where vm_state = 'active' and host='SPGM01DRCOMP28');
delete FROM nova_api.allocations where resource_provider_id = 80 and consumer_id not in (select uuid from nova.instances where vm_state = 'active' and host='SPGM01DRCOMP27');




***************************************************

delete FROM nova_api.allocations where  consumer_id not in (select uuid from nova.instances where vm_state = 'active' );

**************************************************





delete FROM nova_api.allocations where resource_provider_id = 80 and consumer_id='e202bcc8-61b3-4c7e-aab3-64c909c741e9';


commit;

SELECT * FROM nova_api.allocations where resource_provider_id = 80 order by consumer_id;
+---------------------+------------+-------+----------------------+--------------------------------------+-------------------+-------+
| created_at          | updated_at | id    | resource_provider_id | consumer_id                          | resource_class_id | used  |
+---------------------+------------+-------+----------------------+--------------------------------------+-------------------+-------+
| 2019-05-10 09:28:57 | NULL       | 29535 |                   80 | 134463cd-6208-4a88-ac17-bf601e4480c7 |                 2 |    50 |
| 2019-05-10 09:28:57 | NULL       | 29529 |                   80 | 134463cd-6208-4a88-ac17-bf601e4480c7 |                 0 |    20 |
| 2019-05-10 09:28:57 | NULL       | 29532 |                   80 | 134463cd-6208-4a88-ac17-bf601e4480c7 |                 1 | 36864 |



| 2019-05-09 08:32:19 | NULL       | 29325 |                   80 | c58c4bc6-a6e1-40a7-83ff-fba045522843 |                 1 | 18432 |
| 2019-05-09 08:32:19 | NULL       | 29328 |                   80 | c58c4bc6-a6e1-40a7-83ff-fba045522843 |                 2 |    50 |
| 2019-05-09 08:32:19 | NULL       | 29322 |                   80 | c58c4bc6-a6e1-40a7-83ff-fba045522843 |                 0 |    10 |

| 2019-05-09 09:14:25 | NULL       | 29369 |                   80 | e202bcc8-61b3-4c7e-aab3-64c909c741e9 |                 1 | 18432 |
| 2019-05-09 09:14:25 | NULL       | 29366 |                   80 | e202bcc8-61b3-4c7e-aab3-64c909c741e9 |                 0 |    10 |
| 2019-05-09 09:14:25 | NULL       | 29372 |                   80 | e202bcc8-61b3-4c7e-aab3-64c909c741e9 |                 2 |    50 |
+---------------------+------------+-------+----------------------+--------------------------------------+-------------------+-------+





| 2019-05-20 04:44:37 | NULL       | 37053 |                   80 | a2a4f418-7f66-42a4-9a13-307ca072ed29 |                 0 |     8 |
| 2019-05-20 04:44:37 | NULL       | 37056 |                   80 | a2a4f418-7f66-42a4-9a13-307ca072ed29 |                 1 |  4096 |
| 2019-05-20 04:44:37 | NULL       | 37059 |                   80 | a2a4f418-7f66-42a4-9a13-307ca072ed29 |                 2 |     4 |

| 2019-05-20 09:17:28 | NULL       | 37257 |                   80 | a776a839-c4a9-4835-a167-28ca91f4c4ea |                 0 |     8 |
| 2019-05-20 09:17:28 | NULL       | 37263 |                   80 | a776a839-c4a9-4835-a167-28ca91f4c4ea |                 2 |     4 |
| 2019-05-20 09:17:28 | NULL       | 37260 |                   80 | a776a839-c4a9-4835-a167-28ca91f4c4ea |                 1 |  4096 |

| 2019-05-20 06:52:02 | NULL       | 37143 |                   80 | c5203cc9-5ef1-4b5d-8411-49aae761969a |                 0 |     8 |
| 2019-05-20 06:52:02 | NULL       | 37149 |                   80 | c5203cc9-5ef1-4b5d-8411-49aae761969a |                 2 |     4 |
| 2019-05-20 06:52:02 | NULL       | 37146 |                   80 | c5203cc9-5ef1-4b5d-8411-49aae761969a |                 1 |  4096 |





insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',29535,80,'134463cd-6208-4a88-ac17-bf601e4480c7',2,50);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',29529,80,'134463cd-6208-4a88-ac17-bf601e4480c7',0,20);
insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',29532,80,'134463cd-6208-4a88-ac17-bf601e4480c7',1,36864);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',37053,80,'a2a4f418-7f66-42a4-9a13-307ca072ed29',0,8);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',37056,80,'a2a4f418-7f66-42a4-9a13-307ca072ed29',1,4096);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',37059,80,'a2a4f418-7f66-42a4-9a13-307ca072ed29',2,4);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',37257,80,'a776a839-c4a9-4835-a167-28ca91f4c4ea',0,8);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',37263,80,'a776a839-c4a9-4835-a167-28ca91f4c4ea',2,4);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',37260,80,'a776a839-c4a9-4835-a167-28ca91f4c4ea',1,4096);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',37143,80,'c5203cc9-5ef1-4b5d-8411-49aae761969a',0,8);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',37149,80,'c5203cc9-5ef1-4b5d-8411-49aae761969a',2,4);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',37146,80,'c5203cc9-5ef1-4b5d-8411-49aae761969a',1,4096);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',29325,80,'c58c4bc6-a6e1-40a7-83ff-fba045522843',1,18432);

insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',29328,80,'c58c4bc6-a6e1-40a7-83ff-fba045522843',2,50);



insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',29322,80,'c58c4bc6-a6e1-40a7-83ff-fba045522843',0,10);




insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',29369,80,'e202bcc8-61b3-4c7e-aab3-64c909c741e9',1,18432);
insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',29366,80,'e202bcc8-61b3-4c7e-aab3-64c909c741e9',0,10);
insert into nova_api.allocations (created_at,id,resource_provider_id,consumer_id,resource_class_id,used) values ('2019-05-10 09:28:57',29372,80,'e202bcc8-61b3-4c7e-aab3-64c909c741e9',2,50);




select display_name, vm_state from nova.de where display_name='lamtv_test_live28' and vm_state !='deleted'  ;


•	Trên máy 10.255.26.72  10.255.26.99 chạy ssh-keygen
•	Trên máy 10.255.26.100:  ssh-copy-id root@172.16.30.85
  - source ~/open.rc && openstack user create --domain default --password GfvDCTgUVLYsotdmjCiK6tIRATsgjSTp demo
    - source ~/open.rc && openstack role create user
    - source ~/open.rc && openstack role add --project demo --user demo user



    openstack server create \
--image rhel76_ems \
--nic net-id=sriov \
--key-name lamtv10 \
--flavor 4C8G12G1H \
--availability-zone nova:computebeta \
--wait lamtvxxx



52:54:00:8d:54:c6 

fa:16:3e:03:51:31


 /etc/openstack-dashboard/local_settings.py 

 /etc/apache2/conf-available/openstack-dashboard.conf 

 /etc/apache2/conf-enabled/openstack-dashboard.conf 


 SSLEngine on
 SSLCipherSuite ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS:!RC4
 SSLCertificateKeyFile /etc/keystone/ssl/certs/key.pem
 SSLCertificateFile /etc/keystone/ssl/certs/cert.pem
 SSLCACertificateFile /etc/keystone/ssl/certs/ca.pem


sudo a2enmod ssl

 docker run  --name keystone --network=host --restart unless-stopped -u root -v /apache2/keystone:/var/log/apache2 -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime  -e KEYSTONE_START='START_KEYSTONE' docker-registry:4000/keystone:q

 vim /etc/apache2/sites-enabled/keystone.conf

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

https://controller:5000/v3/
UPDATE keystone.endpoint SET url = "https://os.controller:8774/v2.1" WHERE url="https://os.controller:8774/v2.1 ";


UPDATE keystone.endpoint SET url = "https://os.controller:8776/v2/%(project_id)s" WHERE service_id="7f807bbb97c543ccb997b49e3753ff86";


UPDATE keystone.endpoint SET url = "http://127.0.0.1:8776/v3/%(project_id)s" WHERE id="http://controller:8776/v3/%(project_id)s";

curl https://controller:9292/


docker run -d --name glance-api --network=host --restart unless-stopped -v /u01/docker/docker_log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_API' docker-registry:4000/glance:q
docker run -d --name glance-registry --network=host --restart unless-stopped -v /u01/docker/docker_log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_REGISTRY' docker-registry:4000/glance:q


docker cp /usr/share/docker/keystone/keystone/ssl/certs/ca.pem  nova-api:/etc/ssl/certs/ca-certificates.crt



docker restart nova-api  nova-consoleauth nova-scheduler nova-conductor nova-novncproxy nova-placement-api 



docker cp /usr/share/docker/keystone/keystone/ssl/certs/ca.pem  nova-api:/etc/ssl/certs/ca-certificates.crt
docker cp /usr/share/docker/keystone/keystone/ssl/certs/ca.pem  nova-consoleauth:/etc/ssl/certs/ca-certificates.crt
docker cp /usr/share/docker/keystone/keystone/ssl/certs/ca.pem  nova-scheduler:/etc/ssl/certs/ca-certificates.crt
docker cp /usr/share/docker/keystone/keystone/ssl/certs/ca.pem  nova-conductor:/etc/ssl/certs/ca-certificates.crt
docker cp /usr/share/docker/keystone/keystone/ssl/certs/ca.pem  nova-novncproxy:/etc/ssl/certs/ca-certificates.crt
docker cp /usr/share/docker/keystone/keystone/ssl/certs/ca.pem  nova-placement-api:/etc/ssl/certs/ca-certificates.crt



docker cp ca.pem  horizon:/etc/ssl/certs/ca-certificates.crt


-----BEGIN CERTIFICATE-----
MIID7zCCAtegAwIBAgIJAINn9OvsVgzvMA0GCSqGSIb3DQEBCwUAMIGNMQswCQYD
VQQGEwJWTjELMAkGA1UECAwCSE4xDjAMBgNVBAcMBUhhTm9pMRAwDgYDVQQKDAdW
aWV0dGVsMRMwEQYDVQQLDApjb250cm9sbGVyMRMwEQYDVQQDDApjb250cm9sbGVy
MSUwIwYJKoZIhvcNAQkBFhZsYW10djEwQHZpZXR0ZWwuY29tLnZuMB4XDTE5MDcy
NDA5NDgxNloXDTIyMDUxMzA5NDgxNlowgY0xCzAJBgNVBAYTAlZOMQswCQYDVQQI
DAJITjEOMAwGA1UEBwwFSGFOb2kxEDAOBgNVBAoMB1ZpZXR0ZWwxEzARBgNVBAsM
CmNvbnRyb2xsZXIxEzARBgNVBAMMCmNvbnRyb2xsZXIxJTAjBgkqhkiG9w0BCQEW
FmxhbXR2MTBAdmlldHRlbC5jb20udm4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDG+qUZ357YO6Y1EtIW7bmdpbxO63OltxPinqhXkl1ZCNcSd2QrAK0/
Wrvk2OgIfM4vj1KmWPGiqyjvzJNZIijLeDqbjcex/VxfXgHOND4BkanvkbbO8Pxh
oN4fp7ZKkBlhmNEF5RO+m+6I0R7jkIxQLbL//RPRmt2iWhUihGhD3dSh7QR1ry9S
SagXERzpfDysV84eYuRoyMndfMJnRaL/1E1gM0Sn3wSV9O+Shg+qm3ha7cv9t1W5
ZXWV+ClReM+eYl6V6+M2Ux6KLEcDTja3Qz5CSi5cA85rZFeAfwq/ANs3q0kR83qe
FSNI4kYpOJP/RgqevfTT5RHw4pPJkuoJAgMBAAGjUDBOMB0GA1UdDgQWBBRpQQOW
wKPO+ZOwurhNkIRBvL6C8DAfBgNVHSMEGDAWgBRpQQOWwKPO+ZOwurhNkIRBvL6C
8DAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQCzERq++zMXOPWDuSbr
Ljj65Q2+kcVI5FdSI/XkQhxu6VasFYP1zdL+EHItq5E0ulFeucfXklLPnX04VtvI
kMAxcCDwOKtg6+Ccg0dKPqOCRKYGvRZ9dzOIyCRd0GlVljNg4oGRU6zO/GtG8ArI
DFxwg99B+cgkIs+3BsFGrhdyIUC3QFYYX6ZAnTkH8hh+N8u19/wRyudYz37UVFNu
IwR+2lswIVtFI0h7Rf316FvObtEehzRDFFXgxXAf0oVOgP7WZa59ot1X0p3/A8Nv
8LRDognuJ3GfVyJKQ896fi74d1B2seTtMWtTGuGyqs77IvcLyi61qPOBjAN/lsDo
//7B
-----END CERTIFICATE-----




----------------------------------------------------------------------------------------------------
[root@controller ~]# openssl s_client -help 2>&1  > /dev/null | egrep "\-(ssl|tls)[^a-z]"
 -ssl3         - just use SSLv3
 -tls1_2       - just use TLSv1.2
 -tls1_1       - just use TLSv1.1
 -tls1         - just use TLSv1
----------------------------------------------------------------------------------------------------


ServerName controller

# local eth0 IP
Listen 172.16.30.85:8774

<VirtualHost 172.16.30.85:8774>
    # same as ServerName above
    ServerName            controller

    SSLEngine             On
    SSLProtocol           +SSLv3 +TLSv1
    SSLCipherSuite        HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM
    SSLCACertificateFile  /usr/share/docker/keystone/keystone/ssl/certs/ca.pem
    SSLCertificateFile    /usr/share/docker/keystone/keystone/ssl/certs/cert.pem
    SSLCertificateKeyFile /usr/share/docker/keystone/keystone/ssl/certs/key.pem

    # custom header for Paste SSLMiddleware
    RequestHeader   set   X-Forwarded-Proto "https"

    ProxyRequests off
    ProxyPreserveHost on
    ProxyPass / http://127.0.0.1:8774/
    ProxyPassReverse / http://127.0.0.1:8774/

    LogLevel warn
 	ErrorLog /apache2/nova/nova_api_error.log
    CustomLog /apache2/nova/nova_api_access.log combined
</VirtualHost>































UPDATE keystone.endpoint SET url = "https://os.controller:5000/v3" WHERE url="http://os-controller:5000/v3/";


UPDATE keystone.endpoint SET url = "https://controller:8774/v2.1"  WHERE id="0f5bfecd7e2e401a8f7a9ff8b8a05c72";



UPDATE keystone.endpoint SET url = "https://controller:8774/v2.1" WHERE url="http://localhost:8774/v2.1";
UPDATE keystone.endpoint SET url = "https://controller:8778" WHERE url="http://localhost:8778";


UPDATE keystone.endpoint SET url = "http://localhost:8774/v2.1" WHERE url="https://controller:8774/v2.1";
UPDATE keystone.endpoint SET url = "https://os.controller:5000/v3" WHERE url="https://controller:5000/v3";

http://os-controller:9696


UPDATE keystone.endpoint SET url = "https://controller:8776/v3/%(project_id)s" WHERE url="https://controller/v3/%(project_id)s";


17   yum install apache
  418   yum install apache2
  419  yum install httpd
  421  yum install http
  422   yum install httpie


openstack server create \
--image rhel76_ems \
--nic net-id=finance-network1 \
--key-name example-keypair \
--flavor default \
--availability-zone nova:compute0.overcloud.example.com \
--wait finance-server1

 nova boot --flavor 4C8G12G1H_noPIN  --image rhel76_ems  --key-name lamtv10    --nic net-id=sriov --availability-zone nova:computealpha  alphaX_sriov --debug
docker restart nova-placement-api nova-novncproxy nova-conductor nova-scheduler nova-api nova-consoleauth 


grep -rnw '/path/to/somewhere/' -e 'pattern'

WSGIScriptAlias /horizon /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi process-group=horizon
WSGIDaemonProcess horizon user=horizon group=horizon processes=3 threads=10 display-name=%{GROUP}
WSGIProcessGroup horizon
WSGIApplicationGroup %{GLOBAL}

Alias /static /var/lib/openstack-dashboard/static/
Alias /horizon/static /var/lib/openstack-dashboard/static/

<Directory /usr/share/openstack-dashboard/openstack_dashboard/wsgi>
  Require all granted
</Directory>

<Directory /var/lib/openstack-dashboard/static>
  Require all granted
</Directory>

=========================
Listen 80

<VirtualHost *:80 >
    LogLevel debug
    ErrorLog /var/log/apache2/horizon.log
    CustomLog /var/log/apache2/horizon_access.log combined

    WSGIScriptAlias /horizon /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi process-group=horizon
    WSGIDaemonProcess horizon user=www-data group=www-data processes=3 threads=10 display-name=%{GROUP}
    WSGIProcessGroup horizon
    WSGIApplicationGroup %{GLOBAL}

    Alias /static /var/lib/openstack-dashboard/static/
    Alias /horizon/static /var/lib/openstack-dashboard/static/

    <Directory /usr/share/openstack-dashboard/openstack_dashboard/wsgi>
      Require all granted
    </Directory>

    <Directory /var/lib/openstack-dashboard/static>
      Require all granted
    </Directory>
</VirtualHost>



grep -rnw '/usr/share/openstack-dashboard' -e '5000'
 cd /usr/share/openstack-dashboard/openstack_dashboard/local/
 :set nu




 LISTEN 172.16.30.85:444


<VirtualHost *:80>
ServerName openstack.example.com
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}
</IfModule>
<IfModule !mod_rewrite.c>
RedirectPermanent / https://openstack.example.com
</IfModule>
</VirtualHost>
<VirtualHost *:444>



    LogLevel debug
    ErrorLog /var/log/apache2/horizon.log
    CustomLog /var/log/apache2/horizon_access.log combined
ServerName openstack.example.com

SSLEngine On
SSLCertificateFile /etc/openstack-dashboard/cert.pem
SSLCACertificateFile /etc/openstack-dashboard/ca.pem
SSLCertificateKeyFile /etc/openstack-dashboard/key.pem
SetEnvIf User-Agent ".*MSIE.*" nokeepalive ssl-unclean-shutdown
#Header add Strict-Transport-Security "max-age=15768000"
WSGIScriptAlias / /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi  process-group=horizon
WSGIDaemonProcess horizon user=www-data group=www-data processes=3 threads=10 display-name=%{GROUP}
   WSGIProcessGroup horizon
    WSGIApplicationGroup %{GLOBAL}
    Alias /static /var/lib/openstack-dashboard/static/
    Alias /horizon/static /var/lib/openstack-dashboard/static/


<Directory /usr/share/openstack-dashboard/openstack_dashboard/wsgi>
        Require all granted
</Directory>
<Directory /usr/share/openstack-dashboard/static>
        Require all granted
</Directory>
</VirtualHost>
sudo a2enmod ssl



settings.py

AVAILABLE_REGIONS = [
     ('https://controller:5000/v3', 'local'),
      ('https://controller:5000/v3', 'remote'),
 ]
   

 
OPENSTACK_KEYSTONE_URL = "https://controller:5000/v3"






test_horizon.sh
docker stop horizon
docker rm horizon
docker run -d --name horizon --network=host --restart unless-stopped -u root -v /var/log/docker/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e HORIZON_START='START_HORIZON' docker-registry:4000/horizon:q 
docker   cp  settings.py horizon:/usr/share/openstack-dashboard/openstack_dashboard/
docker cp ca.pem  horizon:/etc/ssl/certs/ca-certificates.crt
docker restart horizon



[req-6d02284b-8b44-4cfb-936b-1a15144dd202 51f36bff8ea24f748232d9cc83d8e41b 0171c410083d4b8d96969b6735e3f75a 


 nova  --debug boot --flavor 4C8G12G1H_noPIN  --image rhel76_ems  --key-name lamtv10    --nic net-id=a82c1be7-7e04-4216-9786-812cbdd97afa --availability-zone nova:computealpha  alphaX_sriov








 ****************************************
 /etc/haproxy/haproxy.conf 

global

    log /dev/log        local0
    log /dev/log        local1 notice

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     10000
    user        haproxy
    group       haproxy
    daemon
    stats socket /var/lib/haproxy/stats

defaults
    mode                    http
    log                     global
    option                  httplog
    #option http-server-close
    option forwardfor
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    #timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 10000


listen stats
  bind 172.16.30.88:1995
  mode http
  stats enable
  stats uri /
  stats refresh 15s
  stats realm Haproxy\ Stats
  stats auth cloud:GdYc6d8jYwURfAn5A3sc08Ipt5zcanPl

#listen horizon
#  bind 172.16.30.88:80
#  http-request del-header X-Forwarded-Proto
#  server controller 172.16.30.85:80 check inter 2000 rise 2 fall 5
 # server controller86 172.16.30.86:80 check inter 2000 rise 2 fall 5
#  server controller87 172.16.30.87:80 check inter 2000 rise 2 fall 5
#listen neutron_server
#  bind 172.16.30.88:9696
#  http-request del-header X-Forwarded-Proto
#  server controller 172.16.30.85:9696 check inter 2000 rise 2 fall 5
 # server controller86 172.16.30.86:9696 check inter 2000 rise 2 fall 5
 # server controller87 172.16.30.87:9696 check inter 2000 rise 2 fall 5
#listen cinder_api
#  bind 172.16.30.88:8776
#  http-request del-header X-Forwarded-Proto
#  server controller 172.16.30.85:8776 check inter 2000 rise 2 fall 5
 # server controller86 172.16.30.86:8776 check inter 2000 rise 2 fall 5
 # server controller87 172.16.30.87:8776 check inter 2000 rise 2 fall 5
listen keystone
  bind 172.16.30.88:5000  ssl crt /usr/share/docker/keystone/keystone/ssl/certs/haproxy_ssl/cert_key.pem
  reqadd X-Forwarded-Proto:\ https
   # default_backend application-backend
  #http-request del-header X-Forwarded-Proto
  server controller controller:5000 check-ssl ssl  crt  /usr/share/docker/keystone/keystone/ssl/certs/key_cert.pem   verify required  ca-file /usr/share/docker/keystone/keystone/ssl/certs/ca.pem
  # server controller controller:5000 check-ssl ssl    verify none



************************ Them vao may docker container tren compute  file ca-certificates





cat /sys/class/net/p1p1/carrier


openssl pkcs12 -export -keypbe PBE-SHA1-3DES -certpbe PBE-SHA1-3DES -export -in server_cert.pem -inkey private_key.pem -name akka -out keystore.p12

openssl req -newkey rsa:2048 -keyout private_key.key  -out cert_req.pem -outform PEM -config cert_req.conf -nodes





java  -javaagent:./jetty-alpn-agent-2.0.9.jar -cp "./lib/*.jar:AkkaServer.jar"  -DnumberThread=1 -DpoolSize=10 akkaserver.Http2JavaServerTest  9001

./bin/keytool -import -v -trustcacerts -alias controller -file server -keystore cacerts.jks -keypass changeit -storepass changeit

bin/keytool -import -v -trustcacerts -alias controller -file cacert.crt -keystore lib/security/cacerts   -keypass changeit -storepass changeit


 ./bin/keytool -import -v -trustcacerts -alias jetty -file cacert.crt -keystore  lib/security/cacerts   -keypass changeit -storepass changeit

 sudo  ./bin/keytool -import -v -trustcacerts -alias jetty -file cacert.crt -keystore  jre/lib/security/cacerts   -keypass changeit -storepass changeit
-Xbootclasspath/p:/home/vttek/JAVA_LIB/alpn-boot-8.1.12.v20180117.jar


-Xbootclasspath/p:/home/vttek/JAVA_LIB/lib_jetty_9.4.20/jetty-alpn-conscrypt-server-9.4.20.v20190813.jar
/root/lamtv10/bin/java   -Xbootclasspath/p:alpn-boot-8.1.12.v20180117.jar -cp "./lib/*.jar:JavaJettyHttp2.jar"   -DpoolSize=10 server.Http2Server  9001



cd /root/jetty940/
/root/lamtv10/bin/java   -Xbootclasspath/p:alpn-boot-8.1.12.v20180117.jar -cp "./lib/*.jar:jetty940.jar"    test.Http2Server  

/root/lamtv10/bin/java   -Xbootclasspath/p:alpn-boot-8.1.12.v20180117.jar -cp "./lib/*.jar:jetty940.jar"   -Dselectors=1     -DnumberThread=1 -DmsgSize=2000   -DpoolSize=1   test.SendLowLevelClient   


cd /root/AkkaTool/dist
/root/lamtv10/bin/java  	-cp "./lib/*.jar:AkkaTool.jar"  akkatool.HighLevelAkka
/root/lamtv10/bin/java 	-cp "./lib/*.jar:AkkaTool.jar"  -DnumberThread=10 -DmsgSize=300 -Dhost=172.16.30.84 akkatool.SendHttpHighLevel 


REST All: 388635 AvgTime: 0 Current: 2819 AvgTime: 0.34 CurrentTps: 2816.18 MaxResTime: 3
REST All Send: 2838 CurrentTpsSend: 2835.16
                                        
62.8% 0.6% client 
40% 0.6% server  


60% 0.4% client + server 




openstack project create --description 'mano' mano --domain default
openstack user create --project mano --password "Vttek@123" mano 
openstack role add --user mano --project mano admin



==============================================================================================================================
docker save --output jaegertracing.tar  jaegertracing/all-in-one:latest



[root@controller01 lamtv10]# pip install jaeger-client
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7. More details about Python 2 support in pip, can be found at https://pip.pypa.io/en/latest/development/release-process/#python-2-support
Collecting jaeger-client
  Downloading https://files.pythonhosted.org/packages/f1/da/569a4f1bc3d0c412c7f903053f09ef62fa10949374ca90bc852b22dd3860/jaeger-client-4.1.0.tar.gz (80kB)
     |████████████████████████████████| 81kB 995kB/s 
Collecting threadloop<2,>=1 (from jaeger-client)
  Downloading https://files.pythonhosted.org/packages/dc/1a/ecc8f9060b8b00f8a7edac9eb020357575d332a5ad9e32c3372c66a35f79/threadloop-1.0.2-py2-none-any.whl
Collecting thrift (from jaeger-client)
  Downloading https://files.pythonhosted.org/packages/c6/b4/510617906f8e0c5660e7d96fbc5585113f83ad547a3989b80297ac72a74c/thrift-0.11.0.tar.gz (52kB)
     |████████████████████████████████| 61kB 17.3MB/s 
Collecting tornado<6,>=4.3 (from jaeger-client)
  Downloading https://files.pythonhosted.org/packages/e6/78/6e7b5af12c12bdf38ca9bfe863fcaf53dc10430a312d0324e76c1e5ca426/tornado-5.1.1.tar.gz (516kB)
     |████████████████████████████████| 522kB 23.5MB/s 
Collecting opentracing<3.0,>=2.1 (from jaeger-client)
  Downloading https://files.pythonhosted.org/packages/94/9f/289424136addf621fb4c75624ef9a3a80e8575da3993a87950c57e93217e/opentracing-2.2.0.tar.gz (47kB)
     |████████████████████████████████| 51kB 7.6MB/s 
Requirement already satisfied: futures in /usr/lib/python2.7/site-packages (from jaeger-client) (3.1.1)
Requirement already satisfied: six>=1.7.2 in /usr/lib/python2.7/site-packages (from thrift->jaeger-client) (1.10.0)
Requirement already satisfied: singledispatch in /usr/lib/python2.7/site-packages (from tornado<6,>=4.3->jaeger-client) (3.4.0.3)
Collecting backports_abc>=0.4 (from tornado<6,>=4.3->jaeger-client)
  Downloading https://files.pythonhosted.org/packages/7d/56/6f3ac1b816d0cd8994e83d0c4e55bc64567532f7dc543378bd87f81cebc7/backports_abc-0.5-py2.py3-none-any.whl
Installing collected packages: backports-abc, tornado, threadloop, thrift, opentracing, jaeger-client
  Running setup.py install for tornado ... done
  Running setup.py install for thrift ... done
  Running setup.py install for opentracing ... done
  Running setup.py install for jaeger-client ... done
Successfully installed backports-abc-0.5 jaeger-client-4.1.0 opentracing-2.2.0 threadloop-1.0.2 thrift-0.11.0 tornado-5.1.1
WARNING: You are using pip version 19.2.2, however version 19.3.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# ll
total 52428
-rw-------. 1 root root 51527168 Oct 21 10:40 jaegertracing.tar
-rw-r--r--. 1 root root  1360957 May  6 21:55 pip-19.1.1-py2.py3-none-any.whl
-rw-r--r--. 1 root root   793737 Apr 23  2016 setuptools-7.0.tar.gz
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# docker run -d -p6831:6831/udp -p16686:16686 jaegertracing/all-in-one:latest
cc767a2edd7fc3cf609313012a638f2b40b0345a8c9e01f65d21456732389a9a
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# firefox
X11 connection rejected because of wrong authentication.
Failed to open connection to "session" message bus: /usr/bin/dbus-launch terminated abnormally with the following error: Autolaunch error: X11 initialization failed.

Running without a11y support!
X11 connection rejected because of wrong authentication.
X11 connection rejected because of wrong authentication.
Error: cannot open display: localhost:14.0
[root@controller01 lamtv10]# ll
total 52428
-rw-------. 1 root root 51527168 Oct 21 10:40 jaegertracing.tar
-rw-r--r--. 1 root root  1360957 May  6 21:55 pip-19.1.1-py2.py3-none-any.whl
-rw-r--r--. 1 root root   793737 Apr 23  2016 setuptools-7.0.tar.gz
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# vim jaegertest.py
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# 
[root@controller01 lamtv10]# python jaegertest.py joker
Traceback (most recent call last):
  File "jaegertest.py", line 6, in <module>
    from opentracing_instrumentation.request_context import get_current_span, span_in_context
ImportError: No module named opentracing_instrumentation.request_context
[root@controller01 lamtv10]# pip install opentracing_instrumentation
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7. More details about Python 2 support in pip, can be found at https://pip.pypa.io/en/latest/development/release-process/#python-2-support
Collecting opentracing_instrumentation
  Downloading https://files.pythonhosted.org/packages/0d/c7/21cb06a5b9356e3328f1bbea47575b62bd697382276c43f240e615eabfc5/opentracing_instrumentation-3.2.1.tar.gz
Collecting future (from opentracing_instrumentation)
  Downloading https://files.pythonhosted.org/packages/3f/bf/57733d44afd0cf67580658507bd11d3ec629612d5e0e432beb4b8f6fbb04/future-0.18.1.tar.gz (828kB)
     |████████████████████████████████| 829kB 3.1MB/s 
Requirement already satisfied: wrapt in /usr/lib64/python2.7/site-packages (from opentracing_instrumentation) (1.10.8)
Requirement already satisfied: tornado<6,>=4.1 in /usr/lib64/python2.7/site-packages (from opentracing_instrumentation) (5.1.1)
Requirement already satisfied: contextlib2 in /usr/lib/python2.7/site-packages (from opentracing_instrumentation) (0.5.1)
Requirement already satisfied: opentracing<3,>=2 in /usr/lib/python2.7/site-packages (from opentracing_instrumentation) (2.2.0)
Requirement already satisfied: six in /usr/lib/python2.7/site-packages (from opentracing_instrumentation) (1.10.0)
Requirement already satisfied: futures in /usr/lib/python2.7/site-packages (from tornado<6,>=4.1->opentracing_instrumentation) (3.1.1)
Requirement already satisfied: singledispatch in /usr/lib/python2.7/site-packages (from tornado<6,>=4.1->opentracing_instrumentation) (3.4.0.3)
Requirement already satisfied: backports_abc>=0.4 in /usr/lib/python2.7/site-packages (from tornado<6,>=4.1->opentracing_instrumentation) (0.5)
Installing collected packages: future, opentracing-instrumentation
  Running setup.py install for future ... done
  Running setup.py install for opentracing-instrumentation ... done
Successfully installed future-0.18.1 opentracing-instrumentation-3.2.1
WARNING: You are using pip version 19.2.2, however version 19.3.1 is available.




===========================================================================================================================================
===========================================================================================================================================
===========================================================================================================================================
===========================================================================================================================================
===========================================================================================================================================


https://ropenscilabs.github.io/r-docker-tutorial/04-Dockerhub.html





ln -s    /home/repo/centos/ centos

ln -s    /home/repo/docker.centos.7.x86_64/  docker.centos.7.x86_64

ln -s   /home/repo/epel7server/  epel7server

ln -s    /home/repo/percona.release.7Server.RPMS.x86_64/  percona.release.7Server.RPMS.x86_64

ln -s    /home/repo/percona.release.7Server.RPMS.noarch/   percona.release.7Server.RPMS.noarch

ln -s    /home/repo/centos.7.virt.x86_64.kvm-common/   centos.7.virt.x86_64.kvm-common

ln -s   /home/repo/centos.7.cloud.x86_64.openstack-queens/   centos.7.cloud.x86_64.openstack-queens 

ln -s    /home/repo/centos.7.cloud.x86_64.openstack-queens/   buildlogs.centos.7.cloud.x86_64.openstack-queens



ln -s  docker -> /home/repo/docker


# vi /etc/sysctl.conf
vm.nr_hugepages = 10
2. Execute ‘sysctl -p’ command to enable the hugepages parameter.

# sysctl -p
...
vm.nr_hugepages = 10


/home/vttek/lamtv10/dbeaver/dbeaver
ip route add 172.16.28.0/24 dev eno1



conda deactivate
conda remove --name viettel --all
cd /home/vttek/anaconda2/envs/
scp -r root@172.16.29.193:/root/anaconda2/envs/viettel ./
conda info --envs
conda acitvate viettel



