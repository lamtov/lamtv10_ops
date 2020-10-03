docker.js
vim /etc/systemd/system/docker.service.d/http-proxy.conf 



			[Service]
			Environment="HTTP_PROXY=http://172.16.30.81:3128/" "NO_PROXY=172.16.30.0/24"

[root@CBATEST37 sonpt26]# cat /etc/sysconfig/docker 
# /etc/sysconfig/docker
#
# Other arguments to pass to the docker daemon process
# These will be parsed by the sysv initscript and appended
# to the arguments list passed to docker -d

other_args="--insecure-registry docker-registry:4000"



				docker build -t base:queens --build-arg http_proxy=http://172.16.30.81:3128 --build-arg https_proxy=http://172.16.30.81:3128 . 
Error response from daemon: No such image: docker-registry:4000/base:latest
root@docker-registry:~# docker tag docker-registry:4000/base:q localhost:4000/base:q
root@docker-registry:~# docker tag docker-registry:4000/keystone:q localhost:4000/keystone:q
root@docker-registry:~# docker tag docker-registry:4000/nova:q localhost:4000/nova:q
root@docker-registry:~# docker tag docker-registry:4000/glance:q localhost:4000/glance:q
root@docker-registry:~# docker tag docker-registry:4000/neutron:q localhost:4000/neutron:q
root@docker-registry:~# docker tag docker-registry:4000/horizon:q localhost:4000/horizon:q
root@docker-registry:~# docker tag docker-registry:4000/cinder_volume:q localhost:4000/cinder_volume:q
root@docker-registry:~# docker tag docker-registry:4000/cinder_api:q localhost:4000/cinder_api:q
root@docker-registry:~# docker tag docker-registry:4000/cinder_scheduler:q localhost:4000/cinder_scheduler:q


docker update --restart=always <container>

*********//Cai dat docker registry
				
				docker pull registry:lastest

				docker run -d -p 5000:5000 --restart=always --name registry registry:latest
				docker pull ubuntu:16.04

				docker tag ubuntu:16.04 localhost:5000/my-ubuntu
				docker push localhost:5000/my-ubuntu

				docker container stop registry && docker container rm -v registry



				**** Tai cac server  pull 
					Cau hinh file /etc/docker/daemon.json
						 {
 						 	"insecure-registries" : ["172.16.30.82:5000"]
						 }



docker restart $(docker ps -a -q)
docker start $(docker ps -a -q -f status=running) //=exited
docker stop $(docker ps -a -q -f status=running)


docker rm $(docker ps -a -q)
***************** THAY DOI NOI LUU TRU DOCKER IMAGE:

			Sua file daemon.json 
			{
			  "insecure-registries" : ["172.16.30.82:5000"],
			"graph":"/u01/docker_storage/docker"
			}

			root@registry:/etc/docker# cp -r ./* /u01/docker_storage/docker/
			-- check docker info */
			ID: TFNY:OWEF:UH2V:3RKN:53LB:6WZ2:HONW:LSKA:W7OW:VBUP:I4VI:BCUQ
			Docker Root Dir: /u01/docker_storage/docker
			Debug Mode (client): false
			Debug Mode (server): false
			HTTP Proxy: http://172.16.30.81:3128/
			No Proxy: 172.16.30.0/24
			Registry: https://index.docker.io/v1/
			Labels:
			Experimental: false
			Insecure Registries:
			 172.16.30.82:5000
			 127.0.0.0/8
			Live Restore Enabled: false
			Product License: Community Engine
















ENV MY_IP="172.16.30.82"
ENV NOVA_DBPASS="o45OyDJ9b5jvD4fJzUBcLQI9qH4GrYUh"
ENV DB_HOST="os-controller"
ENV CONTROLLER_HOST="os-controller"
ENV REGION_NAME="North_VN"
ENV NOVA_PASS="2md1gLgBXezyJjo2YNVtZMnu5YNhRVT2"
ENV PLACEMENT_PASS="MsJ0eV5URqMgZ5H825HDbGsOeqnVmgIU"
ENV NEUTRON_PASS="SaKOfkrz1aADFGzZSWMUw1T4g8W3JA03"
ENV METADATA_PROXY_SHARED_SECRET="udQMCeqs7QOmRy2rKjvya37UNumH7ssJ"
ENV TRANSPORT_URL="rabbit://openstack:KFTA8eHMgiX4DDUcCKSsoTpZFGnCoBrA@controller01:5672,openstack:KFTA8eHMgiX4DDUcCKSsoTpZFGnCoBrA@controller02:5672,openstack:KFTA8eHMgiX4DDUcCKSsoTpZFGnCoBrA@controller03:5672"
ENV MEMCACHED_SERVERS="controller01:11211,controller02:11211,controller03:11211"
ENV MEMCACHE_SECRET_KEY="83c97PC5oxaMSNshhozIO0eDLZcHixmX"





#management-ip
MY_IP="172.16.30.82"


#glance-registry
REGISTRY_HOST=os-controller

#horizon-cache
MEMCACHED_SERVERS="controller01:11211,controller02:11211,controller03:11211"

#nova-cells
CELL_NAME=cell1

#mysql-db
DB_HOST=os-controller

#keystone-auth
CONTROLLER_HOST=os-controller
REGION_NAME=North_VN

#ha-queue
TRANSPORT_URL="rabbit://openstack:KFTA8eHMgiX4DDUcCKSsoTpZFGnCoBrA@controller01:5672,openstack:KFTA8eHMgiX4DDUcCKSsoTpZFGnCoBrA@controller02:5672,openstack:KFTA8eHMgiX4DDUcCKSsoTpZFGnCoBrA@controller03:5672"

#cache-pool
MEMCACHED_SERVERS=controller01:11211,controller02:11211,controller03:11211
MEMCACHE_SECRET_KEY="83c97PC5oxaMSNshhozIO0eDLZcHixmX"


docker build -t imagename -f Dockerfile .

docker create -p 80:80 nginx
docker run -rm -ti ubuntu:lastest /bin/bash

docker rm $(docker ps -a -q)

docker run ubuntu echo 'Hello world'

docker images

docker run -p 8080:80 -d nginx : Chạy trong background
docker run -p 8080:80 nginx : chạy với port 8080

			*************** PUBLISH VS EXPOSE ****************************
						EXPOSE chi ra cho Docker rang container dang chay se lang nghe tren mot network port cu the 

							docker run --expose=1234 my_app // 
							// Nhung EXPOSE khong cho phep giao tiep o ben ngoai mang hoac host machine

						PUBLISH : Cong khai mot container port ben ngoai container network va map chung voi hostmachine port 

								docker run -p 80:80/tcp -p 80:80/udp my_app


						De Publish tat ca port ban dinh nghia trong Dockerfile voi EXPOSE ba bind to hostmachine su dung -P flag



			**************************************************************



docker create --help
docker cookbook

docker create -p 9000:80 nginx //tạo cointainer cổng 9000 nhưng chưa start 
docker start .... 
docker stop ...
docker ps -a
docker rm


#VOLUME ["/var/www/html"]
#WORKDIR /var/www/html
#EXPOSE 9000
#CMD ["php7-fpm.0"]


### Chạy ứng dụng Web Wordpress thông qua hai container

Bài toán đặt ra là bạn muốn chạy Wordpress với container Docker nhưng không phải một cái Container mặc định Wordpress mà bạn muốn chạy thêm một container MySQL để lưu trữ cơ sở dữ liệu

Các bạn chú ý rằng bản thân cái Image Wordpress có thể chạy được mà không cần Image Mysql




- Image MySQL: https://hub.docker.com/_/mysql

- Imgage Wordpress: https://hub.docker.com/_/wordpress/

Trước tiên tôi giả sử bạn đã có sẳn 2 cái image ở trên nếu chưa có thì chỉ việc chạy lệnh sau:

```
docker pull mysql
docker pull wordpress

```

Sau đó bạn tạo một container MySQL thông qua lệnh sau:

```
docker run --name mysqlwp -e MYSQL_ROOT_PASSWORD=wordpressdocker -d mysql

```

Bây giờ bạn tạo container Wordpress sử dụng tham số --link để kết nối Image MySQL ở trên thây vì dùng MySQL mặc định trong image Wordpress

```
docker run --name wordpress --link mysqlwp:mysql -p 80:80 -d wordpress

```

Cả 2 container trên tôi chạy trong chế độ background bạn có thể xác nhận thông qua lệnh sau:

```
docker ps

```

bạn cũng có thể tạo container MySQL thông qua các biến bên dưới, tôi khuyên bạn nên dùg nó trong thực tế bởi vì chúng ta không nên dùng mặc định user root trong MYSQL

```
docker run --name mysqlwp -e MYSQL_ROOT_PASSWORD=wordpressdocker \
-e MYSQL_DATABASE=wordpress \
-e MYSQL_USER=wordpress \
-e MYSQL_PASSWORD=wordpresspwd \
-d mysql

https://gsviec.com/blog/gioi-thieu-docker-compose
https://docs.docker.com/compose/

RAM 1.25 CPU 4


pi# ll Dockerfile 
-rw-r--r-- 1 root root 1839 Nov 14 04:02 Dockerfile



#management-ip
MY_IP="{{ ansible_ssh_host }}"

#overlay-network
TUNNEL_IP="{{ ansible_ssh_host }}"

#glance-registry
REGISTRY_HOST=os-controller

#horizon-cache
MEMCACHED_SERVER="{{ ansible_ssh_host }}"

#nova-cells
CELL_NAME=cell1

#mysql-db
DB_HOST=os-controller

#keystone-auth
CONTROLLER_HOST=os-controller
REGION_NAME=North_VN

#ha-queue
TRANSPORT_URL="rabbit://openstack:{{ rabbit_passwd }}@controller01:5672,openstack:{{ rabbit_passwd }}@controller02:5672,openstack:{{ rabbit_passwd }}@controller03:5672"

#cache-pool
MEMCACHED_SERVERS=controller01:11211,controller02:11211,controller03:11211
MEMCACHE_SECRET_KEY=MEMCACHED_PASS



82 175 176



Ephemeral storage (nova)


Khi flavors trong compute service được cấu hình để cung cấp instances với root hoặc ephemeral disks, nova-compute service quản lý sự phân bổ này bằng cách sử dụng chính ephemeral disk storage location của nó.
Trong nhiều môi trường, ephemeral disk được lưu trên compute host local disk nhưng nên cấu hình Compute hosts để cấu hình sử dụng share storage subsystem thay thế. Một sharestorage subsystem cho phép nhanh chóng, live instance migration giữa các compute hosts và evacuate. 
Administrator có khả năng evacuate instance tới compute khác .



Block Devices vaf openstack
	Sử dụng với Openstack thoogn qua libvirt cấu hình QEMU interface cho librbd. 
	Các phần của Openstack tương tác với Ceph Storage Cluster:
		- Images: OpenStack Glance
		- Volumes: Sử dụng để boot VM, đính kèm để chạy VM sử dụng Cinder 
		- Guest Disks: Để sử dụng live-migration process thì cần boot VM bên trong Ceph mà ko dùng Cinder. 
	
	
	


Cấu hình Live Migration cho KVM và QEMU
- live_migration_completion_timeout // Abort migration khi nó chạy quá lâu (mặc định 800)
- live_migration_progress_timeout // Abort khi memory copy không thực hiện 
- live_migration_downtime: max permitted downtime cho một live-migration
- nova server-migration-list idserver //Lay thong tin id migration 
- nova migration-list //Lay thogn tin tat ca cac migration

- nova live-migration-abort instance_id migration_id 
		//tat huy bo live-migration
		
- nova live-migration-force-complete instance_id migration_id 
		//pause instance lai den khi live-migration xong ==> loi dong bo thoi gian do instance bi pause 
		
- live_migration_permit_auto_converge=true: Slowing down instance 
- live_migration_permit_post_copy=true : Cho hoat dongj luon o dau ben kia thay vi doi mem chuyen het sang 


Post-copy:
	+ Tại một level cao thì post-copy migration trì hoãn vận chuyển memory ra sau khi VM CPU state đã hoàn tất vận chuyển sang bên kia và đc resume ở đó
	+ Đầu tiên chuyển tất cả trạng thái processor state tới target khởi động VM ở target rồi mới Push VM'memory page từ sources tới target. Post-copy đồng thời đảm bảo rằng memory page chỉ được chuyển đi 1 lần tránh duplicate.
	+ Hiệu quả của post-copy phụ thuộc vào năng lực giảm number network bound page-faults (hoặc network faults) . Giảm netowrk faults thì sử dụng adaptive prepaging. 
	
Thiết kế: 
	1. Preparation Time: Thời gian giữa chuẩn bị migrationg và chuyển VM processor state tới target node, Cho pre-copy thời gian này bao gồm cả lặp lại memory copying phase.
		Pre-copy bao gồm cả chuyển mem trong khi post-copy thì không 
	2. Down time: Thời gian mà stopped. 
	3. Resume Time: Với pre-copy chỉ cần tái lên lịch target VM và phá source code. post-copy 
	4. Pages Transferred: Pre-copy vận chuyển trogn preparation time trong khi post-copy vận chuyển trong resume time 
	5. Total Migration time: Tổng thời gian start tới finish
	
	

	
/etc/hosts
	os-controllers
	controller
	docker-registry
	compute
	ceph 
	
https://docker-ghichep.readthedocs.io/en/latest/docker-compose/

	
Controller 
	
		- docker-ce (Docker Community Edition ) || docker EE 
		- net-tools
		- haproxy 
		- apache2
		- memcache
		- chrony	
		- masakari-api
		- masakari-engine
	*Database: MySQL 		*Message Broker: RabbitMQ
		- mysqld				- rabbitmq
	*Identity: Keystone		*Networking Neutron server: EVS plug-in 
		- keystone
	*Block storage: Cinder	*Compute: Nova
								- nova-conductor
								- nova-api
	*Image storage: Glance 	*Dashboard: Horizon
		- glance-api
	*Orchestration: Heat 
		- heat-engine 
		- heat-api-cfn
		- heat-api
	
	docker build -t imagename -f Dockerfile . 
	
	

	
	RUN apt-get update \
			&& apt-get install -y git python-pip python-pymysql python-memcache libssl-dev libffi-dev libxml2-dev \
			libxslt1-dev sudo apache2 libapache2-mod-wsgi \
			&& apt-get clean
	
	https://docs.oracle.com/cd/E36784_01/html/E54155/keystoneinst.html#scrolltoc

	
	
	=====================
		docker neutron-server 

docker load --input gitlab_ce_latest.tar.gz 


=========================
	
	
	
Compute 
	Nova hypervisor 
	Solariszone
	NTP: Network Time Protocol
	EVS controller
	Layer 3 agent
	DHCP agent 
	- ntp 
	- ovs-vswitchd
	- qemu-system-x86
	- neutron-dhcp-ag
	- neutron-openvsw
	- corosync
	- nova-compute 
	- kworker
	- watchdog
	- 


==================
docker -- neutron-metadata-agent
docker -- neutron-dhcp-agent
docker --neutron-ovs-agent



==================	
	
	
FROM ubuntu:16.04
MAINTAINER: lamtv10
ENV SERVICE="

	
	

	


	
	



 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  275  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  277  apt-cache policy docker-ce
  279  apt-cache policy docker-ce
  281  curl -fsSL https://get.docker.com/ | sh
  282  sudo usermod -aG docker lamto
  283  sudo usermod -aG docker root
  284  docker pull ubuntu:16.04
  286  docker pull ubuntu:16.04
  289  docker pull ubuntu:16.04
  290  docker pull docker pull ubuntu:14.04
  291  docker pull ubuntu:14.04
  292  docker pull debian
  297  docker pull ubuntu:16.04




 1273  apt update
 1274  curl -fsSL  https://get.docker.com -o get-docker.sh
 1275  sudo sh get-docker.sh
 1276  export https_proxy=https://172.16.30.81:3128
 1277  export http_proxy=http://172.16.30.81:3128
 1278  sudo sh get-docker.sh
 1279  sh get-docker.sh



 docker zip 


`


 ============================== INSTALL KUBENETES ================================================================================
 <html>
 <head>
  <title>Index of /yum/repos/kubernetes-el7-x86_64/Packages/</title>
 </head>
 <body>
  <h1>Index of /yum/repos/kubernetes-el7-x86_64/Packages/</h1>
  <table>
</table>
<i></i>
</body></html>

====================================================================================================================================

{
        "insecure-registries" : ["docker-registry:4000"],
        "graph":"/home/root/var/lib/docker",
 "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}




kubeadm init --image-repository docker-registry:4000/k8s.gcr.io  --pod-network-cidr 10.244.0.0/16 

kubeadm reset 

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
\


kubectl apply -f flannel.yaml
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:



kubeadm join 172.16.29.194:6443 --token 2pym04.wm72ewoc1x9ni4w7   --discovery-token-ca-cert-hash sha256:4ab6798d9adddd5b7e0eaaaa4eb28171c6e844a5c2e35d1d89d57f831dfa77fb 
kubectl get pods --all-namespaces

kubectl get nodes


kubeadm join 172.16.31.247:6443 --token 16wfzc.syat9xuyr9wpiw89 \
    --discovery-token-ca-cert-hash sha256:35d286e8459c7972697e86b30157052bedebe222aae96c0063647f13a507cebb 

    kubeadm join 172.16.29.194:6443 --token cdh4he.19hj4lg577h1ke9f   --discovery-token-ca-cert-hash sha256:78bfe69264074dc6333831c88c006103292fe926b7a91f6c9808400516700e87



    # Kiem tra loi khong vao duoc mang:
    https://support.rackspace.com/how-to/changing-dns-settings-on-linux/
     vim /etc/resolv.conf 
     nameserver 8.8.8.8
     ping google.com.vn 
     ping 8.8.8.8
     ping 8.4.4.4
     ping 172.217.24.35





DOCKER_VOLUME:
default one way copy from host to container and sync from container to host during container running, delete everything default in container 