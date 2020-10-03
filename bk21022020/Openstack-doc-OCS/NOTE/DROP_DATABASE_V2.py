“Discover Node":
	- POST: /api/addnodes
	- GET: /hosts/all
	- GET: /hosts?node_id=xxx
	- POST: /api/load_all_node/db ? node_namexxxxx
	- GET: /hosts/<host_name>
	- GET: /hosts/<string:host_name>/node_info
	- GET: /hosts/<string:host_name>/node_info/interface_resources?interface_id=xx,device_name=xx 
	- GET: /hosts/<string:host_name>/node_info/disk_resources?disk_id=xx,device_name=xx 
	- 



"Assign Role + Service":
	
	- GET: List_ROle: /api/roles/
	- Get: list_service in role  /api/roles?role_id=xxx

	- POST: /api/assign_role/
	DICT: {node_id:, role}
	- GET /hosts/host_name/service_setups
	- POST /host/host_name/service_setups/disable
		Json: list_disable_service 

	- GET /host/host_name/service_setups/<string:service_setup_id>/playbooks
	- GET /host/host_name/service_setups/<string:service_setup_id>/tasks/<task_id>



"Insert Specific Config":
	- Get: /api/configs/specific_configs/
	- POST: /api/configs/specific_configs/validate
	- POST: /api/configs/specific_configs/insert 
	- POST: /api/configs/specific_configs
		{submit:"TRUE"}
	- GET /host/host_name/service_setups/<string:service_setup_id>/tasks/<task_id>/changes


CPU_PIN 
vim /boot/efi/EFI/redhat/grub.cfg 

vim /etc/default/ovs-dpdk
/etc/init.d/ovs-dpdk restart 

OVS_MEM_CHANNELS=4
OVS_CORE_MASK=802 
OVS_PMD_CORE_MASK=80600806









