
Openvswitch
-----   , product-id, search-disabled-repos
----- redhat-lsb-core, redhat-lsb



yum install redhat-lsb-core redhat-lsb langpacks product-id search-disabled-repos



----------------------------------   ----------------------------------   ----------------------------------
  lspci command : List all PCI devices. | lspci --vv 
  lshw command : List all hardware.
  dmidecode command : List all hardware data from BIOS.
  ifconfig command : Outdated network config utility.
  ip command : Recommended new network config utility.
  lspci command
  Type the following command:
  # lspci | egrep -i --color 'network|ethernet'


  De kiem tra lspci nic nao dang duoc map vao network interface nao su dung command:
    =================>>>> systool -c net

  Class Device = "p1p1"
    Device = "0000:82:00.0"

  Class Device = "p1p2"
    Device = "0000:82:00.1"

82:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
82:00.1 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)


/sys/class/net/p1p2/device
lspci | grep 82599


echo '8' > /sys/class/net/p1p1/device/sriov_numvfs
systemctl restart neutron-sriov-nic-agent.service




 neutron net-create --provider:physical_network=physnet1 --provider:network_type=flat sriov

 neutron net-list
 neutron subnet-create sriov --name subnet2 11.0.0.0/24
  neutron subnet-list 
   neutron port-create 7fd5a8e1-9f63-44b2-8d12-2ea53964e267  --name p2  --binding:vnic-type direct 





 1026  net_id=`neutron net-show sriov | grep "\ id\ " | awk '{ print $4 }'`
 1027  port_id=`neutron port-create $net_id --name sriov_port --binding:vnic_type direct | grep "\ id\ " | awk '{ print $4 }'`
 1028  nova boot --flavor 4C4R8G --image Ubuntu.xenial --nic port-id=$port_id test-sriov
 1029  nova boot --flavor 4C4R8G --image Cirros --nic port-id=$port_id  --availability-zone nova:compute02  test-srdiov8









nova boot --flavor 4C4R8G --image Ubuntu.xenial  --nic net-id=7fd5a8e1-9f63-44b2-8d12-2ea53964e267  --nic port-id=253af000-ea38-4bd0-84c7-66fe3d41e08b      anamad

nova boot --flavor 4C4R8G --image Ubuntu.xenial --nic port-id=$port_id  --availability-zone nova:compute02  test-srdiov





----------------------------------   ----------------------------------   ----------------------------------



 neutron net-create --provider:physical_network=physnet1 --provider:network_type=flat sriov
 neutron net-list
  neutron subnet-create sriov --name subnet2 172.16.32.0/24
   neutron port-create c6c488f9-2be6-4208-9400-abecada21b20  --name tolam --binding:vnic-type direct --device_owner network:dhcp








nova boot --flavor 4C4R8G --image Ubuntu.xenial  --nic net-id=bd84cf7e-3fad-40f3-8914-dc3665757c47 --nic port-id=414ea323-b0e1-405a-beb3-878dbc14b4a3    --availability-zone nova:compute02    tova











******************************

2019-07-04 17:08:24.914 41045 INFO neutron.agent.securitygroups_rpc [req-142a613f-9c3c-4612-801b-e4b6a83c0e91 0e47933895d7410b8055047da118b337 a15234964f6c4a82a906ba7f393ebcbc - - -] Security group member updated [u'71359c0c-0d10-4097-b5cb-0192cf7505f2']
2019-07-04 17:08:25.005 41045 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-142a613f-9c3c-4612-801b-e4b6a83c0e91 0e47933895d7410b8055047da118b337 a15234964f6c4a82a906ba7f393ebcbc - - -] port_update received port_update /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:71
2019-07-04 17:08:25.006 41045 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-142a613f-9c3c-4612-801b-e4b6a83c0e91 0e47933895d7410b8055047da118b337 a15234964f6c4a82a906ba7f393ebcbc - - -] port_update RPC received for port: 0b1acd6d-ce2e-412f-bd5c-31dd7eb79414 with MAC fa:16:3e:af:ea:28 and PCI slot 0000:82:11.0 slot port_update /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:93
2019-07-04 17:08:26.432 41045 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Agent rpc_loop - iteration:398 started daemon_loop /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:374
2019-07-04 17:08:26.433 41045 DEBUG neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-04 17:08:26.440 41045 DEBUG neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show', 'p1p1'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-04 17:08:26.443 41045 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Agent loop found changes! {'current': set([(u'fa:16:3e:99:18:59', '0000:82:11.4'), (u'fa:16:3e:af:ea:28', '0000:82:11.0')]), 'removed': set([]), 'added': set([(u'fa:16:3e:af:ea:28', '0000:82:11.0')]), 'updated': set([(u'fa:16:3e:af:ea:28', u'0000:82:11.0')])} daemon_loop /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:391
2019-07-04 17:08:26.444 41045 INFO neutron.agent.securitygroups_rpc [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Skipping method prepare_devices_filter as firewall is disabled or configured as NoopFirewallDriver.
2019-07-04 17:08:26.444 41045 INFO neutron.agent.securitygroups_rpc [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Skipping method refresh_firewall as firewall is disabled or configured as NoopFirewallDriver.
2019-07-04 17:08:26.638 41045 DEBUG neutron.api.rpc.handlers.securitygroups_rpc [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Security group member updated on remote: [u'71359c0c-0d10-4097-b5cb-0192cf7505f2'] security_groups_member_updated /usr/lib/python2.7/site-packages/neutron/api/rpc/handlers/securitygroups_rpc.py:198
2019-07-04 17:08:26.638 41045 INFO neutron.agent.securitygroups_rpc [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Security group member updated [u'71359c0c-0d10-4097-b5cb-0192cf7505f2']
2019-07-04 17:08:26.640 41045 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Port with MAC address fa:16:3e:af:ea:28 is added treat_devices_added_updated /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:295
2019-07-04 17:08:26.640 41045 INFO neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Port fa:16:3e:af:ea:28 updated. Details: {u'profile': {u'pci_slot': u'0000:82:11.0', u'physical_network': u'physnet1', u'pci_vendor_info': u'8086:10ed'}, u'network_qos_policy_id': None, u'qos_policy_id': None, u'allowed_address_pairs': [], u'admin_state_up': True, u'network_id': u'447bcbe2-5ced-4be4-9fbd-08c2b1db4796', u'segmentation_id': None, u'mtu': 1500, u'device_owner': u'compute:nova', u'physical_network': u'physnet1', u'mac_address': u'fa:16:3e:af:ea:28', u'device': u'fa:16:3e:af:ea:28', u'port_security_enabled': True, u'port_id': u'0b1acd6d-ce2e-412f-bd5c-31dd7eb79414', u'fixed_ips': [{u'subnet_id': u'64d1a702-5104-40f9-9d34-c2cbfb20bb6c', u'ip_address': u'172.16.32.7'}], u'network_type': u'flat'}
2019-07-04 17:08:26.640 41045 DEBUG neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-04 17:08:26.647 41045 DEBUG neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show', 'p1p1'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-04 17:08:26.650 41045 DEBUG neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-04 17:08:26.655 41045 DEBUG neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show', 'p1p1'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-04 17:08:26.658 41045 DEBUG neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'set', 'p1p1', 'vf', '4', 'spoofchk', 'on'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-04 17:08:26.662 41045 INFO neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Device fa:16:3e:af:ea:28 spoofcheck True
2019-07-04 17:08:26.663 41045 DEBUG neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-04 17:08:26.669 41045 DEBUG neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show', 'p1p1'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-04 17:08:26.673 41045 DEBUG neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'set', 'p1p1', 'vf', '4', 'state', 'enable'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-04 17:08:26.677 41045 ERROR neutron.agent.linux.utils [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Exit code: 2; Stdin: ; Stdout: ; Stderr: RTNETLINK answers: Operation not supported

2019-07-04 17:08:26.677 41045 WARNING neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Device fa:16:3e:af:ea:28 does not support state change: IpCommandOperationNotSupportedError: Operation not supported on device p1p1
2019-07-04 17:08:26.944 41045 DEBUG neutron.api.rpc.handlers.securitygroups_rpc [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Security group member updated on remote: [u'71359c0c-0d10-4097-b5cb-0192cf7505f2'] security_groups_member_updated /usr/lib/python2.7/site-packages/neutron/api/rpc/handlers/securitygroups_rpc.py:198
2019-07-04 17:08:26.944 41045 INFO neutron.agent.securitygroups_rpc [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Security group member updated [u'71359c0c-0d10-4097-b5cb-0192cf7505f2']
2019-07-04 17:08:28.432 41045 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-f60111c6-3103-4240-80c1-7e75788dbc85 - - - - -] Agent rpc_loop - iteration:399 started daemon_loop /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:374






********************













OVS_BRIDGE_MAPPINGS=${OVS_BRIDGE_MAPPINGS:-'default:br-mpbn,mpbn:br-mpbn,sigtran:br-sigtran'}
OVS_DPDK_PORT_MAPPINGS=${OVS_DPDK_PORT_MAPPINGS:-'enp12s0f1:br-mpbn,enp0s29u1u1u5:br-sigtran'}
OVS_PCI_MAPPINGS=${OVS_PCI_MAPPINGS:-'0000:0c:00.0#enp12s0f1,0000:0c:00.1#enp0s29u1u1u5'}
OVS_DPDK_BIND_PORT=${OVS_DPDK_BIND_PORT:-True}




#OVS_BOND_MODE=${OVS_BOND_MODE:-'bond-mpbn:active-backup,bond-sigtran1:active-backup,bond-sigtran2:active-backup,bond-linksite:active-backup'}
#OVS_BOND_PORTS=${OVS_BOND_PORTS:-'bond-mpbn:enp98s0f1,bond-mpbn:enp220s0f1,bond-sigtran1:enp98s0f2,bond-sigtran1:enp220s0f2,bond-sigtran2:enp103s0f0,bond-sigtran2:enp225s0f0,bond-linksite:enp103s0f1,bond-linksite:enp225s0f1'}

OVS_BRIDGE_MAPPINGS=${OVS_BRIDGE_MAPPINGS:-'mgnt:br-mgnt,provider:br-provider,provider1:br-provider1'}
OVS_DPDK_PORT_MAPPINGS=${OVS_DPDK_PORT_MAPPINGS:-'p1p2:br-provider,p1p1:br-provider1'}
OVS_PCI_MAPPINGS=${OVS_PCI_MAPPINGS:-'82:00.1#p1p2,82:00.0#p1p1,01:00.0#em1'}
OVS_DPDK_BIND_PORT=${OVS_DPDK_BIND_PORT:-True}


***** Loi 1: Thieu kernel-devel
***** Loi 2: Cau hinh thieu hugepage

1. lay thogn tin bawng     lspci | egrep -i --color 'network|ethernet'
2. sua file /ovs-dpdk/settings sua hugepage tang cho du 
3. check core de dung vcpu pin: /usr/src/dpdk-stable-17.11.4/usertools/cpu_layout.py
4. sua cat /etc/default/grub
them enable hugepage 1G 
GRUB_CMDLINE_LINUX="net.ifnames=1 crashkernel=auto rd.lvm.lv=vg00/lv_root rd.lvm.lv=vg00/lv_swap rd.lvm.lv=vg00/lv_usr rhgb quiet default_hugepagesz=1G hugepagesz=1G hugepages=238 intel_iommu=on iommu=pt isolcpus=2-17,38-53,20-35,56-71"

5. sua qemu-kvm hoac qemu-x86_8=64 theo email anh namcht




277 tar -zvf dpdk-17.11.4.tar.xz
278 tar -xvf dpdk-17.11.4.tar.xz
279 ll
280 mv dpdk-stable-17.11.4/ DPDK-v17.11.4
281 tar -xvzf openvswitch-2.9.0.tar.gz
282 ll
283 mv openvswitch-2.9.0 ovs
284 cd openvswitch/
285 ll
286 vim settings
287 vim libs/ovs-dpdk
288 bash setup.sh setup pre-install
289 bash setup.sh setup install
290 yum install numactl-devel
291 bash setup.sh setup install
292 ovs-vsctl show

ovs-ofctl dump-flows br-provider

293 ovs-ofctl add-flow br-provider  in_port=eno2,priority=2000,action=pop_vlan,NORMAL
294 ovs-ofctl add-flow br-sigtran1 in_port=enp98s0f2,action=pop_vlan,NORMAL
295 ovs-ofctl add-flow br-sigtran2 in_port=enp103s0f0,action=pop_vlan,NORMAL
296 ovs-ofctl add-flow br-linksite in_port=enp103s0f1,action=pop_vlan,NORMAL


cd /usr/src/DPDK-v17.05.1/usertools
 1989  ./dpdk-setup.sh 
[15] Insert IGB UIO module
[16] Insert VFIO module
[17] Insert KNI module
[18] Setup hugepage mappings for non-NUMA systems
[19] Setup hugepage mappings for NUMA systems
[20] Display current Ethernet/Crypto device settings
[21] Bind Ethernet/Crypto device to IGB UIO module
[22] Bind Ethernet/Crypto device to VFIO module
[23] Setup VFIO permissions


 1990  vim /etc/default/ovs-dpdk 

0000:0c:00.0 
0000:0c:00.1  







  ifconfig 
    2  cd /etc/sysconfig/network-scripts/
    3  ll
    4  vim ifcfg-eth1
    5  vi ifcfg-eth1
    6  vi ifcfg-ethw
    7  vi ifcfg-eth2
    8  ifup eth1
    9  ifconfig 
   10  exit
   11  ifconfig






DEVICE="eth1"
BOOTPROTO="dhcp"
BOOTPROTOv6="none"
ONBOOT="yes"
TYPE="Ethernet"
USERCTL="yes"
PEERDNS="yes"
IPV6INIT="no"
PERSISTENT_DHCLIENT="1"













OVS_BRIDGE_MAPPINGS=${OVS_BRIDGE_MAPPINGS:-'default:br-mpbn,mpbn:br-mpbn,sigtran:br-sigtran'}
OVS_DPDK_PORT_MAPPINGS=${OVS_DPDK_PORT_MAPPINGS:-'enp12s0f1:br-mpbn,enp0s29u1u1u5:br-sigtran'}
OVS_PCI_MAPPINGS=${OVS_PCI_MAPPINGS:-'0000:62:00.1#enp12s0f1,0000:dc:00.1#enp0s29u1u1u5'}
OVS_DPDK_BIND_PORT=${OVS_DPDK_BIND_PORT:-True}


apt-get install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

 apt-get install openvswitch-switch



 docker run -d --name ovs-agentx --network=host --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_OVS_AGENT'   docker-registry:4000/neutron:q




        docker run -d --name dhcp-agent --network=host  --privileged --user neutron -v $VAR_LOG_DIR/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/   -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_DHCP_AGENT' docker-registry:4000/neutron:q
	# --restart unless-stopped
        docker run -d --name metadata-agentXY --network=host  --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run/netns:/run/netns:shared -v /usr/share/docker/:/usr/share/docker/ -v /usr/share/docker/neutron/neutron/:/etc/neutron/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_METADATA_AGENT' docker-registry:4000/neutron:q








docker run -d --name nova-scheduler --network=host --restart unless-stopped --privileged -u nova -v /var/log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_SCHEDULER' docker-registry:4000/nova:q



	docker run  --network=host --restart unless-stopped --privileged -u root -v /var/log/apache2:/var/log/apache2 -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_PLACEMENT_API' docker-registry:4000/nova:q







  42  bash setup.sh setup pre-install
   43  bash setup.sh setup install
   44  yum install numactl-devel
   45  systemctl status libvirtd
   46  virsh list
   47  vim /etc/yum.repos.d/local.repo 
   48  yum clean all
   49  yum repolist
   50  vim /etc/yum.repos.d/local.repo 
   51  yum clean all
   52  yum repolist
   53  bash setup.sh setup pre-install
   54  yum install redhat-lsb-core
   55  yum install redhat-lsb
   56  vim /etc/yum.repos.d/local.repo 
   57  yum clean all
   58  yum repolist
   59  yum install redhat-lsb
   60  vim /etc/yum.repos.d/local.repo 
   61  yum clean all
   62  yum repolist
   63  vim /etc/yum.repos.d/local.repo 
   64  yum clean all
   65  yum repolist
   66  yum clean all
   67  yum repolist
   68  vim /etc/yum.repos.d/local.repo 
   69  yum clean all
   70  yum repolist
   71  yum install redhat-lsb-core redhat-lsb langpacks product-id search-disabled-repos
   72  yum install redhat-lsb-core 
   73  yum remove 4:perl-5.16.3-293.el7.x86_64
   74  yum install redhat-lsb-core 
   75  yum remove gdbm-1.10-8.el7.x86_64
   76  yum install redhat-lsb-core 
   77  yum remove gdbm-1.10-8.el7.x86_64
   78  yum install gdbm-1.8.0-39.el6.x86_64
   79  yum install redhat-lsb-core 
   80  rpm -Va --nofiles --nodigest
   81  yum install redhat-lsb-core 
   82  yum reinstall gdbm-devel-1.8.0-39.el6.x86_64
   83  yum reinstall gdbm-devel
   84  yum reinstall gdbm
   85  yum reinstall libgdbm.so.4
   86  yum downgrade glibc glibc-headers glibc-common glibc-devel
   87  yum install glibc-static
   88  rpm -e --justdb
   89  yum autoremove
   90  vim /etc/yum.repos.d/redhat.repo 
   91  vi /etc/yum.repos.d/redhat.repo 
   92  yum install redhat-lsb-core 
   93  yum downgrade gdbm-devel
   94  yum remove gdbm-devel
   95  yum install gdbm-devel
   96  yum install libgdbm.so.2
   97  yum reinstall glibc-common
   98  yum remove glibc-common-2.17-260.el7.x86_64
   99  yum reinstall glibc-common
  100  yum install libgdbm.so.2
  101  yum install glibc-common-2.12-1.192.el6.x86_64
  102  yum install gdbm-devel
  103  yum downgrade glibc-common-2.12-1.192.el6.x86_64
  104  yum downgrade glibc-common
  105  yum downgrade glibc-common --skip-broken
  106  yum install gdbm-devel
  107  yumm install glibc-2.12-1.192.el6.i686
  108  glibc-2.12-1.192.el6.i686
  109  yum -y downgrade glibc glibc-common
  110  yum install redhat-lsb-core redhat-lsb langpacks product-id search-disabled-repos
  111  vim
  112  yum group install "Development Tools"
  113  vim
  114  yum install virt-manager libvirt libvirt-python python-virtinst libvirt-client
  115  yum grouplist
  116  yum group install "Virtualization Host
"
  117  vim
  118  netsta
  119  netstat
  120  yum grouplist
  121  systemctl status libvirtd
  122  vim /etc/resolv.conf
  123  cat  /etc/resolv.conf
  124  virsh list
  125  df -h
  126  cd /u01
  127  ll
  128  mkdir setup
  129  ll
  130  cd setup/
  131  ll
  132  tar -xvzf qemu-2.12.0.v.tar.xz 
  133  ll
  134  cd /usr/
  135  cd /root/setup/
  136  l
  137  ll
  138  yum -y install glib2-devel
  139  yum -y install pixman-devel
        yum -y install zlib-devel
  140  libvirtd -v
  141  yum remove qemu-kvm






wift
kafka lvm
chuan hoa - memory huge page
numa tạo máy ảo chuẩn
qemu 12
pin cpu, afinity 
cản báo giám sát, script -> ghi chậm, mất kết nối
sửa lại chrony


promethod


1 top
332 vim /etc/default/ovs-dpdk
333 top
334 vim /etc/default/ovs-dpdk
335 cat /etc/default/ovs-dpdk
336 /etc/init.d/ovs-dpdk stop
337 /etc/init.d/ovs-dpdk start
338 qemu-system-x86_64 --version
339 yum remove qemu
340 yum remove qemu-kvm
341 yum autoremove
342 rpm -qa | grep qemu
343 yum install qemu-kvm
344 rpm -qa | grep qemu
345 /etc/init.d/ovs-dpdk stop
346 cd /u01/seqe
347 ll
348 cd bu
349 ll
350 ../configure --prefix=/usr --sysconfdir=/etc --target-list=x86_64-softmmu --enable-debug --with-sdlabi=2.0 --docdir=/usr/share/doc/qemu-2.12.0
351 make -j4
352 cd /u01/
353 mkdir setup
354 ifconfig
355 cd setup/
356 ll
357 mv /tmp/qemu-2.12.0.tar.xz .
358 ll
359 mv /tmp/SDL2-2.0.9-1.el7.x86_64.rpm .
360 ll
361 rpm -Uvh SDL2-2.0.9-1.el7.x86_64.rpm
362 tar -xvzf qemu-2.12.0.tar.xz
363 tar -xvf qemu-2.12.0.tar.xz
364 cd qemu-2.12.0/
365 mkdir build
366 cd build/
367 ../configure --prefix=/usr --sysconfdir=/etc --target-list=x86_64-softmmu --enable-debug --with-sdlabi=2.0 --docdir=/usr/share/doc/qemu-2.12.0
368 make -j4
369 make install
370 qemu-system-x86_64 --version
371 /usr/libexec/qemu-kvm --version
372 reboot
373 vim /usr/share/docker/swift/swift/account-server.conf
374 ifconfig
375 vim /usr/share/docker/swift/swift/account-server.conf
376 vim /usr/share/docker/swift/swift/container-server.conf
377 vim /usr/share/docker/swift/swift/object-server.conf




        Socket 0        Socket 1       
        --------        --------       
Core 0  [0, 24]         [1, 25]        
Core 1  [2, 26]         [3, 27]        
Core 2  [4, 28]         [5, 29]        
Core 3  [6, 30]         [7, 31]        
Core 4  [8, 32]         [9, 33]        
Core 5  [10, 34]        [11, 35]       
Core 8  [12, 36]        [13, 37]       
Core 9  [14, 38]        [15, 39]       
Core 10 [16, 40]        [17, 41]       
Core 11 [18, 42]        [19, 43]       
Core 12 [20, 44]        [21, 45]       
Core 13 [22, 46]        [23, 47]



hw:cpu_policy dedicated
hw:cpu_threads_policy separate



hw:mem_page_size 1GB
65536


  4C8G12G


systemctl status iptables
 1001  systemctl status firewalld
 1002  ll
 1003  lspci | grep 82599
 1004  modprobe igb
 1005  modprobe igb max_vfs=8
 1006  lspci | grep 82599
 1007  echo '8' > /sys/class/net/p1p1/device/sriov_numvfs
 1008  lspci | grep 82599
 1009  ll
 1010  vim /etc/neutron/neutron.conf 
 1011  vim /etc/nova/nova.conf
 1012  systemctl restart openstack-nova-compute.service 
 1013  chronyc tracking
 1014  systemctl restart chronyd
 1015  chronyc tracking
 1016  systemctl restart openstack-nova-compute.service 
 1017  systemctl restart neutron-sriov-nic-agent.service 
 1018  tail -f /var/log/neutron/sriov-nic-agent.log 
 1019  systemctl status neutron-sriov-nic-agent.service 
 1020  chown neutron:neutron /var/log/neutron/sriov-nic-agent.log 
 1021  systemctl restart neutron-sriov-nic-agent.service 
 1022  systemctl status neutron-sriov-nic-agent.service 
 1023  tail -f /var/log/neutron/sriov-nic-agent.log 
 1024  source ~/open.rc 
 1025  openstack network agent list
 1026  tail -f /var/log/nova/nova-compute.log
 1027  ll
 1028  virsh list
 1029  '



 2019-07-05 09:39:26.694 30098 DEBUG neutron.api.rpc.handlers.securitygroups_rpc [req-c5695bf4-d57f-488e-8051-66020bf6d147 0e47933895d7410b8055047da118b337 a15234964f6c4a82a906ba7f393ebcbc - - -] Security group member updated on remote: [u'71359c0c-0d10-4097-b5cb-0192cf7505f2'] security_groups_member_updated /usr/lib/python2.7/site-packages/neutron/api/rpc/handlers/securitygroups_rpc.py:198
2019-07-05 09:39:26.694 30098 INFO neutron.agent.securitygroups_rpc [req-c5695bf4-d57f-488e-8051-66020bf6d147 0e47933895d7410b8055047da118b337 a15234964f6c4a82a906ba7f393ebcbc - - -] Security group member updated [u'71359c0c-0d10-4097-b5cb-0192cf7505f2']
2019-07-05 09:39:27.044 30098 DEBUG neutron.api.rpc.handlers.securitygroups_rpc [req-c5695bf4-d57f-488e-8051-66020bf6d147 0e47933895d7410b8055047da118b337 a15234964f6c4a82a906ba7f393ebcbc - - -] Security group member updated on remote: [u'71359c0c-0d10-4097-b5cb-0192cf7505f2'] security_groups_member_updated /usr/lib/python2.7/site-packages/neutron/api/rpc/handlers/securitygroups_rpc.py:198
2019-07-05 09:39:27.044 30098 INFO neutron.agent.securitygroups_rpc [req-c5695bf4-d57f-488e-8051-66020bf6d147 0e47933895d7410b8055047da118b337 a15234964f6c4a82a906ba7f393ebcbc - - -] Security group member updated [u'71359c0c-0d10-4097-b5cb-0192cf7505f2']
2019-07-05 09:39:27.046 30098 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-c5695bf4-d57f-488e-8051-66020bf6d147 0e47933895d7410b8055047da118b337 a15234964f6c4a82a906ba7f393ebcbc - - -] port_update received port_update /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:71
2019-07-05 09:39:27.046 30098 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-c5695bf4-d57f-488e-8051-66020bf6d147 0e47933895d7410b8055047da118b337 a15234964f6c4a82a906ba7f393ebcbc - - -] port_update RPC received for port: 7f0c7b1b-276c-4fbc-92be-5f50fe826049 with MAC fa:16:3e:53:bd:8a and PCI slot 0000:82:11.4 slot port_update /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:93
2019-07-05 09:39:27.641 30098 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Agent rpc_loop - iteration:1398 started daemon_loop /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:374
2019-07-05 09:39:27.641 30098 DEBUG neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-05 09:39:27.647 30098 DEBUG neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show', 'p1p1'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-05 09:39:27.650 30098 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Agent loop found changes! {'current': set([(u'fa:16:3e:19:92:de', '0000:82:11.6'), (u'fa:16:3e:53:bd:8a', '0000:82:11.4')]), 'removed': set([]), 'added': set([(u'fa:16:3e:53:bd:8a', '0000:82:11.4')]), 'updated': set([(u'fa:16:3e:53:bd:8a', u'0000:82:11.4')])} daemon_loop /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:391
2019-07-05 09:39:27.650 30098 INFO neutron.agent.securitygroups_rpc [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Skipping method prepare_devices_filter as firewall is disabled or configured as NoopFirewallDriver.
2019-07-05 09:39:27.650 30098 INFO neutron.agent.securitygroups_rpc [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Skipping method refresh_firewall as firewall is disabled or configured as NoopFirewallDriver.
2019-07-05 09:39:27.946 30098 DEBUG neutron.api.rpc.handlers.securitygroups_rpc [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Security group member updated on remote: [u'71359c0c-0d10-4097-b5cb-0192cf7505f2'] security_groups_member_updated /usr/lib/python2.7/site-packages/neutron/api/rpc/handlers/securitygroups_rpc.py:198
2019-07-05 09:39:27.946 30098 INFO neutron.agent.securitygroups_rpc [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Security group member updated [u'71359c0c-0d10-4097-b5cb-0192cf7505f2']
2019-07-05 09:39:27.948 30098 DEBUG neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Port with MAC address fa:16:3e:53:bd:8a is added treat_devices_added_updated /usr/lib/python2.7/site-packages/neutron/plugins/ml2/drivers/mech_sriov/agent/sriov_nic_agent.py:295
2019-07-05 09:39:27.948 30098 INFO neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Port fa:16:3e:53:bd:8a updated. Details: {u'profile': {u'pci_slot': u'0000:82:11.4', u'physical_network': u'physnet1', u'pci_vendor_info': u'8086:10ed'}, u'network_qos_policy_id': None, u'qos_policy_id': None, u'allowed_address_pairs': [], u'admin_state_up': True, u'network_id': u'4361624e-5ddf-43a6-8cb7-3d9929c39386', u'segmentation_id': 69, u'mtu': 1500, u'device_owner': u'compute:nova', u'physical_network': u'physnet1', u'mac_address': u'fa:16:3e:53:bd:8a', u'device': u'fa:16:3e:53:bd:8a', u'port_security_enabled': True, u'port_id': u'7f0c7b1b-276c-4fbc-92be-5f50fe826049', u'fixed_ips': [{u'subnet_id': u'f705e325-2316-49a5-a0ee-bcdc6e4fc34a', u'ip_address': u'172.16.32.8'}], u'network_type': u'vlan'}
2019-07-05 09:39:27.948 30098 DEBUG neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-05 09:39:27.953 30098 DEBUG neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show', 'p1p1'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-05 09:39:27.956 30098 DEBUG neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-05 09:39:27.960 30098 DEBUG neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show', 'p1p1'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-05 09:39:27.963 30098 DEBUG neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'set', 'p1p1', 'vf', '6', 'spoofchk', 'on'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-05 09:39:27.966 30098 INFO neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Device fa:16:3e:53:bd:8a spoofcheck True
2019-07-05 09:39:27.966 30098 DEBUG neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-05 09:39:27.970 30098 DEBUG neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'show', 'p1p1'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-05 09:39:27.973 30098 DEBUG neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Running command (rootwrap daemon): ['ip', 'link', 'set', 'p1p1', 'vf', '6', 'state', 'enable'] execute_rootwrap_daemon /usr/lib/python2.7/site-packages/neutron/agent/linux/utils.py:108
2019-07-05 09:39:27.976 30098 ERROR neutron.agent.linux.utils [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Exit code: 2; Stdin: ; Stdout: ; Stderr: RTNETLINK answers: Operation not supported

2019-07-05 09:39:27.976 30098 WARNING neutron.plugins.ml2.drivers.mech_sriov.agent.sriov_nic_agent [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Device fa:16:3e:53:bd:8a does not support state change: IpCommandOperationNotSupportedError: Operation not supported on device p1p1
2019-07-05 09:39:28.156 30098 DEBUG neutron.api.rpc.handlers.securitygroups_rpc [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Security group member updated on remote: [u'71359c0c-0d10-4097-b5cb-0192cf7505f2'] security_groups_member_updated /usr/lib/python2.7/site-packages/neutron/api/rpc/handlers/securitygroups_rpc.py:198
2019-07-05 09:39:28.156 30098 INFO neutron.agent.securitygroups_rpc [req-aa510836-5afa-40b8-b4bf-779ee2276df2 - - - - -] Security group member updated [u'71359c0c-0d10-4097-b5cb-0192cf7505f2']
