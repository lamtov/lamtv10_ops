Openstack Troubleshooting

- Networking:
https://docs.platform9.com/support/troubleshooting-common-openstack-networking-problems/


Kiểm tra Log instance xem đã metadata chưa
Kiểm tra DHCP 
	ip netns
Kiểm tra Openvswich.
	ifconfig br-mpbn ..
https://docs.openstack.org/openstack-ansible/latest/admin/troubleshooting.html
https://docs.openstack.org/operations-guide/ops-network-troubleshooting.html

===> openflow dpdk
- Image
Kiểm tra glance

- Nova và ceph

- Nova và libvirtd
https://docs.openstack.org/nova/queens/admin/support-compute.html
- Rabbitmq

- mysql
lỗi cluster

===> https troubleshooting
	-benen ngoài
	- bên trong docker


-- haproxy
-- keepalived
https://www.linuxtechi.com/openstack-interview-questions-answers/


- HTTPS ERROR

===============================================================================================

Troubleshooting Compute:

Lỗi trong lúc tạo Instance:

Scheduling ERROR: "Instance's name already exist!"
	- Lỗi do instance name đã được chọn hoặc khi tạo nhiều instance một lúc với horizon mà một trong số các instance name đã được chọn.

Scheduling ERROR: No Valid Host Found: Exhausted all hosts available for retrying build failures for instance
	- Kiểm tra lại tài nguyên trên các HOST và phần server_type trên Flavor có khớp nhau không.
	- Kiểm tra lại Flavor đã có metadata HUGEPAGE chưa.
	- Nếu tạo trên Horizon và không có phần chỉ định Host thì kiểm tra xem đã enable hết các Host cần thiết chưa.

Networking ERROR: Instance không nhận IP 
	- Kiểm tra lại DHCP Agent có ping được ko dùng ip netns exec ...

Spawning ERROR: Nếu thời gian Spawning quá lâu (2-3 phút) thì kiểm tra xem log của openstack-nova-compute 
	- libvirtError: internal error: qemu unexpectedly closed the monitor
			Với lỗi này thì kiểm tra tắt tất cả các process virt-manager trước khi khởi tạo instance 
			Nếu tắt virt-manager xong vẫn còn lỗi thì tiến hành restart libvirtd và openstack-nova-compute rồi tạo lại instnace.
	- Network ERROR: Failse to bind port
			Kiểm tra log của ovs-agent tại "/u01/docker/docker_log/neutron/neutron-openvswitch-agent.log" 
			Nguyên nhân chính là do ovs-agent không hoạt động chính xác, có thể do mất kết nối tới neutron-server hoặc lỗi ở openvswitch-dpdk 
			+ Giải pháp kiểm tra:
					Kiểm tra tính năng port binding của toàn hệ thống bằng cách test attach, detach port trên các VM đã tạo
					Kiểm tra tính năng port binding với network khác
					Kiểm tra tính năng port binding trên host khác, nếu không vấn đề gì thì có thể restart ovs-agent trên host đang lỗi.


	- Volume ERROR: Kiểm tra lại cấu hình giữa Nova và CEPH.
			Kiểm tra lại log cinder_volume có thể lỗi không đồng bộ thời gian giữa cinder, nova, ceph.



Metadata ERROR: Không thể SSH vào instance.
	- Kiểm tra log instance tại horizon hoặc "/var/lib/nova/instance/instance_id/console.log"
	- Kiểm tra DHCP Agent có thể ping được đến 169.254.169.254 
	- Kiểm tra Metadata Agent ngay cạnh DHCP Agent đang được sử dụng.
	- Kiểm tra lại nova-metadata trên controller bằng lệnh 
			[root@SPGM01DRCOMP1 ~]# curl https://os.controller:8775
			1.0
			2007-01-19
			2007-03-01
			2007-08-29
			2007-10-10
			2007-12-15
			2008-02-01
			2008-09-01
			2009-04-04

Lỗi không migrate được
	- Kiểm tra các Host đã enable chưa trước khi migrate 
Lỗi ko live-migrate được
	- Kiểm tra trạng thái hoạt động của libvirtd và openstack-nova-compute
	- Kiểm tra libvirtd port 16509
			netstat -lntp | grep libvirtd
	- Nếu không thấy libvirtd bind port 16509 thì vào sửa file cáu hình /etc/sysconfig/libvirtd bật cấu hình Listen TCP/IP LIBVIRTD_ARGS="--listen"
	- Kiểm tra tài nguyên trên máy đích xem có đáp ứng được yêu cầu lauch instance. 

Lỗi không resize được 
	- Kiểm tra cấu hình metadata của Flavor mới cho instance được resize xem có trùng khớp với Flavor cũ
	- Kiểm tra xem tài nguyên của hệ thống còn đủ đáp ứng Flavor mới không
	- Chú ý mặc dù là Resize nhưng instance sẽ phải bị chuyển sang Compute Node khác.



==============================================================================================================
Troubleshooting Networking:

Lỗi không tạo được network:
		- Hệ thống hiện tại chỉ cho tạo FLAT NET 
		- Kiểm tra tên map physic_network đã cấu hình đúng ở trong /usr/share/docker/neutron/neutron/plugins/ml2/openvswitch_agent.ini:[ovs]/bridge_mappings.

Lỗi không ping được tới VM hoặc log in vào VM 
	Luồng đi của gói tin: Instance --> br-int --> br-flat --> bond --> physic_network

		- Kiểm tra VM đã nhận IP chưa
				Từ màn hình console của VM gõ ip a để check các port và MAC_ADDRESS của từng port.
				Từ MAC_ADDRESS xác định thông tin port trên horizon, từ đó xác định network và cấu hình ip cũng như cấu hình file network-script cho đúng.
		- Kiểm tra DHCP 
				Từ giao diện Horizon vào tab Network kiểm tra ip và vị trí của DHCP port trong network đó.
				Truy cập vào giao diện console của Compute chứa DHCP port.
				Gõ ip netns ra qdhcp-(networ_id)
				Kiểm tra ip của qdhcp: 
					+ ip netns exec -it qdhcp-(network_id) ip a
							Nếu thấy inet 169.254.169.254 nghĩa là đúng như cấu hình dhcp-agent đang chạy thêm bên trong nó một metadata-proxy service.
					+ ip netns exec -it qdhcp-(network_id) ping ...
		- Kiểm tra Security Group
				Với Security Group mới tạo thì cần bổ xung thêm config cho phép inbound traffic
		- Vấn đề với Openflow 
				Kiểm tra xem Network đang sử dụng bridge nào trong openvswich rồi gõ lệnh
				ovs-ofctl dump-flows br-Name
				Nếu thấy thiếu các Flow có actions=strip_vlan thì tự bổ xung hoặc restart ovs-dpdk qua lệnh
				/etc/init.d/ovs-dpdk restart

		- Vấn đề với Layer 2 connectivity
				Kiểm tra ping VM trên cùng 1 host 
				Sau đó kiểm tra ping VM trên 2 host khác nhau 
				Có thể có vấn đề về phần cứng và đường truyền mạng.

		- Iptable rule của VM sẽ mất sau khi restart iptable nên cần restart ovs-agent bằng tay ngay sau đó để tạo lại Iptable rule này. 


====================================================================================================================
Rabbitmq 
Khi các service trong Openstack đồng loạt báo Timeout "AMQP Timeout"
+	Kiểm tra Rabbitmq có hoạt động bình thường qua lệnh
	 rabbitmqctl cluster_status
+ Kiểm tra tính năng đồng bộ thời gian trên 3 con controller và  28 con compute tránh lỗi Timeout do mất đồng bộ thời gian.

Khi Rabbitmq liên tục reject và close AMQP connection nghiã là rabbitmq đã đạt ngưỡng số lượng file descriptors và cần tăng limit lên bằng cách cấu hình trong file /usr/lib/systemd/system/rabbitmq-server.service phần [Service]/LimitNOFILE .


====================================================================================================================
Perconaxtra DB cluster
- Lỗi phân cụm trong Perconaxtra DB do gián đoạn hoặc mất kết nối.
		Kiểm tra bằng lệnh 
			Percona XtraDB Cluster Node is synced.

- Lỗi không khởi động mysql lên sau khi stop
		+ Nguyên nhân 1: Một node mysql trong cluster sau khi stop sẽ chỉ định một node khác giữ thông tin để lúc bật lên join lại. Nếu lúc bật lên không thấy node kia trong cluster sẽ không thể join và báo lỗi
															==> Cần start, stop mysql theo đúng thứ tự, node nào stop cuối cùng sẽ phải start đầu tiên
		+ Khi muốn start một node bất kỳ trong cluster và không quan tâm tới 2 node còn lại có thể sửa file /var/lib/mysql/grastate.dat
		sửa seqno=-1 rồi start lên.
		+ Trong trường hợp 3 node cùng stop một lúc cần khởi tạo lại cluster 







