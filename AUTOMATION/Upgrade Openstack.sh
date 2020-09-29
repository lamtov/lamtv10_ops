=================================================================================================================
Giải pháp chung:

Upgrade Openstack
- Mục tiêu:
	+ Hoàn toàn trong suốt đối với cloud user
	+ Tối thiểu instance downtime hoặc instance connectivity loss
	+ Có khả năng rollback về phiên bản trước upgrade nếu có lỗi
	+ Có khả năng upgrade từ v2 lên v4 mà ko qua v3 
- Hướng tiếp cận
BigBang:
	+ Build upgrade cloud bên cạnh new cloud 
	+ Lấy cấu hình của nó
	+ Chuyển old cloud về dạng read-only
	+ Copy state của old cloud vào new cloud 
	+ Chuyển sang sử dụng new cloud
	==> Gây ra quá nhiều downtime

RollingUpgrade:
	+ Upgrade từng component một trong hệ thống, piece by piece 
	==> Có 2 loại nhỏ: in-place upgrade of each component and replacement/side-by-site upgrade of each component 
	+ In-place Upgrades:
	+ Side-by-site Upgrades:
	 - Configure new worker 
	 - Turn off old worker 
	 --- Cho phép message queue hoặc load balancer hide this downtime 
	 - Snapshot/backup old worker cho việc rollback
	 - Copy/move mọi trạng thái tới new worker 
	 - Start up new worker 
	 - Lặp lại việc đó cho tất cả worker khác theo một thứ tự cho phép.
	 ====> lợi ích:
	 - Có khả năng dễ dàng để rollback
	 - Có khả năng giảm thiểu downtime của một thành phần 
	 - Làm việc tốt khi deploying nova trong VM 
	 - Dễ test khi hệ thống đặt ở trong trạng thái biết trước.

Lược đồ tương thích ngược:
	Để cho phép rolling upgrade của nova component chúng ta cần đảm bảo giao tiếp giữa tất cả thành phần của Openstack làm việc với các version khác nhau
	Một số thứ cần cân nhắc:
		- database schema
		- message queue message
		- notification message 
		- Khả năng tương thích của Openstack API  
	Ví dụ: Để tránh việc new version code không hoạt động với kiến trúc database cũ thì nên upgrade database đầu tiên. Tuy nhiên thì nên upgrade database cuối cùng vì khó rollback.
Live migration:
	- Khi upgrade một hypervisor, lý tưởng nhất là instance nên được migrate sang một host khác để mà host cũ có thể được upgrade với zero downtime cho instance đã chạy trên host đó.
	- Nếu không có live-migration support instance có thể lost hoặc suspended trong quá trình upgrade hypervisor.

Ví dụ: Một giải pháp upgrade nova có khả thi:(giả sử database luôn ở trong trạng thái backwards compatible)
	- Update tới Database Scheme cuối cùng
	- Upgrade MessageQueue hoặc Database nếu cần 
	- Upgrade: Scheduler, Glance, Keystone
	- Upgrade: Volume, Network 
	- Upgrade: Compute 
	- Upgrade: Nova API 

	nova-compute: 
	- Tạo new compute worker 
	- Cấu hình new compute worker để thay thế cho old worker 
	- Stop hoàn toàn old compute service 
	- Stop fetching from queue 
	- Cho phép tất cả operation được complete 
	- Bật new compute service 
	- Shutdown old machine, now new service is running .

	nova-scheduler + nova-api:
	- Bật một host mới 
	- Cấu hình new api service, start new api service 
	- Reconfigure load balancer hoặc move ip alias tới new machine 
	- Đợi cho requests được phục vụ bởi new API và những thay đổi trên được áp dụng.
	- Stop tất cả old service 
	- Shutdown old host. 
===================================================================================================================

Kinh nghiệm sử dụng Kolla Ansible để upgrade Openstack:
Upgrade từ Ocata to Pike to Queens
3 storage nodes, 7 compute nodes, 3 controllers HA, người dùng có thể chịu đc việc system downtime 

Upgrade smaller system thì ok nhưng gặp nhiều vấn đề khi upgrade big system
workflow:
	- Sinh 3 config files: password.yml, globals.yml, multinode.ha 
	- pull tất cả container sử dụng kolla-ansible pull 
	- Thực thi upgrade sử dụng kolla-ansible upgrade 
	- Thực hiện upgrade từn service một để đảm bảo mỗi service có thể hoạt động chính xác sau khi upgrade.
	opt/kolla-ansible/tools/kolla-ansible \
    -i /etc/kolla/multinode.ha --tags "haproxy" upgrade

    - 2 service mà họ lo lắng nhất là mariadb và ceph 

 







	






















