from app import  db, session, Node_Base, Column, relationship, ansible
from datetime import  datetime
import  models
import os
import json
import oyaml as yaml
import global_assets.const as CONST


def create_response(res, error=False, err_code=None):
    return {
        "status":"OK" if not error else "Error" ,
        "data":res
     }

# def get_facts(ansible_inventory_dir, ansible_facts_dir):
#     list_nodes = session.query(models.Node).all()
#     os.system(' rm -rf ' + ansible_inventory_dir)
#     file_new_node = open(ansible_inventory_dir,"a")
#     file_new_node.write('[all]')
#     file_new_node.write("\n")
#     for node in list_nodes:
#         file_new_node.write(node.management_ip+" " + "ansible_ssh_user="+str(node.ssh_user) + " "+ "ansible_ssh_pass="+str(node.ssh_password))
#         file_new_node.write("\n")
#     for node in list_nodes:
#         file_new_node.write('['+str(node.node_display_name)+']' )
#         file_new_node.write("\n")
#         file_new_node.write(node.management_ip+" " + "ansible_ssh_user="+str(node.ssh_user) + " "+ "ansible_ssh_pass="+str(node.ssh_password))
#         file_new_node.write("\n")
#     file_new_node.close()
#     f = open(ansible_inventory_dir, "r")
#     return f.read()
#


    #os.system('ansible all  -i /etc/ansible/inventory/new_node -m setup  --tree ' + ansible_facts_dir)
    #print(get_facts(inventory_dir,facts_dir))
    #runner = ansible.Runner('ansible_get_facts.yml', 'new_node',
    #                          {'extra_vars': {'target': "all", 'facts_dir': facts_dir}, 'tags': ["download"]}, None, False, None,
    #                          None, None)
    #stats = runner.run()










def create_ansible_playbook(host_name, service_name, role_name):
    return "OK"


#
# def load_node_info_to_database(ansible_facts_dir):
#     nodes=session.query(models.Node).all()
#
#     for node in nodes:
#         node.updated_at=datetime.now()
#         node.node_type="oenstack"
#         status="udate_info_to_database"
#         with open(ansible_facts_dir+"/"+ str(node.management_ip)) as data_node:
#             node_data = json.load(data_node)
#             ansible_facts=node_data['ansible_facts']
#             #print(node_data)
#             node_name = ansible_facts['ansible_hostname']
#             memory_mb = ansible_facts['ansible_memtotal_mb']
#             memory_mb_free=ansible_facts['ansible_memfree_mb']
#             numa_topology=None
#             metrics= None
#             processor_core=ansible_facts['ansible_processor_cores']
#             processor_count=ansible_facts['ansible_processor_count']
#             processor_threads_per_core=ansible_facts['ansible_processor_threads_per_core']
#             processor_vcpu=ansible_facts['ansible_processor_vcpus']
#             os_family=ansible_facts['ansible_os_family']
#             pkg_mgr=ansible_facts['ansible_pkg_mgr']
#             os_version=ansible_facts['ansible_distribution_version']
#             default_ipv4=ansible_facts['ansible_default_ipv4']['address']
#             default_broadcast=ansible_facts['ansible_default_ipv4']['broadcast']
#             default_gateway=ansible_facts['ansible_default_ipv4']['gateway']
#             default_interface_id=ansible_facts['ansible_default_ipv4']['interface']
#
#             node_info=models.Node_info(node_name=node_name,memory_mb=memory_mb,memory_mb_free=memory_mb_free,numa_topology=numa_topology,metrics=metrics,processor_core=processor_core,processor_count=processor_count,processor_threads_per_core=processor_threads_per_core, processor_vcpu=processor_vcpu,os_family=os_family, pkg_mgr=pkg_mgr,os_version=os_version,default_ipv4=default_ipv4,default_broadcast=default_broadcast,default_gateway=default_gateway,default_interface_id=default_interface_id)
#             interface_resources=[]
#
#             for interface in ansible_facts['ansible_interfaces']:
#                 if "docker" not in interface and "veth" not in interface and "virb" not in interface :
#
#                     interface_info=ansible_facts['ansible_'+interface]
#                     device_name=interface_info.get('device')
#                     speed=interface_info.get('speed')
#                     port_info=None
#                     active=str(interface_info.get('active'))
#                     features=str(interface_info.get('features'))
#                     macaddress=interface_info.get('macaddress')
#                     module=interface_info.get('module')
#                     mtu=interface_info.get('mtu')
#                     pciid=interface_info.get('pciid')
#                     phc_index=interface_info.get('phc_index')
#                     type_interface=interface_info.get('type_interface')
#                     if device_name==ansible_facts['ansible_default_ipv4']['interface']:
#                         is_default_ip='True'
#                     else:
#                         is_default_ip='False'
#
#                     interface_resource=models.Interface_resource(device_name=device_name,speed=speed,port_info=port_info,active=active,features=features,macaddress=macaddress,module=module,mtu=mtu,pciid=pciid,phc_index=phc_index,type_interface=type_interface,is_default_ip=is_default_ip)
#                     interface_resources.append(interface_resource)
#             node_info.interface_resources=interface_resources
#
#             disk_resources=[]
#             for device in ansible_facts['ansible_devices']:
#                 if "sd" in device:
#                     device_data=ansible_facts['ansible_devices'][str(device)]
#                     device_name=device
#                     size = int(float(device_data.get('size')[0:-2].replace(" ", "")))
#                     model = device_data.get('model')
#                     removable= device_data.get('removable')
#                     sectors = device_data.get('sectors')
#                     sectorsize=device_data.get('sectorsize')
#                     serial = device_data.get('serial')
#                     vendor = device_data.get('vendor')
#                     support_discard=device_data.get('support_discard')
#                     virtual=device_data.get('virtual')
#
#                     disk_resource= models.Disk_resource(device_name=device_name, size=size, model=model, removable=removable,sectors=sectors,sectorsize=sectorsize,serial=serial, vendor=vendor,support_discard=support_discard,virtual=virtual)
#                     disk_resources.append(disk_resource)
#
#             node_info.disk_resources=disk_resources
#             node.node_info=node_info
#             session.add(node)
#             session.commit()
#
