Tài liệu mô tả thiết kế API và URL   
Địa chỉ API: http://172.16.29.193:4321:

1.	TỔNG HỢP LIST METHOD+  URL:
"Discover Node":
POST /hosts/add_host
POST /hosts/update_host
GET  /hosts
POST /hosts/discover_hosts
GET  /hosts/<host_id>
GET  /hosts/host_info?host_id=xxx 
GET /hosts/host_info?host_id=xxxx&fields=ram,disk,mem,interface 
GET /hosts/interface_resources?interface_id=xx&device_name=xx, host_id=xxx
GET /hosts/disk_resources?disk_id=xx,device_name=xx,host_id=xxx 
# GET  /hosts?q=xxx 
# GET+POST /hosts/<host_id>/historys
# PUT  /hosts/host_id/refresh 


"Assign Role + Service":
GET  /roles
GET  /roles/<role_id>/role_info || /roles/<role_id>
POST /roles/add_host_to_role
POST /roles/test_create_deployment
POST /roles/test_create_service_setup
POST /roles/test_create_ansible_inventory_with_role
POST /roles/test_create_ansible_playbook
POST /roles/test_create_task



GET  /hosts/deployments || /deployments

GET  /hosts/<host_id>/deployments
GET /hosts/deployments/<deployment_id> || /deployments/<deployment_id> 
GET  /deployments/<deployment_id>/service_setups
GET  /deployments/<deployment_id>/service_setup_id  || GET  /service_setups/<service_setup_id> || GET  /service_setups?deployment_id=&service_name=&

# POST /service_setups/disable_setup
# POST /service_setups/enable_setup
GET  /deployments/<deployment_id>/playbooks
# GET   /deployments/<deployment_id>/playbooks?service_setup_id=xxxx 

GET  /service_setups/<service_setup_id>/tasks

GET  /service_setups/<service_setup_id>/<task_id>  || GET  /tasks/<task_id>

GET /tasks/
GET /tasks/<task_id>/changes 
GET /changes/<string:change_id>


"Insert Specific Config":
GET  /configs/specific_configs/
POST+PUT /api/configs/specific_configs
GET  /configs/specific_configs/validate
GET  /configs/specific_configs/recommend 
POST /configs/specific_configs/submit 


"START, UNDO, PAUSE, NEXT"
POST /installation/
action:-START-UNDO-PAUSE-NEXT 
GET  /installation
GET  /installation/node_info
GET  /installation/service_info?node_id=
GET  /installation/task_info?service_id= 
GET  /installation/change_info?task_id=


"SCALLING UP, SCALLING DOWN "
GET  /hosts?role=compute
POST /hosts/scalling_up_host
DELETE /hosts/scalling_down_host


"REPLACE CONTROLLER"
GET  /hosts?role=controller
POST /hosts/replace_controller


"TEMPLATE API"
GET  /templates
GET  /templates/filter?properties.name=&properties.type=


"RECOMMEND SYSTEM"
POST /recommendations/assign_role
POST /recommendations/select_service 
POST /recommendations/gen_password
POST /recommendations/select_IP 
POST /recommendations/select_folders
POST /recommendations/configs


"FILE CONFIFG "
GET  /configs/<host_id>
GET  /configs/filter?name=&path=&node=&service=
POST /configs/download_configs
GET  /configs/compare_config_db_vs_host?host_idt=
GET  /configs/compare_config_db_vs_host?file_config_id=
GET  /configs/compare_config_db_vs_db?file_config_1_id= & file_config_2_id=
GET  /configs/compare_config_host_vs_host?file_config_1_id= & file_config_2_id=
GET  /configs/<file_config_id>
GET  /configs/<file_config_id>/services 
GET /configs/<file_config_id>/content?type=database|server|last_update
POST /configs/update?file_config_id=file_config_id
POST /configs/commit?file_config_id=file_config_id
POST /configs/rollback?file_config_id


"CHANGE PASSWORD" 
GET  /passwords
GET  /passwords/<password_id>
PUT  /passwords/<passwords_id>
