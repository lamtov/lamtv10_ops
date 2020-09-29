Cisco Autodeployment
UCS: 
- Cisco Virtual Infrastructure Manager (VIM): Một bộ hệ thống điều phối Openstack giúp triển khai và quản lý Openstack cloud từ cài đặt bare metal tới Openstack service, tham gia quản lý phần cứng, phần mềm, security and monitoring. 

- Cisco Unified Management: Deploys, provisions, and manages Cisco VIM on Cisco UCS servers.
- Cisco UCS Manager: Sử dụng để thực thi một số thao tác quản lý khi UCS B200 blade được cài đặt.
- Cisco Integrated Management Controller: 

****************** 

Cisco Virtualized Infrastructure Manager Administrator Guide, Release 2.4.3

- Preparation: Chuẩn bị Cisco NFVI pod hardware và cấu hình application supporting bao gồm: IMC (Cisco Integrated Management), Cisco UCS Manager.

- Installation: Cài đặt Cisco NFVI component như là Cisco VIM, Cisco Unified Management, Cisco Virtual Topology System (VTS) 

+ Preparing for Cisco NFVI Installation page 81: sử dụng CIMC 
+ Install Cisco VIM page 139 
		- Download installer repository, installs Docker và dependencies, start installer web service.
		- Cisco VIM installer launched:
			+	Validates testbed configuration file (setup_data.yaml)
			+ Create new vNICs trên Controller, Compute
			+ Cisco VIM installer thực hiện một số step thông qua tất cả Cisco NFVI nodes.
			+ Next, Ceph related packages required for managing the cluster and creating OSD and monitor nodes are
installed on the control and storage nodes.. By default, the minimum three Ceph monitor nodes are installed
at the host level on the control nodes.
			+ 

+ Verifying Cisco NFVI Installation page 347




PXE (Preboot Execution Environment):
	+ Là một phần của WfM (Wired for Management) định nghĩa bỏi Intel và Microsoft. PXE cho phép system's BIOS và NIC bootstrap một computer từ network tại vị trí của một disk. Bootstrapping được xử lý bởi system có thể load OS vào một local memory mà nó có thể thực thi bởi processor. KHả năng cho phép một system boot qua network giúp đơn giản hóa việc triển khai server và quản lý server cho admin 
	+ DHCP: Sử dụng PXE, BIOS sử dụng DHCP để nhận một IP address cho network interface và để xác định vị trí server stores network bootstrap program (NBT)
	+ NBT: Network Bootstrap Program: tương đương GRUB (GRand Unified Bootloader) hoặc LILO (Linux Loader) thường được sửu dụng trong local booting. Như chương trình boot trong môi trường phần cứng, nBT đại diện cho load nhân OS tới memory do đó OS có thể bootstraped qua network.
	+ TFTP: Trivial File Transfer Protocol: Sử dụng cho tự động chuyển config hoặc boot file giữa machine trong một local environment. 
	+ IPMI: Inteligent Platform Management Interface: Là một interface chuẩn trong hệ thống máy tính sử dụng bởi admin cho quản lý hệ thống máy tính .
	+ Bare Metal Deployment:
		Khi một boot instance request tới:
		- Các gói liên quan sẽ được config trên Bare Metal node nơi ironic-conductor chạy như tftp-server,ipmi, syslinux 
		- Nova phải config để sử dụng bare metal service endpoint và compute driver nên được cấu hình để sử dụng ironic driver trên Nova compute node.
		- Flavor được tạo cho phần cứng khả dụng. 
		- Image tạo bởi Glance. List image type cần thiết cho successful bare metal deployment:
			+ bm-deploy-kernel
			+ bm-deploy-ramdisk
			+ user-image
			+ user-image-vmlinuz
			+ user-image-initrd
		- Hardware sẽ được enrolled thông qua Ironic Restfull API service
		 
















