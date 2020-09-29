https://kubernetes.io/
https://blog.vietnamlab.vn/tag/kubernetes/
https://blog.vietnamlab.vn/2018/08/08/nhap-mon-kubernetes/
https://medium.com/google-cloud/kubernetes-101-pods-nodes-containers-and-clusters-c1509e409e16

Tìm hiểu kiến truc kubernet ==> docc tai lieu: Kubernetes là một open-source đe tu dong triển khai, scaling, management containerized applications.
	Google Container Engine(GKE, sau này là Google Kubernetes Engine) 
	Azure Container Service (AKS)
	Amazon Elastic Container Service for Kubernetes（Amazon EKS）
Kiến trúc chung: https://thenewstack.io/kubernetes-an-overview/

Kubernet = Docker-ce + Docker compose + Docker swarm 





So sánh với kiến trúc openstack: cluster vs compute 
		Cluster gồm 1 node master và nhiều node workers, node là một máy vật lý hoặc máy ảo mỗi node gồm 1 hoặc nhiều pod 
		pod: đơn vị quản lý container đảm nhiệm như một ứng dụng, mỗi pod có thể có 1 hoặc nhiều container, Kubernetes không chạy container trực tiếp mà thay vào đó nó wrap một hoặc nhiều container lại thành level cao hơn gọi là một pod. Mọi container trên cùng một pod sẽ chia sẻ chung tài nguyên phần cứng và local network. (hay nói cách khác chung volume, chung NIC )

		deployment: dùng để quản lý việc tạo pod và phân bổ các pod vào các node quy định, khi một deployment được thêm vào cluster sẽ tự động chạy request tạo các pods và quản lý chúng, nếu một pod die thì deployment sẽ tự động tạo lại pod đó.

		replica set: dùng để tạo ra một hoặc nhiều pod khác nhau ==> Dễ dàng tăng số lượng pod kiểu như việc snapshot trong openstack 
		Ingress: Nếu muốn giao tiếp với service chạy bên trong pod thì cần mở một channel cho việc giao tiếp.



Cài dat trien khai kubernet ==> 1 server, nhieu server, online, offline, 1 may nhieu may, docker network, physical network
	Tool kiến trúc Kubernetes
		Kubeadm https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
		Rancher
	Cấu hình Kubernet Master 
	Cấu hình Kubernet Node 


Sử dụng các tính năng chính của kubernet:
	kubectl, yaml manifest, 
	$  kubectl get nodes
	$ kubectl get nodes -o wide
	$ kubectl get pods
	$ kubectl get pods -o wide
	$ kubectl get svc
	$ kubectl exec -it [pod_name] -c nginx /bin/bash




	`Việc quản lý hàng loạt docket host
		Thêm nữa, khi thực thi các container trên K8s, Bằng cách thực hiện replicas (tạo ra nhiều container giống nhau) làm cho hệ thống có sức chịu lỗi cao và tự động thực hiện load balancing.
	Container Scheduling
	Rolling update
	Scaling/Auto Scaling 
		Image: scaling/auto scaling

		Khi thực hiện phân bổ container vào các Node (docker host), dựa trên các loại docker host kiểu như "Disk SSD" hay "số lượng clock của CPU cao" v.v Hoặc dựa trên loại Workload kiểu như "Disk I/O quá nhiều", "Băng thông đến một container chỉ định quá nhiều" v.v, K8s sẽ ý thực được việc affinity hay anti-affinity và thực hiện Scheduling một cách hợp lý cho chúng ta.

	Monitor vòng đời và tình trạng sống chết của container.
	Self-hearing trong trường hợp có lỗi xãy ra. (Có khả năng phát hiện và tự correct lỗi)
	Service discovery
	Load balancing
	Quản lý data
	Quản lý work node
	Quản lý log
	Infrastructure as Code
	Sự liên kết và mở rộng với các hệ thống khác
	
	Create Pod
	Create ReplicaSet
	Auto Healing trường hợp Node hay Pod gặp sự cố,
	Create Deployment  deployment_sample.yml
	Rollback Update

	JOB 
	Cronjob = job + scheduler
	kết hợp với ansible để cấu trúc 




`



Quản lý container image và triển khai ứng dụng gửi nhận test TPS với Kubernet 
Monitoring Kubernetes Cluster với Prometheus-Grafana Stack 
 Zero Downtime with Rolling Updates And Blue/Green Testing
Health Probes
Application process management with postStart and preStop hook
Container Design Pattern cho hệ thống phân tán: Sidecar pattern 
Sử dụng Ansible xây dựng môi trường K8s ở local bằng RKE



Liên kết kubernet với 
	- Ansible: Deploy container tới Kubernet 
	- Fluentd: Gửi log của container trong Kubernetes
	- Openstack : Cấu trúc k8s liên kết với cloud 
	- Prometheus: Monitor Kuberetes 
	- Spark: Tahy cho YARN 
	-


Tích hợp kubernet với dpdk, sriov so sánh hiệu năng ==> normal vs dpdk vs sriov, tren cung 1 node vs tren  nhieu node 
Test hieu nang kubernet vs openstack VM

Ý tưởng đằng sau CNI initiative là tạo một framework để cấu hình config network configuration và tài nguyên khi container được tạo hoặc khi destroyed. CNI spec cung cấp giao diện cho config networking 
Plugins đại diện cho cung cấp và quản lý IP address cho interface và thường cung cấp function liên quan đến IP management, IP per container và multi host connectivity. Container runtime gọi networking plugin để phân bổ IP address va cấu hình networking khi container start và gọi lần nữa khi xóa 




Plugin sau đó thêm interface vào container network namespace như một side của veth pair. Nó sau đó tạo thay đổi trên host machine bao gồm viết phần còn lại của veth vào network bridge. Sau đó nó phân bổ IP và cài đặt route bởi gọi một IPAM plugin.

Terminology: 




1. uptime 
2. dmesg | tail 
3. vmstat 1 (overall stats by time)
4. mpstat -P ALL 1 (CPU balance)
5. pidstat 1 (process usage)
6. iostat -xz 1 (disk I/O)
7. free -m (memory usage)
8. sar -n DEV 1 (network I/O)
9. sar -n TCP, ETCP 1 (TCP stats)
10. top 



================= Container fof NFV
https://readthedocs.org/projects/opnfv-container4nfv/downloads/pdf/latest/

Với sự giúp đỡ của Multus CNI nhiều interface có thể thêm vào cùng lúc khi triển khai pod. :
	- Nó là contact giữa container runtime và các plugins và nó không làm phần việc net config mà nó gọi vào flannel/calico để làm net config. 
	- Multus sử dụng lại khái niệm invoking trong flannel, nhóm nhiều plugin thành delegates và gọi lần nhau theo thứ tự tuần tự dựa theo json cni config. Số plugin được hỗ trợ là phụ thuộc vào số lượng delegates trong conf file. 



