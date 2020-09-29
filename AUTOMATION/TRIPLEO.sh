video: https://www.youtube.com/watch?v=zfoiFvzuPVc
pdf: https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/14/pdf/director_installation_and_usage/Red_Hat_OpenStack_Platform-14-Director_Installation_and_Usage-en-US.pdf

slide: 

Tripleo gồm undercloud và overcloud (undercloud là một operator facing deployment cloud gồm các thành phần cần thiết trong openstack để triển khai và quản lý overcloud, overcloud ngược lại là một workload cloud )
	 - Planning:
			Network Topology
			Service parameters
			Resource capacity
	- Deployment:
			Pre-flight checks/validations
			Deployment orchestration
			Service configuration
	- Operations:
			Major version upgrades
			Applying minor updates
			Scaling up and down 

Planning: Manage hardware inventory, capacity planning
	Node Discovery and Introspection
	Register Bare Metal Nodes 
	Profile Matching (node assignment) --> Controller Nodes, Compute Nodes, Network Nodes 
			Composable roles, customize enabled services and placement.
			Customizable network isolation, declarative nic configuration
			---- Overcloud:
				Controller + Compute + BlockStorage + CephStorage +SwiftStorage

			--- Underclod --deployment -- Overcloud 
				Heat + Nova + Neutron + Ironic (Openstack Bare Metal)
				Undercloud Neutron crate network and is used for IPAM, network configuration then applied via Heat to each node using os-net-config tool
		Các bước thực hiện
			- Node discovery, Introspection and grouping (ironic)
			- Customizable "roles" (group of nodes)
			- Pluggable "composable services" (Heat templates) Sử dụng heat làm orchestrator chính và bạn có heat environment file syntax cho phép bạn version mọi bit của infrasturcture code do đó nó chỉ như một overview 
			- Per-service network isolation (Neutron/os-net-config)
			- HA support (Pacemaker)
			- Predictable placement and preassigned IPs (Ironic/Nova)
			- Flexible service configuration (Heat parameters)
			- Version control your infrastructure "as code" (yaml)



Deployment:
	Undercloud: 
	tripleo-ui +  cli, mistral + zaquar (work flow tool sử dụng nếu bận cần chỉ ra một series step ví dụ như cho một tác vụ upgrates) 
	heat  + Puppet: sử dụng làm công cụ khai báo cho phép xây dựng nhóm các node giống hệt nhau, đó là các vai trò tùy chỉnh: group of compute nodes, group of controller nodes, multiple type of compute nodes như là loại nào có DPDK hay loại hardware khác nhau...
	swift: Cung cấp object storeage 
	neutron cho IP address management trong trường hợp khi chúng ta không có IP dự trước thì có thể lấy từ pool của subnet định nghĩa trong neutron 
	nova: cung cấp flavor + ironic-api + ironic-conductor, driver để quản lý bare metal nodes.
	glance: Lưu image sẽ được ghi vào bare metal nodes.

	Overcloud: BMC Nodes: Ironic Python Agent + Puppet Openstack Package 
	Bare-metal Server: Là một máy chủ vật lý chỉ bao gồm phần cứng 




	Các bước thực hiện: 
		- Pre-flight validations (Ansible based)
		- Disk image based deployment (Glance)
		- Baremetal provisioning (Ironic)
		- Baremetal service configuration (pupet)
		- Heat templates define each service and configuration
		- Mistral workflow API provides pluggable interface for UX 
		- Increasingly using Ansible "under the hood"

Operations:
	- Automated configuration of monitoring client
	- Support for centerized logging
	- Major version upgrates, orchestrated by Heat + Ansible 
	- Minor version updates - rolling no downtime
	- Automated scaleup to add capacity 
	- Orchestrated scale down and node removal
===> Using ansible: 
head --> ansible drives puppet and configure the bare metal ,

Deployment with container: 
	CONTAINERIZED OPENSTACK 

- Hybrid baremetal/container 
	assists with migration of vendor plugins ví dụ neutron 
- include upgrate support (from baremetal)
	Hầu hết state ví dụ DB đặt trên host filesystem
- Tái sử dụng cumgf "composable services " architecture
	Some new interfaces specific to containers address 
- HA support (Pacemaker managed container bundles)
- Host networking used to retain network isolation 
- Backwards compatibility ( Heat parameters and puppet )

==> Ví dụ cho upgratding:
	Shutdown and disable tất cả service trên control plane mà  workload trên các VM không bị ảnh hưởng, shutdown Openstack control plan services và sau đó chạy qua một  ordinary deploy sequence bring up container step by step. 



==> host preparation(host_prep_tasks) write json for paunch --> puppet baremetal configuration( step_config) --> container config generation (docker_puppet.py) --> container deployment --> container bootstrap tasks.




==========+++++++++++++++++++++++++++++++++==========================
Di openstack summit

Paunch 101
Container orchestration 
Paunch là một utility để launch and manage containers sử dụng configuration data tìm thấy trong TripleO service template. (It's an orchestrator of sorts)
It's a wrapper for the docker-cli 
Supports standalone use outsite of heat/TripleO (derived from heat docker-cmd hook initially)




http://git.openstack.org/cgit/openstack/paunch/
	- Single host only, operations are performed via the docker client on the current on the current configured docker service.
	- Zero external state, only labels on running containers are used when determining which containers an operation will perform on.
	- Single threaded and blocking, containers which are not configured to detach will half futher configuration until they exit (config generation and bootstrap containers)
	- Co-exists with other container configuration tools - only containers tagged as being managed by punch are modified 
	- Idempotent - leave containers running when their config has not changed, but replace containers which have modified config (minimise minor update downtime)




==
TripleO sử dụng Kolla containers để build OCI-compliant container images - some additional packages được bổ xung vào default kolla build để hỗ trợ TripleO
Create a yaml file to set image, location, namespace:
$ openstack overcloud container image prepare 

Consume image file generate by prepare:
$openstack overcloud container image upload 

---> $openstack overcloud deploy --templates $templates -e $templates/environments/docker.yaml 





