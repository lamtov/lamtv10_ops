1. Poll Mode Driver: gom tap cac API cung cap thong qua BSD driver chay trong user space, de cau hinh thiet bi va queues tuong ung. Ben canh do, mot PMD truy cap nhanh vao RX va TX descriptors truc tiep ma khong co mot interrupts (cung voi su ngoai le cua Link Status Change interrupts) de nhanh chong nhan, xu ly va van chuyen package trong user application, 

	- run-to-completion: Chi dinh mot port RX descriptors ring cho package thong qua API, package sau do duoc nhan va su ly tren cung mot core va dat tren cung mot port.
	- pipe-line: Mot core polls mot hoac nhieu port RX descriptors ring thong qua mot API, package sau do nhan va chuyen tiep toi mot core khac qua ring. 

	- Design Principles:
		+ De dat duoc hieu nang tot nhat, hau het software design chon vaf su dung cong nghe toi uu phan mem phai can nhac va  can bang giua cac low-level hardware-based optimization feautures (CPU cache properties, bus speed, NIC PIC bandwidth)

	- Logical cores, Memory va NIC Queues Relationships:
		+ DPDK ho tro NUMA de cho hieu nang tot hon khi mot processor's logical cores va mot interface su dung local memory, 
		+ De tuan theo NUMA, memory management duoc thiet ke de chi dinh moi mot logical core co mot buffer pool rieng trong local memory de giam remote memory access (truy van bo nho o xa). application phai dam bao parameters duoc dua ra tai memory pool creation time.
			- Memory Alignment Constraints:	Dua tren cau hinh hardware memory, hieu nang co the tang len dang ke boi bo xung mot padding cu the giua cac objects. Muc tieu la de dam bao rang bat dau moi object luon tren cac channel khac nhau va danh rank trong memory de dam bao tat ca channel deu loaded equally.
			- Lcal cache:
				Chi phi cua viec nhieu core truy cap vao mot memory poll ring co the cao khi moi truy cap yu cau mot CAS (compare and set). De tranh co qua nhieu access request toi memory pool's ring, 
			- Mempool Handlers:	Cho phep external memory subsystems, nhu viec moi external hardware memory quan ly system va software dua tren memory allocators, de su dung voi DPDK.


		- DEV_TX_OFFLOAD_MT_LOCKFREE 
	- Device Identification, Ownership va Configuration
		+ Device Identification: 
		+ Port Ownership: Ethernet devices ports co the duoc so huu boi mot DPDK entity (app,lib,PMD,process). 
		+ Device Configuration: 
===>
	Ho  tro RX/TX (Receive and  Transmit)
	Noi PCI memory va registers
	Noi user memory (vi du packet memory buffers) vao NIC
	Cau hinh cua specific HW accelerations trong NIC 


2. User space libraries:
	- Khoi tao PMDs
	- Threading (builds on pthread)
	- Quan ly CPU 
	- Quan ly Memory ( chi co Huge pages)
	- Hashing, scheduler, pipeline - high performance support libraries for application

	** So sanh: Vi ly do su dung user space nen bo duoc systemcall giua application va kernel network stack (system call chuyen app vao user mem --> bo)




3. Hugepage
4. vhost-user protocol: cho phep qemu chia se virtqueues voi mot user space process tren cung mot host.
						https://git.qemu.org/?p=qemu.git;a=blob;f=docs/specs/vhost-user.txt;h=7890d7169;hb=HEAD
	Protocol dinh nghia 2 side communication: master and slave: Master la application chia se virtqueues con slave la consumer cua virtqueues do.
	Master va slave co the dong thoi la mot client hoac server
	vhost-user (dpdkvhostuser): Su dung model client-server. Server thuc hien create, manages, destroy Vhost User sockers va client ket noi toi server. Dua tren porttype ban su dung dpdkvhostuser hoac dpdkvhostuserclient, different Configuration cua client-server model duoc su dung.
		- Cho vhost-user ports, Openvswitch lam server, QEMU lam client, co nghia la neu OVS die, tat ca VM phai duoc khoi dong lai.
		$ovs-vsctl add-port br0 vhost-user-1 -- set Interface vhost-user-1 \ type=dpdkvhostuser

		- Cho vhost-user-client ports, OVS hoat dong nhu client con QEMU lam server.
		$ovs-vsctl add-port br0 vhost-client-1 -- set Interface vhost-client-1 type=dpdkvhostuserclient options:vhost-server-path=/path/to/socket




CONFIG _ vhost-user socket
	<cpu mode='host-passthrough' check='none'>
	 <feature policy='require' name='tsc-deadline'/>
	 <numa>
	 <cell id='0' cpus='0-3' memory='8388608' unit='KiB' memAccess='shared'/>
	 </numa>
	</cpu>
	<interface type='vhostuser'>
	 <mac address='88:66:da:5f:dd:02'/>
	 <source type='unix' path='/tmp/vhostuser0.sock' mode='server'/>
	 <model type='virtio'/>
	 <driver name='vhost'/>
	 <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
	</interface>
	# ovs-vsctl add-port ovsbr0 vhost-user0 -- set Interface vhost-user0 type=dpdkvhostuserclient
	options:vhost-server-path=/tmp/vhostuser0.sock

CONFIG _ Hugepage
	# cat /proc/cmdline
	BOOT_IMAGE=/vmlinuz-4.4.0-128-generic root=/dev/mapper/VTTEKOCS1--vg-root ro default_hugepagesz=2M hugepagesz=2M intel_iommu=on iommu=pt isolcpus=2-23,26-47

	# lscpu
	Flags: ... pdpe1g ...
	<memoryBacking>
	<hugepages>
	 <page size='1048576' unit='KiB' nodeset='0'/>
	</hugepages>
	<locked/>
	 </memoryBacking>



CONFIG isolate core:
		In normal kernel environment:
	Install package: tuned-profiles-cpu-partitioning
	Kernel line:
	# cat /proc/cmdline
	BOOT_IMAGE=/vmlinuz-... skew_tick=1
	nohz=on
	nohz_full=1,3,5,7,9,11,13,15,17,19,21,23,25,2
	7,29,31,30,28,26,24,22,20,18,16
	rcu_nocbs=1,3,5,7,9,11,13,15,17,19,21,23,25,
	27,29,31,30,28,26,24,22,20,18,16
	tuned.non_isolcpus=00005555
	intel_pstate=disable nosoftlockup

CONFIG NUMA policy
	 <vcpu placement='static'>4</vcpu>
	 <cputune>
	<vcpupin vcpu='0' cpuset='31'/>
	<vcpupin vcpu='1' cpuset='29'/>
	<vcpupin vcpu='2' cpuset='27'/>
	<vcpupin vcpu='3' cpuset='25'/>
	<emulatorpin cpuset='18,20'/>
	 </cputune>
	 <numatune>
	<memory mode='strict' nodeset='1'/>
	 </numatune>
	How to config? - NUMA policy
	# ovs-vsctl set Open_vSwitch . other_config:pmd-cpu-mask=0xAA (cores 1,3,5,7)

CONFIG -KVM-rt
	 <cputune>
	<vcpupin vcpu='0' cpuset='30'/>
	<vcpupin vcpu='1' cpuset='31'/>
	<emulatorpin cpuset='2,4,6,8,10'/>
	<vcpusched vcpus='0' scheduler='fifo' priority='1'/>
	<vcpusched vcpus='1' scheduler='fifo' priority='1'/>
	 </cputune>
	- Install kernel-rt/kernel-rt-kvm
	- Use tuned-profiles-nfv/tuned-profiles-realtime
	- Set fifo:1 priority 









964  ovs-vsctl show
  965  ovs-vsctl show
  966  ovs-vsctl set Interface p1p1 options:n_rxq=4
  967  ovs-vsctl show
  968  top
  969  ovs-vsctl get Open_vSwitch . other_configs
  970  ovs-vsctl get Open_vSwitch . other_config
  971  top 
  972  ovs-vsctl get Open_vSwitch . other_config
  973  cat /proc/cmdline 
  974  /usr/src/dpdk-stable-17.11.4/usertools/cpu_layout.py 
  975  vim /etc/nova/nova.conf
  976  top 
  977  /usr/src/dpdk-stable-17.11.4/usertools/cpu_layout.py 
  978  python
  979  ovs-vsctl get Open_vSwitch . other_config
  980  ovs-vsctl set Open_vSwitch . other_config:pmd-cpu-mask=0xc00000c
  981  ovs-vsctl get Open_vSwitch . other_config
  982  top
  983  ovs-vsctl get Open_vSwitch . other_config
  984  /etc/init.d/ovs-dpdk stop 
  985  /etc/init.d/ovs-dpdk start
  986  top
  987  ovs-vsctl get Open_vSwitch . other_config
  988  ovs-vsctl show
  989  virsh list --all
  990  virsh edit instance-00000013
  991  ovs-vsctl show
  992  history 
  993  ovs-vsctl get Open_vSwitch . other_config
  994  top
  995  virsh list --all
  996  virsh edit instance-00000017 
  997  systemctl status iptables
  998  systemctl status firewalld
  999  ll
 1000  yum install iperf3



Note

check core de dung vcpu: 

/usr/src/dpdk-stable-17.11.4/usertools/cpu_layout.py 

cores =  [0, 1, 2, 3, 4, 8, 9, 10, 11, 16, 17, 18, 19, 20, 24, 25, 26, 27]
sockets =  [0, 1]

        Socket 0        Socket 1
        --------        --------
Core 0  [0, 36]         [18, 54]
Core 1  [1, 37]         [19, 55]
Core 2  [2, 38]         [20, 56]
Core 3  [3, 39]         [21, 57]
Core 4  [4, 40]         [22, 58]
Core 8  [5, 41]         [23, 59]
Core 9  [6, 42]         [24, 60]
Core 10 [7, 43]         [25, 61]
Core 11 [8, 44]         [26, 62]
Core 16 [9, 45]         [27, 63]
Core 17 [10, 46]        [28, 64]
Core 18 [11, 47]        [29, 65]
Core 19 [12, 48]        [30, 66]
Core 20 [13, 49]        [31, 67]
Core 24 [14, 50]        [32, 68]
Core 25 [15, 51]        [33, 69]
Core 26 [16, 52]        [34, 70]
Core 27 [17, 53]        [35, 71]

vcpu_pin_set = 3-17,39-53,21-35,57-71

