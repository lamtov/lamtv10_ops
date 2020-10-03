1. build lai docker neutron
2. 
###############ml2_conf.ini
[DEFAULT]

[ml2]
type_drivers = flat,vlan,vxlan
tenant_network_types = vxlan,vlan,flat
mechanism_drivers = openvswitch,sriovnicswitch
extension_drivers = port_security, qos

[ml2_type_flat]
flat_networks = *

[ml2_type_geneve]

[ml2_type_gre]

[ml2_type_vlan]
#network_vlan_ranges = physnet1:1:100, vlan_net:601:605
network_vlan_ranges = vlan_net:601:605

[ml2_type_vxlan]
vni_ranges = 400:500

[securitygroup]



$lspci -nn | grep Ether

####################ml2_conf_sriov.ini 
[ml2_sriov]
supported_pci_vendor_devs = 8086:10ed, 8086:154d
agent_required = True





644  modprobe igb max_vfs=8
  645  lspci | grep 82599
  646  echo '8' > /sys/class/net/ens2f0/device/sriov_numvfs




in compute01

chown neutron:neutron /var/log/neutron/sriov-nic-agent.log


#create_network_sriov
source ~/open.rc
neutron net-create --provider:physical_network=physnet1 --provider:network_type=flat sriov
neutron net-list
neutron subnet-create sriov --name subnet2  --no-gateway  172.16.32.0/24
# chu y bo gateway di vi neu ko se ko co ip 



# chu y voi loi numa thi can bo xung  nhu sau vao flavor:16384
$ openstack flavor set  10C32R50G --property hw:numa_nodes=2
$ openstack flavor set  10C32R50G --property hw:numa_cpus.0=0,1,2,3,4 --property hw:numa_mem.0=16384
$ openstack flavor set  10C32R50G --property hw:numa_cpus.1=5,6,7,8,9 --property hw:numa_mem.1=16384
https://docs.openstack.org/nova/pike/admin/cpu-topologies.html


# launch_sriov_ins.sh
source ~/open.rc
net_id=`neutron net-show sriov | grep "\ id\ " | awk '{ print $4 }'`
port_id=`neutron port-create $net_id --name sriov_portd --binding:vnic_type direct | grep "\ id\ " | awk '{ print $4 }'`
nova boot --flavor  25C32R55G   --image sn_Avuong --nic port-id=$port_id  --availability-zone nova:compute02  beta_sriov

# chu y binding:vnic_type direct

hw:cpu_policy   dedicated

hw:cpu_threads_policy   separate 
hw:mem_page_size   1GB


openstack server create --image  rhel_sn_lt   --nic net-id=044dd918-e19b-49fa-94c0-10721cfa4497  --nic net-id=9e1273ab-f4b0-4058-acee-bc2ebe814ba5  --key-name demo --flavor 10C32R50G  --availability-zone nova:compute02 --wait ins_dpdk_1_1_2




openstack image create RHEL_ISO_77 --file rhel-server-7.7-x86_64-dvd.iso --disk-format iso --container-format bare

nova interface-attach --port-id $port_id2 beta_sriov


modprobe igb
  873  modprobe ixgbe max_vfs=8




  874  lspci | grep 82599
  875  echo '0' > /sys/class/net/p1p1/device/sriov_numvfs
  876  lspci | grep 82599

systemctl restart openstack-nova-compute.service 
  881  chronyc tracking
  882  systemctl restart chronyd
  883  chronyc tracking
  884  systemctl restart openstack-nova-compute.service 
  890  systemctl status neutron-sriov-nic-agent.service 



nova boot --flavor  10C32R50G  --image rhel_sn_lt  --nic port-id=$port_id   --key-name demo   --availability-zone nova:compute01  alpha_sriov2

nova interface-attach --port-id $port_id2 alpha_sriov2




ping -c 10000 -i 0 172.16.32.22 | tail -3



--------------------------------   ----------------------------------   ----------------------------------
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


echo '8' > /sys/class/net/ens2f0/device/sriov_numvfs
systemctl restart neutron-sriov-nic-agent.service





Restart the neutron-server:

# systemctl restart neutron-server
Update the OpenStack Networking port as follows:

# neutron port-update --no-security-groups  <port-id>
Enable the spookchk control for SR-IOV ports by removing the option to disable the MAC spoofing option:

# neutron port-update <port_id> ---port-security-enabled=False



https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_openstack_platform/7/html/networking_guide/sr-iov-support-for-virtual-networking
978  echo '0' > /sys/class/net/p1p1/device/sriov_numvfs
979  ip link show p1p1
980  modprobe -r igb
981  ethtool -i p1p1
982  modprobe -r igb
983  ethtool -i p1p1
984  modprobe -r ixgbe
985  ethtool -i p1p1
986  modprobe ixgbe max_vfs=7
987  ethtool -i p1p1
988  ip link show p1p1
989  ip link set dev p1p1 vf 6 state enable
990   echo "options ixgbe max_vfs=7" >>/etc/modprobe.d/igb.conf
991   echo 7 > /sys/class/net/p1p1/device/sriov_numvfs
992  chmod +x /etc/rc.d/rc.local
993  cat /etc/rc.d/rc.local 
994   echo "echo 7 > /sys/class/net/p1p2/device/sriov_numvfs" >> /etc/rc.local
995  grubby --update-kernel=ALL --args="intel_iommu=pt ixgbe.max_vfs=7"
996  grubby --update-kernel=ALL --args=" intel_iommu=on    intel_iommu=pt ixgbe.max_vfs=7  "
997  grub2-editenv list
998  grub2-mkconfig -o /boot/grub2/grub.cfg
999  echo "options vfio_iommu_type1 allow_unsafe_interrupts=1" > /etc/modprobe.d/dist.conf
1000  systemctl reboot
1001  ip link show p1p1

openstack network qos rule list qos-policy2

dd if=/dev/zero of=1G.dat bs=1M count=3000
rsync --progress root@172.16.32.9:1G.dat ./



# neutron qos-policy-create qos
#  neutron qos-bandwidth-limit-rule-create bw-limiter-3 --max-kbps 11264


# neutron port-update  088da25f-950f-459c-89b0-091c008ae4af  --no-qos-policy  
  'ip', 'link', 'show', 'p1p1'
  'ip', 'link', 'set', 'p1p1', 'vf', '6', 'spoofchk', 'off'
  'ip', 'link', 'set', 'p1p1', 'vf', '6', 'state', 'enable'
  'ip', 'link', 'set', 'p1p1', 'vf', '6', 'min_tx_rate', '0'
  'ip', 'link', 'set', 'p1p1', 'vf', '6', 'rate', '0'
   ['ip', 'link', 'set', 'p1p1', 'vf', '6', 'rate', '8'] 


# neutron port-update --no-security-groups  83b86c3c-edb2-4cc4-a9ee-d204527e754f
# neutron port-update 83b86c3c-edb2-4cc4-a9ee-d204527e754f  --port-security-enabled=False
# neutron port-update 83b86c3c-edb2-4cc4-a9ee-d204527e754f  --qos-policy  bw-limiter-3




openstack network qos policy create bw-limiter-x
openstack network qos rule create --type bandwidth-limit --max-kbps 30000  --egress bw-limiter-x
neutron qos-bandwidth-limit-rule-create bw-limiter-x --max-kbps 30000 


# ethtool -i  eth1 | grep -i "driver"
driver: ixgbe
#modinfo ixgbe



<interface type='hostdev' managed='yes'>
 <source>
 <address type='pci' domain='0x0000' bus='0x82' slot='0x10' function='0x7' />
 </source>
</interface>

virsh attach-device <instance-name> <xml-file> --live --config
# virsh attach-device  instance-00000039  vf6.xml --live --config
openstack network list 

virsh attach-device instance-0000004a vf6.xml --persistent
scp <instance-keypair-file> ...

# modprobe --first-time bonding
# modinfo bonding
# modprobe bonding mode=1 primary=eth1 max_bonds=1 arp_interval=100 arp_ip_target=<public-gateway> fail_over_mac=1
# ip link set bond0 up
# ifenslave bond0 eth1 eth2
# ip addr add <public-IP/public-subnet-mask> dev bond0
# ip route replace default via <public-gateway>
14.Finally check the bonding status inside the VM by executing the following:
# /usr/bin/cat /proc/net/bonding/bond0


fa:16:3e:9a:28:c2 

52:54:00:9f:b7:e6


echo eth1 > /sys/class/net/bond0/bonding/active_slave
watch cat /proc/net/bonding/bond0


[root@alpha1-sriov cloud-user]# cat  /etc/sysconfig/network-scripts/ifcfg-bond0
DEVICE=bond0
TYPE=Bond
NAME=bond0
BONDING_MASTER=yes
BOOTPROTO=none
ONBOOT=yes
IPADDR=172.16.32.6
NETMASK=255.255.255.0
BONDING_OPTS="mode=1 miimon=200 fail_over_mac=1" ####### Luon chu y cai fail_over_mac nay vi mot so card ko ho tro 
Enable the spookchk control for SR-IOV ports by removing the option to disable the MAC spoofing option:

~                  

[root@alpha1-sriov cloud-user]# cat  /etc/sysconfig/network-scripts/ifcfg-eth0
TYPE=Ethernet
BOOTPROTO=none
DEVICE=eth0
ONBOOT=yes
HWADDR="fa:16:3e:32:08:16"
MASTER=bond0
SLAVE=yes



[root@alpha1-sriov cloud-user]# cat  /etc/sysconfig/network-scripts/ifcfg-eth1
TYPE=Ethernet
BOOTPROTO=none
DEVICE=eth1
ONBOOT=yes
HWADDR="52:54:00:2e:63:04"
MASTER=bond0
SLAVE=yes



sudo setenforce 0
  sestatus



grep -i -r "SSLCertificateFile" /etc/apache2/

openssl req -new -newkey rsa:2048 -nodes -keyout controller.key -out controller.csr









+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

=======================   SRIOV 12/12/2019 =================================

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++





ens1f0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 48:df:37:49:4b:84  txqueuelen 1000  (Ethernet)
        RX packets 15380  bytes 5261008 (5.0 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0



     $lspci -nn | grep Ether

####################ml2_conf_sriov.ini 

 docker run  --name sriov-agent --network=host   --privileged --user neutron -v /u01/docker/docker_log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch:shared -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_SRIOV_AGENT'   docker-registry:4000/neutron_v2:q



[root@compute01 ~]# vim /etc/nova/nova.conf
[root@compute01 ~]# lspci -nn | grep Eth
37:00.0 Ethernet controller [0200]: Intel Corporation 82599 10 Gigabit Dual Port Backplane Connection [8086:10f8] (rev 01)
37:00.1 Ethernet controller [0200]: Intel Corporation 82599 10 Gigabit Dual Port Backplane Connection [8086:10f8] (rev 01)
5c:00.0 Ethernet controller [0200]: Intel Corporation 82599 10 Gigabit Dual Port Backplane Connection [8086:10f8] (rev 01)
5c:00.1 Ethernet controller [0200]: Intel Corporation 82599 10 Gigabit Dual Port Backplane Connection [8086:10f8] (rev 01)
5c:10.0 Ethernet controller [0200]: Intel Corporation 82599 Ethernet Controller Virtual Function [8086:10ed] (rev 01)
5c:10.2 Ethernet controller [0200]: Intel Corporation 82599 Ethernet Controller Virtual Function [8086:10ed] (rev 01)
5c:10.4 Ethernet controller [0200]: Intel Corporation 82599 Ethernet Controller Virtual Function [8086:10ed] (rev 01)
5c:10.6 Ethernet controller [0200]: Intel Corporation 82599 Ethernet Controller Virtual Function [8086:10ed] (rev 01)
5c:11.0 Ethernet controller [0200]: Intel Corporation 82599 Ethernet Controller Virtual Function [8086:10ed] (rev 01)
5c:11.2 Ethernet controller [0200]: Intel Corporation 82599 Ethernet Controller Virtual Function [8086:10ed] (rev 01)
5c:11.4 Ethernet controller [0200]: Intel Corporation 82599 Ethernet Controller Virtual Function [8086:10ed] (rev 01)
5c:11.6 Ethernet controller [0200]: Intel Corporation 82599 Ethernet Controller Virtual Function [8086:10ed] (rev 01)
d8:00.0 Ethernet controller [0200]: Intel Corporation 82599 10 Gigabit Dual Port Backplane Connection [8086:10f8] (rev 01)
d8:00.1 Ethernet controller [0200]: Intel Corporation 82599 10 Gigabit Dual Port Backplane Connection [8086:10f8] (rev 01)




taskset -cp $$


[ml2_sriov]
supported_pci_vendor_devs = 8086:10ed, 8086:154d
agent_required = True
  
echo '8' > /sys/class/net/ens2f0/device/sriov_numvfs
echo '8' > /sys/class/net/ens1f0/device/sriov_numvfs

pci_passthrough_whitelist =[{ "devname": "ens2f0", "physical_network": "physnet1"} , { "devname": "ens1f0", "physical_network": "physnet2"}]


/etc/init.d/ovs-dpdk start
 tail -f /home/var/log/ovs-vswitchd.log

systemctl status openstack-nova-compute 
tail -f /var/log/nova/nova-compute.log 

mkdir /run/netns 

docker  restart ovs-agent dhcp-agent metadata-agent sriov-agent

tail -f /u01/docker/docker_log/neutron/neutron-openvswitch-agent.log 

ovs-ofctl dump-flows br-vlan 


ovs-ofctl dump-flows br-provider

293 ovs-ofctl add-flow br-provider  in_port=eno2,priority=2000,action=pop_vlan,NORMAL
ovs-appctl dpif-netdev/pmd-stats-show




OVS_CORE_MASK=000000000080002
OVS_PMD_CORE_MASK=100006000100006
100004000100004
100006000100006
000000000080002



ovs-vsctl set open_vswitch . other_config:pmd-cpu-mask=100006000100006

source ~/open.rc

net_id=`neutron net-show sriov  | grep "\ id\ " | awk '{ print $4 }'`
port_id=`neutron port-create $net_id --name sriov_port1 --binding:vnic_type direct | grep "\ id\ " | awk '{ print $4 }'`

net_id2=`neutron net-show flat | grep "\ id\ " | awk '{ print $4 }'`
port_id2=`neutron port-create $net_id2 --name flat_port1  | grep "\ id\ " | awk '{ print $4 }'`

nova boot --flavor  4C8R60G    --image sn_Avuong  --nic port-id=$port_id  --nic port-id=$port_id2  --key-name dpkey   --availability-zone nova:compute02  DP2


net_id2=`neutron net-show sriov2  | grep "\ id\ " | awk '{ print $4 }'`
port_id2=`neutron port-create $net_id2 --name sriov_port1 --binding:vnic_type direct | grep "\ id\ " | awk '{ print $4 }'`

nova boot --flavor   4C8R16G --image s  --nic port-id=$port_id  --nic port-id=$port_id2 --key-name demo   --availability-zone nova:compute01 lamtv2022


nova interface-attach --port-id $port_id lamtv20



#############
**** Van de tao VM voi 2 Sriov, vi 2 sriov o tren 2 NUMA khac nhau na kh tao bang flavor co cpupin va cpu chi o 1 ben numa thi cpu nay se khong the dieu khien mang duoc den ca 2 sriov 
Vi vay chi co the tao tren flavor co cau hinh nhu ben duoi:
    hw:cpu_policy   dedicated
    hw:cpu_threads_policy    separate
    hw:mem_page_size  1GB
    hw:numa_cpus.0    0,1,2,3,4 
    hw:numa_cpus.1    5,6,7,8,9  
    hw:numa_mem.0   16384
    hw:numa_mem.1   16384 
    hw:numa_nodes    2

portid1=`neutron port-create sriov --name srioc1 --binding:vnic-type direct  | awk '$2 == "id" {print $(NF-1)}'`
portid2=`neutron port-create sriov2 --name srioc2 --binding:vnic-type direct  | awk '$2 == "id" {print $(NF-1)}'`
openstack server create --flavor 4C8R16G_sriov  --image rhel_sn_lt  --nic port-id=$portid1 --nic port-id=$portid2  --key-name demo --availability-zone nova:compute02 lamtv202



openstack server create --image   sn_Avuong   --nic net-id=044dd918-e19b-49fa-94c0-10721cfa4497  --nic net-id=9e1273ab-f4b0-4058-acee-bc2ebe814ba5  --key-name demo --flavor 25C32R55G   --availability-zone nova:compute02 --wait ins_dpdk_1_1_3



openstack server create --image   centos7  --nic net-id=9e1273ab-f4b0-4058-acee-bc2ebe814ba5   --key-name thuanlk --flavor 4C8R60G   --availability-zone nova:compute02 --wait ins_test



openstack server create --image  sn_Avuong --nic net-id=9e1273ab-f4b0-4058-acee-bc2ebe814ba5  --nic net-id=044dd918-e19b-49fa-94c0-10721cfa4497  --key-name thuanlk --flavor 4C8R60GKHONGDUOCXOA --availability-zone nova:compute01 --wait thuanlk_dpdk1_2

-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAu7imiZLRVayzKmxzjrsDGnPQbDb8fYjPq/3ud++3T/qps27y
uO/FOs2nhKAIoQWmV4vmRy9SmG/8Sk04hvKxLtkMhQQlHdbgwO01qJLtBZn4F1cD
GiWhgYfSmV9v4BwOyboNUSNF+/LvVaubyPdT9xR5npc8VcIxrbE6RfrUHXgDMiuO
z9IRHK0UKPthfVAufmaqvSllR/8RntgH70jzfA0RCKZijOLZMes0KdIldvkDt2Gs
O13ESUy4qU1dfLQUev1se9rRhHvgnc2lBh3XHplLFiOqpklDt278P28Fpt4WqCdD
xQtHzHh24Ok1VQJ1t1sgyN6Zu+mheBSj/O+BYQIDAQABAoIBAQCiqfW9XniAqd6y
0zkrJAgjYtnm+5q82NFDcw2x5gnNhyKH9orjD/my48PWG6p+hVvHntWTN4F10Awp
AlMKNMCuHKxJkvbqrWkiJCqMAYzbfrjI2MA6ZwNVL7Gg718NLqLt0Id7mHorQS58
6PBcK10ZzCc68kf49AaCQQGC5D/rq7YiQT2o/ZQV1gOcrk29uEaEGS/NcW3rohXA
CNXFbbL6w5dlPbvaC7rMiStdF3FqlG/Yknp+sxre0Wtx7kpW8d4QgEdHFqIpiCiU
iZSeb7vpmIU+UQTojLPr6CIlNOx3DqdL4f3qOzIzuN7dxN7+WZshOsedo8OB2lQy
z9ly0F8lAoGBAPIzJILfamMcGqekOoK0VHlMmNIZj+WxVxfSq7hi49ik00U6oAiK
WyLO9G52xEN82Q2tozH65OUbmO6l4iUDGIdFVN7KcmgbShg0vSwOUAE/Z5xHkIKr
rJcX94mpVKWuAlIqLACzBbU8CYtk+/zjrXdgq1qa0VjEzh6C/b9c7fdjAoGBAMZq
2uxtfnr60uz2xuixgYUKEEsZ6Ka3iEiM3/O4kyyEyE3auRgzJ4XzzIUgevC/17lt
2ZC37wfbuXxmJLO6uTkABY2C0s5zWW8YsSbmvEjYQSL+oxTk9lWpmHs7IgtZf6WO
byAWhSmf8v6fLynQQvEQRNVkaBCn2ZwwAx2ccOlrAoGBANJttM8wJVKu3EnC2kMt
QieRcUU5iFhcV/sOwruUz7kum5COevRwoPYBMUW4UpUAJ+VGc3+9KJoV/C18Wpsl
sW31wuM+qV/iNeIKEEHyvXgYCoExfFDLr0wnOp6UTEMWiFWy5kBFSjRIUVKXDoiN
l+0cRESYNkMV2q+Px783kllZAoGAQVvpiX/37eK5oD0aAISYOY67F0INlP1X8y4U
h2ABeuSyZpLp7cLL/h/0+tVcKfnHwdkhlb5BCsGiNAwhguK7KL+NFLRHZKIyj5n+
oOXYl9ZEfpaKedOCIW2gQNeVu09b8NkeWd+RNcjubllZW9iydF37jp9oeDQSRpS6
MgLaXskCgYB0N3+6mTKwLWKBqsRl+GsWQzjAwxOX0FBfdwe00HJwSOpmQ3X8/KHD
wm1CYuxDFVGYbeli84upAhhpTukCKakLAyQS1KqckfWFk/69Pk5ilaWogRE4OZJE
Z47sbBX/B6x/exG3Ov3CV4uGN/1GE8/S5lrE/gr16eWlEG0zMo/uMQ==
-----END RSA PRIVATE KEY-----







net_id2=`neutron net-show flat | grep "\ id\ " | awk '{ print $4 }'`
port_id2=`neutron port-create $net_id2 --name flat_port1  | grep "\ id\ " | awk '{ print $4 }'`
openstack server create --image   centos7  --nic --nic port-id=$port_id2   --key-name thuanlk --flavor 4C8R60G   --availability-zone nova:compute02 --wait ins_test




ens1f0: flags=4419<UP,BROADCAST,RUNNING,PROMISC,MULTICAST>  mtu 1500
        inet 10.10.2.193  netmask 255.255.255.0  broadcast 10.10.2.255
        ether 48:df:37:49:4b:84  txqueuelen 1000  (Ethernet)
        RX packets 872005531750  bytes 53395951559322 (48.5 TiB)
        RX errors 0  dropped 1128511974156  overruns 0  frame 0
        TX packets 19807  bytes 2372356 (2.2 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens1f1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 10.10.3.100  netmask 255.255.255.0  broadcast 10.10.3.255
        ether 48:df:37:49:4b:85  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens2f0: flags=4419<UP,BROADCAST,RUNNING,PROMISC,MULTICAST>  mtu 1500
        inet 10.10.1.193  netmask 255.255.255.0  broadcast 10.10.1.255
        ether 48:df:37:83:14:24  txqueuelen 1000  (Ethernet)
        RX packets 3811505118  bytes 808052658292 (752.5 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 4477  bytes 231903 (226.4 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


    10.10.1.    physnet1:br1 ens2f0 ,   10.10.2 physnet2:br0  ens1f0


ovs-vsctl del-br br-tun 
ovs-vsctl del-br br-int 
ovs-vsctl del-br br-ex 
systemctl stop openvswitch.service 
systemctl stop openvswitch-nonetwork.service 
rm -rf /etc/openvswitch/* /etc/openvswitch/.* 
rmmod openvswitch