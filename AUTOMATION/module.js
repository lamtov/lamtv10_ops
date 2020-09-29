module.js






module.js


-----
Chuẩn bị sẵn các default template, mối quan hệ giữa các bảng.
+ Một file_config thuộc về nhiều service là đặt ở trong đây
+ Role có những service nào bên trong
Input: role_name
Output: Danh sách các service cần được cài trong role này
Using:

+ Thứ tự deployment các service
Input: Role_name + Disable Service + Enable Service + HubName
Output: Validate Function + Thứ tự deployment các service

+ Task nào liên quan đến service setup 
Input: Service Name + Role + HubName
Output: 
Validate Function: ví dụ cài node controller thứ 2 thì cũng cần validate node 1 đã lên chưa + iptable + ...
Danh sách các playbook dùng để deployment service 
Các playbook này sử dụng python Ansible playbook

+ Task có những change nào 
Input: Task_name
Output: Mỗi change là tên một task trong file main của ansible role







----

- Triển khai
module1 + action:
+ Make Ansible Inventory and Discover Node
Input: Ip Management Node + SSh user + SSh Password
Using: Ansible Module Setup 
Ví dụ: show cái file kia ra
Output: Thông tin chi tiết về phần cứng và environment của Node đó.



+ Set role and Select service for each Node
Input: Map(node, role, enable + disable service )
Processing: User drap, drop hoặc sử dụng bộ recommend system 
Output: Insert vào DB tất cả những gì liên quan + Tạo các file Inventory + Tạo các ansible Playbook cho việc cài đặt

+ Nhập vào các cấu hình cụ thể:
VIP, Controller Master Node
Password Mysql,Haproxy, RabbitMQ, Openstack user
NTP server
Neutron-network-type: flat, vlan, sriov
Neutron-bridge-mapping
Neutron-network-vlan-ranges
ceph-storage-cluster config
log_folder, docker share, docker lib
Service port
use_vcpu_pin_set, nova_backend_ceph,
glance_backend_ceph,cinder_backend_ceph
resume_guests_state_on_host_boot,
osapi_compute_unique_server_name_scope
SSL config

==> Tất cả các thông tin được nhập bên trên sẽ được ghi vào trong /etc/ansible/inventory và /etc/ansible/group_vars/ sau đó ansible sẽ sử dụng các config này để chạy như bình thường

Input: List(Key, value ) cần thiết 
Processing:
 Sử dụng python fabric lib để dùng hàm và validate 

Output:

	** validate các value xem có thể sử dụng ko ví dụ network-mapping, service port có bị trùng, nova_lib có đủ bộ nhớ, VIP có bị trùng 
	** insert ra các file /etc/ansible/group_vars 


+ Các gen recommend 
Input
Output

==> recommend system + default value system
+ Một số module nhỏ bên trong như suggestion gen:
auto select role: 
input: Tên các Node được chọn tham gia vào cụm Openstack + template sử dụng ceph hoặc ko sử dụng ceph, 1 controller hoặc 3, 5 controller + số lượng replicate ceph
Output: Đọc thông tin các node ở trong database và tính toán tối ưu để đưa ra suggestion tốt nhất (3 controller , 3 ceph, còn lại là compute)
							Node nhiều ổ cứng thì cho làm ceph, node nhiều card mạng, nhiều core, nhiều ram thì cho làm compute, node nhỏ nhưng vẫn đáp ứng đc thì cho làm controller 
Thuật toán: Sử dụng Backtrack với gán nhãn là role và tính điểm dựa vào số tài nguyên tối đa sẽ tạo ra được từ việc phân role như vậy(số lượng VM dựa theo chuẩn Flavor của Openstack ,số lượng network, tài nguyên còn trống)

auto select service, auto gen password, gen ip, gen folder, gen config 
	Tính toán dựa vào tài nguyên hệ thống và dựa vào role để recomend service sẽ cài, folder trống để cài, ip nên sử dụng hay config nova quota, config ceph replicate 







- Luồng cài đặt
+ https://stackoverflow.com/questions/27590039/running-ansible-playbook-using-python-api
PlaybookExecutor
# create data structure that represents our play, including tasks, this is basically what our YAML loader does internally.
play_source = dict(
name = "Ansible Play",
hosts = 'localhost',
gather_facts = 'no',
tasks = [
dict(action=dict(module='shell', args='ls'), register='shell_out'),
dict(action=dict(module='debug', args=dict(msg='{{shell_out.stdout}}')))
]
)


+ module 1 làm nhiệm vụ cài đặt từng phần step by step sử dụng python ansible, bổ xung validate và test
Input: Node Install
Output: Danh sách ansible playbook dùng để cài đặt Node đó (đi kèm với từng task chạy là task roleback)
Việc thực hiện roleback dựa vào thông tin database để biết đang chạy task nào playbook nào từ đó chọn task roleback cho phù hợp
Next + pause + undo = gọi tiếp lệnh hay ko

Ansible có một số module hỗ trợ làm việc này:
	TAGS: chỉ chạy trong playbook những cái có tag như vậy ví dụ: cài nova + install và cài nova + Rollback 
	--skip-tags: bỏ qua các task sau 
	--start-at-task: chỉ chạy từ task này (pause và unpause + skip )


+ module 2 tạo database luồng cài đặt dựa vào các template định nghĩa sẵn:
deployment, deployment service, service setup , task, change

Phục vụ cho việc hiển thị luồng cài đặt cho người dùng và lưu trữ trạng thái quá trình cài đặt, rollback 

Input: {host, playbook, task, change, status, log}
Output: Insert to db, update giao diện 


đồng thời module 2 nhận request gửi về từ client do ansible gọi và tạo để update thông tin tới database và cho lên giao diện
==> người dùng sẽ biết được đang làm gì ở đâu (chạy song song sẽ nhanh hơn là chạy độc lập nhưng nếu xảy ra lỗi thì cũng rất phức tạp.)
==> bổ xung vào sau mỗi ansible task một command curl để gửi POST về API và ghi lại thông tin
nội dung POST: {host, playbook, task, change, status, log}
tất nhiên để làm được việc này cần chia nhỏ các task trong ansible về dưới cấp độ change vd restart --> enable --> ..

Phần nhận dùng Flask đón ở /update/info/task

+ module 3 làm nhiệm vụ undo dựa vào các change bên trên để undo
- undo file, undo folder
... chi tiết ra

Input: Task and change to undo
Output: Check thoognt tin trong db, chạy ansible undo,validate, cập nhật db, cập nhật giao diện

- Scaling up, Scaling down,
+ Bổ xung module cho phép add, remove node khỏi database sau đó thêm tính năng gen asible playbook cho riêng node mới đó, thêm cả giao diện cài đặt chỉ một node .

+ Scaling down thì thêm live-migration nữa
Input: Node name, node role .. từ đầu đến cuối như trên 
Output: Insert node info to database sử dụng ansible playbook -i chỉ chạy node đó 


- Replace Controller Node
++++++ Giống scaling up nhưng bổ xung một node controller sau đó thực hiện sửa các cấu hình liên quan đến replicate như haproxy, rabbitmq, perconda, keepalived
 sửa cấu hình tất cả các node có liên quan đến percona hoặc rabbitmq

- Update
+ Module gen from database to file config làm như sau:
+ Tìm trong table openstack_config các row có file_id và active=1
+ select distint block from openstack_config where file_id=file_config_id
+ gộp các openstack_config theo block và lưu thành file theo địa chỉ host/folder_path/filename.cfg
+ Update được thực hiện theo 2 cách:
+ Trên giao diện chọn file cần sửa, liệt kê các config trong file đó, update
Việc update gồm 2 việc
Tạo update id, update change với file_config_file_id là id của của file được update tạo các row openstack_config với update id đó
Sửa activate về 0
cập nhật active thành 1 cho các row mới được tạo.
Sử dụng ansible đẩy các file config và restart các service liên quan đến file config đó dựa vào table service_info_file_config


+ Bằng tay trong các node:
Sau khi sửa bằng tay trên giao diện hỗ trợ tạo commit
Commit sẽ tạo update id, tìm các file thay đổi trên các node (dựa vào việc so sánh time edit trên node và time created file nếu chên nhau nhiều thì là đã bị chỉnh sửa,)
Down file về so sánh và tạo các update tương tự như trên

` bổ xung time created ở file_config, time update , ở file_config và openstack_config`

+ Rollback
- Backup: Đẩy các file đã bị chỉnh sửa vào đúng vị trí, restart các service liên quan đến các file đó 
Thao tác backup được thực hiện tại mỗi lần commit đảm bảo cho người dùng có chỉnh sửa gì thì có thể dễ dàng backup tất nhiên cũng sử dụng việc so sánh time edit và time created file

- Rollback:
B1: Tìm trong bảng update row có created_at mới nhất mà ko có deleted_at 
SELECT * FROM update WHERE deleted_at = None ORDER BY created_at DESC LIMIT 1;

B2: Tìm trong bảng openstack_config những role có update_id = update_id thì bỏ active=1 thay thành active=0, thêm vào deleted_at thành giá trị thời gian hiện tại 
Sau đó với mỗi thay đổi tìm trong openstack_config role có cùng field_id, key, block, ko có deleted và là row mới nhất
Cập nhật lại role đó với active=1 
B3: Cập nhật lại updated_time của file_config sao cho mới nhất trong số các config.

B4: Tìm trong bảng update_change những change id liên quan đến update_id và thực hiện ansible role back change 
- file cũ thành file mới 
- service restart 
- config cũ thành config mới .












- Backup
- Restore
- Rollback


- edit password
input key, value, id password change 
output Update to database, cập nhận vào các config -->fileconfig -->tạo list change ---> restart các service liên quan 


- các module liên quan đến docker:
clean-image, clean-container, remove script, remove docker, get status, get logs...
docker swarm hoặc docker ansible ...


===> INPUT + OUPUT + Lõi có những nhân gì