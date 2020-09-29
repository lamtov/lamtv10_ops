Thông tin git 
git clone ssh://git@172.16.29.193:2222/lamtv10/software_deployment.git 

Hướng dẫn test luồng API 

API được em set CI/CD cho tự động build bằng docker trên Node 172.16.29.193 ở cổng 4321
Ví dụ http://172.16.29.193:4321/api/v1/hosts

B1:  "Clean dữ liệu dùng cho việc test đi test lại"
	POST:/api/v1/clean_data  (clean tất cả dữ liệu )
	vd: 'curl -X POST "http://172.16.29.193:4321/api/v1/clean_data" -H  "accept: application/json" -H  "Content-Type: application/json"'


	POST: /api/v1/clean_data?table=xxxx (chỉ clean 1 bảng duy nhất)
	xxx là tên bảng cần xóa: ["nodes ,deployments ,node_infos ,node_roles ,service_setups ,tasks ,changes ,disk_resources ,interface_resources"]
	vd: 'curl -X POST "http://172.16.29.193:4321/api/v1/clean_data?table=tasks" -H  "accept: application/json" -H  "Content-Type: application/json"'



"Discover Node":

B2: Bổ xung thông tin Host vào cụm OverCloud
- POST: /api/v1/hosts/add_host (Đầu tiên thực hiện thao tác POST thêm Node lên server)
Ví dụ 4 file node1.json, node2.json, node3.json, node4.json là thông tin các Node có sẵn 
{"management_ip":"172.16.29.23", "ssh_user":"root", "ssh_password":"Vttek@123", "node_display_name":"controller01"}

vd: curl -X POST "http://172.16.29.193:4321/api/v1/hosts/add_host" -H  "accept: application/json" -H  "Content-Type: application/json" --data @nodes1.json


- POST: /api/v1/hosts/discover_hosts
Sau đó thực hiện thao tác xác nhận đã đẩy đủ Hosts và yêu cầu lấy thông tin các Host chèn vào trong DB
Thông tin HOST được đẩy vào các API bên dưới

vd: curl -X POST "http://172.16.29.193:4321/api/v1/hosts/discover_hosts" -H  "accept: application/json" -H  "Content-Type: application/json" --data @node_role.json


B3: Kiểm tra thông tin hosts đã được thêm đầy đủ:
- GET: /api/v1/hosts (lấy thông tin tất cả host trong cụm)

- GET: /api/v1/hosts/<string:host_id> (lấy thông tin 1 host)
- GET: /api/v1/hosts/host_info?host_id=xxx (lấy thông tin chi tiết 1 host)

- GET: /api/v1/hosts/interface_resources?interface_id=xx & device_name = xx & host_id =xxx (thông tin interface )
- GET: /api/v1/hosts/disk_resources?disk_id = xx & device_name = xx & host_id = xxx (thông tin ổ cứng)

vd: curl -X GET "http://172.16.29.193:4321/api/v1/hosts"



B3: Thêm thông tin role và thông tin service cho các server trong cụm OverCloud

"Assign Role + Service":


- GET: /api/v1/hosts (lấy thông tin tất cả host trong cụm curl -X GET "http://172.16.29.193:4321/api/v1/hosts")
	Lấy ra node_id là id của host, sử dụng node_id đó cho phần add_host_to_role bên dưới 
- POST: /api/v1/roles/add_host_to_role (THực hiện thao tác thêm role cho host)
curl -X POST "http://172.16.29.193:4321/api/v1/roles/add_host_to_role" -H  "accept: application/json" -H  "Content-Type: application/json" --data @node_role1.json
với node_role1.json = {"node_id":"1", "roles": ["CONTROLLER"]} //1 là id của node 

- GET: /api/v1/roles (Lấy ra thông tin tất cả role)
- GET: /api/v1/roles/<int:role_id>/role_info || /api/v1/roles/<int:role_id> (lấy ra thông tin từng role)

- POST: /api/v1/roles/test_create_deployment  (tạo data cho bảng deployments )
- POST: /api/v1/roles/test_create_service_setup (tạo data cho bảng service_setups)
- POST: /api/v1/roles/test_create_ansible_inventory_with_role (tạo ansible_inventory)
- POST: /api/v1/roles/test_create_ansible_playbook (tạo các playbooks)
- POST: /api/v1/roles/test_create_task (tạo data cho bảng task tưng ứng với việc cài đặt từng service)


ví dụ 'curl -X POST "http://172.16.29.193:4321/api/v1/roles/test_create_deployment" -H  "accept: application/json" -H  "Content-Type: application/json"'

B4: Check lại các API đã hoạt động chưa 

- GET: /api/v1/hosts/deployments || /api/v1/deployments 
- GET: /api/v1/hosts/<string:host_id>/deployments
- GET /api/v1/deployments/<string:deployment_id>/service_setups
- GET /api/v1/service_setups?deployment_id= & service_name= &
- GET /api/v1/deployments/<deployment_id>/playbooks
- GET /api/v1/deployments/<deployment_id>/playbooks ? service_setup_id=xxxx 
- GET /api/v1/deployments/<deployment_id>/service_setups
- GET /service_setups?deployment_id=&&service_name=
- GET /api/v1/service_setups/<service_setup_id>/tasks
- GET /api/v1/service_setups/<service_setup_id>/tasks?task_id=xxx 
- GET /api/v1/tasks
- GET /api/v1/tasks/<task_id>


B5: test 1 ansible run  command 

- POST: /api/v1/roles/test_run_first_ansible_playbook (tạo )