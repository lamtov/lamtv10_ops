https://www.cisco.com/c/en/us/td/docs/net_mgmt/network_function_virtualization_Infrastructure/3_0_0/admin_guide/Cisco_VIM_Admin_Guide_3_0_0/Cisco_VIM_Admin_Guide_3_0_0_chapter_01.html


https://www.cisco.com/c/en/us/td/docs/net_mgmt/network_function_virtualization_Infrastructure/2_2_8/Cisco_VIM_Install_Guide_2_2_8/Cisco_VIM_Install_Guide_2_2_7_chapter_0111.html


Nội dung ban đầu mong muốn:

- Lưu thông tin list_server:
	list_server: server_id , server_name, ip_address, user, password, role_id
	infor_server: server_id, os, cpu_info, RAM, DISK, NETWORK 
	role: role_id,role_name,
	role_service: role_id, service_id 
	service: service_id, service_name, container_name, service_config

- Lưu thông tin list_server và thông tin task liên quan đến server đó, phục vụ cho việc kiểm soát thông tin tiến trình cài đặt trên từng server 
	list_server:
	server_task: server_id, task_id 
	task: task_id, progress, status, info, log, change_id
	change: change_id, new_file, backup_file



Nội dung tham khảo
	- version: có nên chia thành các database riêng không hay chỉ để dạng một column trong table 
		Nên để version nhưng chỉ nên để dạng tập chung config, luồng cài đặt có lẽ cũng nên để dạng version nhưng vì cài đặt thông qua ansible 
			--> cái này fix cứng trong database và chỉ truy vấn trong api để hiển thị ko có khả năng chỉnh sửa 

	==> database sẽ là version_
	ví dụ queens / rocky 

	--> phần thiết kế sẽ chỉ tập chung thiết kế các bảng và các trường trong database.

Ví dụ 


/node/
	+ node:
		created_at DATETIME
		updated_at DATETIME
		deleted_at DATETIME
		node_id  VARCHAR(36)
		management_ip 
		user 
		password

		status TEXT (init, setup, update, upgrade, running, maintain, deleted,,,,) 
		node_display_name VARCHAR(255)
		resource_id VARCHAR(36)
		role_id
		setup_id VARCHAR(36)




	+ hardware_info: 
		hardware_id VARCHAR(36)
		vcpus_free INT(11)
		memory_mb 
		disk_gb 
		memory_mb_free INT(11)
		disk_gb_free  INT(11)
		numa_topology TEXT 
		network_resouce_id VARCHAR(36)
		os_type MEDIUNTEXT
		os_version INT 
		metrics TEXT

	+ network_resource 
		network_resouce_id VARCHAR(36)
		port_display_name 
		port_bandwidth
		port_info
		status 


/setup/list_server
	+ role (Dùng để đầu tiên kiểm tra các role )
		role_id 
		role_display_name 
		role_type


	+ role_service 
		role_id 
		service_id 
	+ service 
		service_id 
		service_type
		service_name 
		service_config 
		service_lib
	+ service_task
		service_id 
		service_name 
		task_id 
		number_order
	+ task
		task_id
		created_at
		finished_at
		task_display_name
		setup_data
		task_type (install, update, config, validate)
		status 
		result 
		log 

	+ task_change
		task_id 
		change_id 
		task_index 
	+ change
		change_id 

		created_at
		finished_at 
		status 
	
		change_type (install, update, config)
		new_service
		backup_service 
		new_file 
		backup_file 
		new_folder
		backup_folder
		change_log 

	+ setup		
	setup_id 
		created_at
		updated_at
		finished_at 
		
		status
		name 
		jsondata
		log 
		result 
		progress 
	+ setup_service 
		setup_id 
		service_id 
		service_index
		is_validated_success
		validated_status: 



/operation/
	+ openstack_config
	created_at
	updated_at
	update_id
	key 
	value
	service 
	file 
	node_id 


	+ update 
	update_id 
	created_at
	deleted_at (dùng cho lúc roll_back)

	+ update_change
	update_id
	change_id 

	+ change
	created_at
	finished_at 
	status 
	change_id 
	change_type (install, update, config)
	new_service
	backup_service 
	new_file 
	backup_file 
	new_folder
	backup_folder
	change_log 

	+ password
	created_at
	updated_at
	update_id
	key 
	value





