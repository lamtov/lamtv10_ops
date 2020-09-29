correlate_config.py

- Tìm ra được  những config nào đã bị thay đổi
- Xem xét config change làm thành performance issue 
- Tương tác với các SolarWinds systems, servers, network management products khác 
1. Track server and application changes:
	- Nhận alerted khi configurations change 
	- -> Cần biết được thời điểm, vị tríconfig thay đổi và ai làm ra thay đổi 
	- Sử dụng agent-based monitoring trên Linux sẽ nhìn ra đc thay đổi trong thời gian thực và ai làm thay đổi tới file này 
	- configuration Detail:
	+ Last change Time 
	+ Last status check 
	+ configuration items 

2. Compare configuration changes over time:
	- Xác định những thay đổi giữa 2 version của 1 file, script output hoặc registry settings
	- Stop "stare and compare" với highlights the changes giữa 2 configuration versions 
3. Vẽ mối liên hệ giữa config change và performance
4. Quản lý tập chung các tập lệnh, phân phối các tập lệnh đó đến các máy chủ trong môi trường của bạn, sau đó theo dõi và cảnh báo về các thay đổi đối với toàn bộ đầu ra của các tập lệnh
	==> Mở rộng năng lực  giám sát tới level của scripting prowess

5. 
Unified Web-based Dashboard
	- Network Performance Monitor 
	- Netflow Traffic Analyzer
Discovery and Resource Mapping
	- Network Configuration Manager 
	- Virtualization Manager 
Contralized Settings and Access Control 
	- Server and Application Monitor 
Alerting and Reporting 
	- Storage Resource Monitor 
	- Database Performance Analyzer
Consolidated Metric and Data 
	- Log Manager For Orion 
	- Server Configuration Monitor


6. Bổ xung ansible-network lấy thông tin các con switch_


============ list_views:
- discover node:
	Giao diện
	Giao diện Output: 
		+ cột 1: danh sách Node thêm đèn báo ok or not, thêm sửa xóa 
		- Khi ấn nút thêm thì hiện một form nhập host name, ip, ssh user, ssh password. Nhập xong sẽ tự thêm vào danh sách
		+ cột 2: System Information của Node được chọn trong cột 1 
		+ cột 3: Processors, Memory, Network Interface, disk ...

		Danh sách interface + status + ....

	Thêm filter lọc theo tài nguyên, sort theo tài nguyên, ....

===> Giống cái Windows Application Summary








- Assign Role + Service 
	
	2 hàng:
	hàng 1: danh sách role theo dạng biểu đồ cột + chọn template + test +... + recommend 

	+ Tổng tài nguyên từng Role + ...
	hàng 2: danh sách node + service sẽ cài, sau khi kéo thả cho chọn service luôn 

- Recommend web page 
- Insert Specific Config:
	Chia thành nhiều tab cho các loại config khác nhau, mỗi tab gồm một nhóm config 
	Đánh dấu * cho các kiểu config 
	Mỗi config chia làm 2 cột key + value + describe 

- Giao diện Setup:
	4 cột: node + service + task + status  mô tả đang cài trên node nào, service nào,  task nào
	1 thanh chạy mô tả đang cài 
	các button undo, pause,next, log error

	giống bảng transfer status 


================== Giám sát 
- giao diện scalling up + scalling down + replace_controller 
Kích chọn danh sách Node + Tiến trình + ....





- Giao diện kiểm tra và Commit:
	List file_config bị thay đổi + thời điểm thay đổi ===> page so sánh  + Restore 



- Giao diện kiểm tra và Update config :
	Danh sách Node + Danh sách File_config trên node đó theo kiến trúc nhánh cây + Recent Configuration Changes  
	Khi vuốt vào node_name xuất ra thông tin tóm tắt Node đó .


	dựa theo config change templates

	+ Download tất cả config trên Node đó .
	(backup)
	+ Download Config Change Report 
	+ Compare 2 configs in 2 nodes
	+ 
- Kích vào chọn 1 file_config có 
hàng trên cùng thông tin file path + Node + Các service liên quan 
2 bảng: với 2 biểu tượng 
config on Database + Config one Node + Commit time + Download  + Riêng phần password ko cho sửa ở đây 
update ===>
Commit <===
rollback ""

+++ Rollback nhiều thay đổi một lúc :
list danh sách thay đổi
button rollback 



-- Giao diện change password 



