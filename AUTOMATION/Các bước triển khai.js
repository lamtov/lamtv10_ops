Các bước thực hiện:
Chia làm các phần build registry (under cloud) + build ops (over cloud)	
																								
---- Ngòai ra còn phải tự động hết các buowcs gen sinh


Bổ xung các tính năng còn thiếu:
+ genpassword
+ build registry
+ prechecks, validate
+ check after install
+ reconfig, update
+ reconfig, Upgrade 

+ genconfig 
+ backup
+ commit 
+ rollback
+ reset: clean-container, clean-image, clean-host, remove script, remove docker, remove ansible, delete kolla dir

+ scalling up, scalling down 
			- replace controller
			- add compute 
			- add storage 
			- remove compute 
			- remove storage 

			---> Bổ xung gói cài đặt install.tar.gz 
+ Bổ xung tính năng fix như cái Kolla_fix 

Với những tính năng cần valide cần bổ xung:
	- validate
		+ Check Kernel version
		+ check ansible version
		+ check docker version
		+ check management node tag 
		+ check bond Intf Setting
		+ Check LV Swap Settings 
		+ Check Docker Pool Setting
		+ Check Home dir partition
		+ Check Root Dir partition
		+ Check var partition 
		+ Check lvm partition 
		+ Check RHEL pkgs Install State 

	- test từng bước
	- xử lý từng bước 
	- hậu nghiệm


Bổ xung các tính năng controll container:
+ destroy
+ pull
+ stop 
+ update 
+ SSL hoặc ko


Bổ xung tính năng tương tác với ironic để build Openstack lên trên BM
+ ironic 
+ Baremetal


Bổ xung các tính năng nâng cao:
+ modify password 
+ NFV bench match
+ cluster -recovery
+ mgmtnode -health
+ ORCHESTRATION ---- ELK
+ VMTP
+ Cpluse
+ Auto deployment UI
+ nova_libvirt
+ openvswitch



--- CHỉ rõ ra những cái nào mình sẽ cài trong docker, bên ngoài 


vẽ lại hình chỉ rõ môi trường cài đặt (RedhatEnterpriseLinux)
Trình bày tài liệu thiết kế:
		-- Kiến trúc 
		-- Các chức năng, API, module 
		+++
		-- Thiết kế Database 
		-- Các giao diện
		-- Các API
		-- Hướng dẫn sử dụng (step by step)

`
{
"name":"ceph-node1",
"mac":[
"C4:34:6B:C7:89:98"
],
"cpu":"40",
"memory":"128733",
"disk":"500",
"arch":"x86_64",
"pm_type":"pxe_ipmitool",
"pm_user":"redhat",
"pm_password":"huawei@123",
"pm_addr":"172.25.14.125"
},

network  thì bổ xung // primary: true | gateway

Thêm được phần cấu hình openvswitch nữa thì tốt vì phần cài đặt cũng có liên quan đến phần tạo network sau này VD tên network, sriov....
--> phân bổ luôn phần network
--> node compute nào có thể tạo network thì tạo luôn (ko nhất thiết tất cả node compute phải có đủ)
--> Bổ xung phần network config vào gen password và specify config  để phục vụ việc genconfig


---> storage nữa: 
		control-scale: Number of Controller Node to 3
		compute-scale: Number of compute node to 7
		ceph-storage-scale: Number of Ceph Storage to 4
		ntp-server 
		neutron-network-type 
		neutron-bridge-mappings
		neutron-network-vlan-ranges

==> module gen template config 
module import from template config to database 

ghi rõ từng bước làm từng cái 1 có liên quan đến db ra, tài liệu thiết kế đầy đủ 





#-
# type: interface
# name: nic7
# use_dhcp: false
# addresses:
# -
# ip_netmask: {get_param: ManagementIpSubnet}
# routes:
# -
# default: true
# next_hop: {get_param: ManagementInterfaceDefaultRoute} 


****************************************************************
ansible all -m setup --tree /tmp/facts


--- CHỉ rõ ra những cái nào mình sẽ cài trong docker, bên ngoài 
https://voer.edu.vn/c/thiet-ke-phan-mem/a8d2857f/32bda8b7

vẽ lại hình chỉ rõ môi trường cài đặt (RedhatEnterpriseLinux)
Trình bày tài liệu thiết kế:
-- Kiến trúc : Xác định hệ tổng thể gồm những phần con nào và các quan hệ giữa chúng.
-- Các chức năng, API, module 
Đặc tả trừu tượng các hệ con về các dịch vụ mà nó cung cấp cũng như các ràng buộc giữa chúng.
==> Input, output từ đó giao diện sẽ được làm tách biệt với phần code API cho phép code thuận lợi hơn.
Làm cơ sở cho việc triển khai chương trình 
Làm phương tiện giao tiếp giữa các nhóm thiết kế.

Ở mức cao: Mô hình tổng thể các module, mối quan hệ gọi nhau giữa các module và cách thức các module trao đổi thông tin(giao diện, các dữ liệu dùng chung, thông tin trạng thái)

Ở mức chi tiết từng module: giả mã

+++

-- Các giao diện: Giao diện từng hệ con với các hệ con khác 
-- Thiết kế các thành phần: Các dịch vụ mà hệ con cung cấp được chia thành các thành phần nhỏ
-- Thiết kế Database: Thiết kế chi tiết và đặc tả các cấu trúc dữ liệu (các mô hình về thế giới thực cần được xử lý) được dùng trong việc thực hiện hệ thoogns 
-- Thiết kế các thuật toán: Thuật toán được dùng cho các dịch vụ được thiết kế chi tiết và đặc tả.

==> Đến khi các thành phần hợp thành của mỗi hệ con được ánh xạ trực tiếp vào các thành phần ngôn ngữ lập trình(gói, thủ tục, hàm)

Vấn đề với update ko thể cứ restart service liên tục được
Làm theo kiểu commit 
nghĩa là cứ lên đấy, chỉnh sửa tẹt tèn ten xong gõ commit lại thì sẽ được lưu
Lúc lưu lại thì sẽ lưu theo commit bằng cách kéo tất cả các file đã chỉnh sửa về, so sánh cấu hình trong database, thêm vào table config. ...
---> Cần thêm tính năng rollback config, CHọn list file config trên một node cần rollback restart service liên quan đến file đó ....


-- Hướng dẫn sử dụng (step by step)
==> Thiết kế tốt là phải dễ bảo trì


`

- Undercloud:
	+ Configuring the Access Network for Undercloud
 	+ Environment planning: Cung cấp các function lên kết hoạch cho User chri định Openstack role, compute, controller, một số storage role 
 	+ Baremetal system control: Undercloud sử dụng IPMI (Intelligent Platform Management Interface) của mỗi node đẻ thực hiện quản lý điề khiển power và PXE-based service để lần ra các đặc tính phần cứng và cài đặt Openstack cho mỗi node. Cái này cung cấp một giải pháp để quản lý baremetal system như Openstack node .
0----------------------- MariaDB và RabbitMQ (sử dụng rabbitmq cho director component)




- Mot so chu y khi cai he dieu hanh: VTd Azalia Vcp Optimizations, PCle SR-IOV, Intel VT for Directed I/O (VT-d), Interrupt Remapping, Coherency Support (Isoch)

- Setup parameter 
- Config Time Server





Các bước deoploying - trên 
	- undercloud: undercloud.conf 
	- undercloud_db_password = redhat
undercloud_admin_password = redhat
undercloud_glance_password = redhat
undercloud_heat_password = redhat
undercloud_neutron_password = redhat
undercloud_nova_password = redhat
undercloud_ironic_password = redhat
undercloud_aodh_password = redhat
undercloud_ceilometer_password = redhat
undercloud_ceilometer_snmpd_password = redhat
undercloud_swift_password = redhat
undercloud_rabbit_password = guest
undercloud_rabbit_username = guest
undercloud_heat_stack_domain_admin_password = redhat
undercloud_haproxy_stats_password = redhat





------------------------------------------------------------
https://medium.com/@opensourcevoices/high-performance-networking-with-kubernetes-77c2682d75e3


Mặc định 1 pod chỉ chí 1 network-interface trong khi VNF yêu cầu sự phân tách của data plan từ control plane có nghĩa là cần 2 interface điều mà kubernet ko Support

Xử lý: Multus: cho phép nhiều hơn một network interface trong Kubernet pod. 

Từ đó tạo ra openShift 

Mặc định cũng ko có core pinning và resource locality để maximum throughput và low latency. 
==> opensource trong intel là CPU manager for Kuberntes

==> device plug-ins


==> Sriov device plug-ins
và sriov cni plug-ins
 cả 2 cái này đều sẽ available như tech-preview trong OpenShift v4.0 còn hiện tại thì họ chỉ trình bày SR-IOV network device plug-in với một selector-based deployment feauture 

 
