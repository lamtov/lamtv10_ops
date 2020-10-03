Migration.js

Check kvm qemu version:
	kvm --version

	libvirtd 




Edit migrate
			- /etc/default/libvirtd (set -l de lang nghe)

			- /etc/libvirt/libvirtd.conf.

														listen_tls = 0

														listen_tcp = 1

			- /etc/libvort/qemu.conf
			- /etc/nova/nova.conf 


 ./jdk1.8.0_171/bin/java  -cp "./lib/*.jar:AkkaServer.jar"   -Dhost=172.16.30.170 -Dtps=10000 -Dport=9000 -DnumberThread=8 -DpoolSize=20 -DmsgSize=2000 akkaClient.SendHttpHighLevel

 ./jdk1.8.0_171/bin/java -cp "./lib/*.jar:AkkaServer.jar" -Dport=9000 -DmsgSize=2000 serverakka.HighLevelAkka

WARNING nova.compute.manager [req-250fb3fd-5ec2-4a4d-96c7-69fd9f4ab517 b7b6e6d00a77423c8b9627305edcd3e7 738eefc285c846dd86504d0c09bb55de - default default] [instance: b54f2810-fd42-44ae-89d6-343a7030e2f3] Received unexpected event network-vif-plugged-4df35fff-5674-42d8-921c-028b1a91874f for instance
2018-11-13 13:59:12.653 134780 ERROR nova.virt.libvirt.driver [req-e2a6270f-a772-4c51-916d-8e6e735c089f b7b6e6d00a77423c8b9627305edcd3e7 738eefc285c846dd86504d0c09bb55de - default default] [instance: b54f2810-fd42-44ae-89d6-343a7030e2f3] Live Migration failure: internal error: unable to execute QEMU command 'migrate-set-capabilities': Postcopy is not supported: libvirtError: internal error: unable to execute QEMU command 'migrate-set-capabilities': Postcopy is not supported
2018-11-13 13:59:13.021 134780 ERROR nova.virt.libvirt.driver [req-e2a6270f-a772-4c51-916d-8e6e735c089f b7b6e6d00a77423c8b9627305edcd3e7 738eefc285c846dd86504d0c09bb55de - default default] [instance: b54f2810-fd42-44ae-89d6-343a7030e2f3] Migration operation has aborted
2018-11-13 13:59:14.152 134780 WARNING nova.compute.manager [req-ed530b4d-dc61-4de0-870a-ac69f4fba8b9 b7b6e6d00a77423c8b9627305edcd3e7 738eefc285c846dd86504d0c09bb55de - default default] [instance: b54f2810-fd42-44ae-89d6-343a7030e2f3] Received unexpected event network-vif-plugged-4df35fff-5674-42d8-921c-028b1a91874f for instance
2018-11-13 13:59:15.172 134780 WARNING nova.compute.manager [req-907e5390-c07e-4e71-978a-d14461014ae4 b7b6e6d00a77423c8b9627305edcd3e7 


		- Nguyen nhan 1 chua set cho 
		- Nguyen nhan 2 quemu version 2.10 ko tuong thich voi phien ban nova hien tai

		- 	$ virsh --version=long # more details
			Virsh command line tool of libvirt 0.9.10
			See web site at http://libvirt.org/

			Compiled with support for:
			 Hypervisors: Xen QEmu/KVM UML OpenVZ VirtualBox LXC ESX PHYP Test
			 Networking: Remote Daemon Network BridPoging Netcf Nwfilter VirtualPort
			 Storage: Dir Disk Filesystem SCSI Multipath iSCSI LVM
			 Miscellaneous: SELinux Secrets Debug DTrace Readline
			$ virsh -c qemu:///system version --daemon # get server details, too
			Compiled against library: libvir 0.9.10
			Using library: libvir 0.9.10
			Using API: QEMU 0.9.10
			Running hypervisor: QEMU 1.0.0
			Running against daemon: 0.9.9




			virsh qemu-monitor-command instance-0000053c --hmp "migrate_set_capability postcopy-ram off"


 			virsh migrate --live instance-0000053c qemu+ssh://compute02/system







Cấu hình Live Migration cho KVM và QEMU
- live_migration_completion_timeout // Abort migration khi nó chạy quá lâu (mặc định 800)
- live_migration_progress_timeout // Abort khi memory copy không thực hiện 
- live_migration_downtime: max permitted downtime cho một live-migration
- nova server-migration-list idserver //Lay thong tin id migration 
- nova migration-list //Lay thogn tin tat ca cac migration

- nova live-migration-abort instance_id migration_id 
		//tat huy bo live-migration
		
- nova live-migration-force-complete instance_id migration_id 
		//pause instance lai den khi live-migration xong ==> loi dong bo thoi gian do instance bi pause 
		
- live_migration_permit_auto_converge=true: Slowing down instance 
- live_migration_permit_post_copy=true : Cho hoat dongj luon o dau ben kia thay vi doi mem chuyen het sang 

Manually force-complete the migration

$ nova live-migration-force-complete INSTANCE_ID MIGRATION_ID
The instance is paused until memory copy completes.

Caution

Since the pause impacts time keeping on the instance and not all applications tolerate incorrect time settings, use this approach with caution


live_migration_permit_post_copy=true
			-- Truong hop chua bat server 16509 
					0
														down vote
														Use config file /etc/default/libvirtd and enable -l
														#options passed to libvirtd, add "-l" to listen on tcp

														libvirtd_opts=" -l "

														Modify /etc/libvirt/libvirtd.conf.

														listen_tls = 0

														listen_tcp = 1

														Restart Libvirtd Libvirt is listening on port 16509

														$ netstat -lntp | grep libvirtd

														tcp 0 0 0.0.0.0:16509 0.0.0.0:* LISTEN 38482/libvirtd
														tcp6 0 0 :::16509 :::* LISTEN 38482/libvirtd

			-- Truong hop loi do dinh kem volume
			-- Khi live-migration xem log o /var/log/nova/nova-compute.log  de thay mem chuyen dan sang , neu mem chuyen trong thoi gian qua laua thif manual force-complte 
			-- Cai dat Post-Copy Live Migration




+ nova evacuate: KHởi động một single instance đã từng chạy trên một compute node bị sập. Mặc định OpenStack chọn compute nodes sẽ tiếp nhận instance  nhưng một compute node có thể được chọn bằng tay với lệnh --target-host.
				After a compute host has failed, rebuild my instance from the original image in another place, keeping my name, uuid, network addresses, and any other allocated resources that I had before.
		
		**** usage: nova evacuate [--password <password>] [--force] <server> [<host>] 
				Evacuate server from failed host.

					
		+ nova host-evacuate: Restart tất cả instances đã chạy trên một computenode đã bị sập
			Trong cả 2 trường hợp evacuation fails nếu compute node đang bật
	---------------------- Commands operate trên một running compute nodes:
		+ nova host-evacuate-live: Live migrate tất cả instances chạy trên một compute node tới một compute node khác. 
		+ nova host-servers-migrate Migrates stopped instance từ một compute node 
		+ nova live-migration: Live migrate một single instance trên một compute node. Chuyển instace từ một host tới một host khác mà nó không biết. 
		+ 
		+ nova migrate: Migrates stopped instance từ một compute node .
	--------------------- Ví dụ:
			nova evacuate vm_name nova_compute
			nova reboot --hard vm_name 

	=== Tại sao cần chuyển vì các vm trên cùng 1 compute thì sử dụng chung 1 ram, cpu -> chết là chết cả
	 Vì vậy cần chuyển sang cái khác .
		+ nova migrate	Cold Migration	Power off and move // Chỉ dùng được với các VM không có group affinity vì nếu có thì nó phải xét mặc định trong một host-> ko đổi đc 
		+ nova resize	Cold Migration (with resize)	Power off, move, resize
		+ nova live-migration	Live Migration	Move while running
				// Không thể live-migrate mà không có shared storage 
				// Không thể live-migrate nếu có một configdrive enabled
				// Không thể chọn target host nếu sử dụng nova migrate (non-live) command-line
		+ nova evacuate	Evacuation	Rebuild somewhere els
				// Đảm bảo VM với cùng tên không tồn tại
				// Xác minh shared storage 
				// KHi failed node online trở lại, self cleanup được thực thi trong compute.init (cleanup stale instances trong virt và network) đảm bảo recovered node nhận ra được evacuate VM và không khởi động lại  nó nữa. 



	==== Client Commands:
		COMMAND                                                 OPERATION                                                  MEANING
		+ nova migrate                                			Cold Migration                                             Power off and move
		+ nova resize 											Cold Migration (with resize)                               Power off, move  and resize 
		+ nova live-migration                                   Live Migration                                             Move while running 
		+ nova evacuate                                         Evacuation                                                 Rebuild somewhere else 




virsh dumpxml instance--0000053c

-- Su dung virsh edit instance--0000053c 
Tao mot instance ben phia des giong voi instance ben phia source 
Su dung  virsh migrate --live instance-0000053c qemu+ssh://compute03/system

 	+ Loi so 1: console.log No such file or directory: Nguyen nhan ko su dung share storage ===> Tao co che tuong tu share storage bang cach tao 1 may ao ben des 
 			-- Su dung 				--verbose: display the progress of migration
 	+ Loi so 2: Su dung post copy: unable to execute command
 			-- Nguyen nhan do xung dot giua co che postcopy va co che Hugepage
 	+ Loi so 3: KHi chuyen sang bi do, tat may ao ben des bang kill -9 
 	+ Khi su dung virsh thi dung qemu+ssh, khi su dung nova dung qemu+tcp de tranh truong hop dang nhap qua ssh
 	+ Postcopy bi loi dung virsh qemu-monitor-command instance-0000053c --hmp "migrate_set_capability postcopy-ram on"

							virsh qemu-monitor-command instance-0000053c --hmp "info migrate_capabilities"

						https://bugzilla.redhat.com/show_bug.cgi?id=1373604 BUG  live migration post-copy not support file-backed memory (e.g. 2M hugepages)



Pre-copy memory migration:
	+ Warm-up phase:
			Trong co che pre-copy memory migration, Hypervisor co ban copy tat ca memory pages tu source toi des trong khi VM van chay, neu mot so memory page thay doi trong qua trinh
			nay thi se re-copied cho den khi re-copied pages nhieu hon page dirtying rate 
	+ Stop and copy phase:
			VM se stopped tren original host, phan dirty page con lai se duoc copied toi des va VM se dc resumed tai des host. Khoang thoi gian giua stop VM tren original host va resuming VM tren 
			des goi la down-time dua vao kich thuong mem va app chay tren VM.  (co cach giam down-time) nhu su dung probability density function of memory change.



Post-copy memory migration:
	+ Khoi tao bang pause VM, chuyen sub excution state VM (CPU state, register, non-pageable memory) toi target. VM sau do dc resume tai target. Ben canh do phia source  thuc hien push remaining
	 memory page cua VM toi target - mot hoat dong goi la pre-paging.  Tai target, neu VM co truy cap mot page chua dc transferred no se sinh mot page-fault. 



    if CONF.serial_console.enabled:
        serial_ports = list(self._get_serial_ports_from_guest(guest))

    guest.migrate(self._live_migration_uri(dest),
                  migrate_uri=migrate_uri,
                  flags=migration_flags,
                  params=params,
                  domain_xml=new_xml_str,
                  bandwidth=CONF.libvirt.live_migration_bandwidth)


  Chu y khi tao instance can check ram o cac hypervisor va set  METADATA Cho cac FLAVOR: hw:mem_page_size =2MB

			va kiem tra xem co du ram khong bang  grep Hug /proc/meminfo
					root@compute03:~# grep Hug /proc/meminfo
					AnonHugePages:         0 kB
					HugePages_Total:   12288
					HugePages_Free:    10240
					HugePages_Rsvd:        0
					HugePages_Surp:        0
					Hugepagesize:       2048 kB





+--------------------------------------+----------------------------------------------------------+
| Property                             | Value                                                    |
+--------------------------------------+----------------------------------------------------------+
| Mgnt network                         | 172.16.30.168                                            |
| OS-DCF:diskConfig                    | AUTO                                                     |
| OS-EXT-AZ:availability_zone          | nova                                                     |
| OS-EXT-SRV-ATTR:host                 | compute02                                                |
| OS-EXT-SRV-ATTR:hostname             | lamtv                                                    |
| OS-EXT-SRV-ATTR:hypervisor_hostname  | compute02                                                |
| OS-EXT-SRV-ATTR:instance_name        | instance-0000055e                                        |
| OS-EXT-SRV-ATTR:kernel_id            |                                                          |
| OS-EXT-SRV-ATTR:launch_index         | 0                                                        |
| OS-EXT-SRV-ATTR:ramdisk_id           |                                                          |
| OS-EXT-SRV-ATTR:reservation_id       | r-uqiimt7y                                               |
| OS-EXT-SRV-ATTR:root_device_name     | /dev/vda                                                 |
| OS-EXT-SRV-ATTR:user_data            | -                                                        |
| OS-EXT-STS:power_state               | 1                                                        |
| OS-EXT-STS:task_state                | -                                                        |
| OS-EXT-STS:vm_state                  | active                                                   |
| OS-SRV-USG:launched_at               | 2018-11-19T02:08:40.000000                               |
| OS-SRV-USG:terminated_at             | -                                                        |
| accessIPv4                           |                                                          |
| accessIPv6                           |                                                          |
| config_drive                         |                                                          |
| created                              | 2018-11-19T02:07:55Z                                     |
| description                          | lamtv                                                    |
| flavor:disk                          | 30                                                       |
| flavor:ephemeral                     | 0                                                        |
| flavor:extra_specs                   | {"hw:mem_page_size": "2MB"}                              |
| flavor:original_name                 | maHazzad                                                 |
| flavor:ram                           | 8192                                                     |
| flavor:swap                          | 0                                                        |
| flavor:vcpus                         | 8                                                        |
| hostId                               | f22e698580773893d500cb833b08f55d1aad2718732a440d504427c1 |
| host_status                          | UP                                                       |
| id                                   | afcb5d78-0a0c-4586-a765-786902522629                     |
| image                                | cirros (fd1048b0-6832-45e8-9452-0d32f12054f5)            |
| key_name                             | masaka                                                   |
| locked                               | False                                                    |
| metadata                             | {}                                                       |
| name                                 | lamtv                                                    |
| os-extended-volumes:volumes_attached | []                                                       |
| progress                             | 0                                                        |
| security_groups                      | default                                                  |
| status                               | ACTIVE                                                   |
| tags                                 | []                                                       |
| tenant_id                            | 738eefc285c846dd86504d0c09bb55de                         |
| updated                              | 2018-11-19T02:08:41Z                                     |
| user_id                              | 67b2742aa2974a3b8bef3d09588a5f67                         |
+--------------------------------------+----------------------------------------------------------+




b41e94e5-f39e-4ae7-87e6-7a0ee9e51be2
2018-11-19 09:40:24.181 108862 INFO nova.compute.resource_tracker [req-f79dc843-44b9-4b43-8e70-64d4f292e9ef b7b6e6d00a77423c8b9627305edcd3e7 738eefc285c846dd86504d0c09bb55de -
 default default] Instance 79b14ed5-4a2d-422c-932a-25cd5e6bbe99 has allocations against this compute host but is not found in the database.
2018-11-19 09:40:24.262 108862 WARNING nova.compute.resource_tracker [req-f79dc843-44b9-4b43-8e70-64d4f292e9ef b7b6e6d00a77423c8b9627305edcd3e7 738eefc285c846dd86504d0c09bb55de -
 default default] Instance b41e94e5-f39e-4ae7-87e6-7a0ee9e51be2 has been moved to another host compute02(compute02). 
 There are allocations remaining against the source host that might need to be removed: {u'resources': {u'VCPU': 2, u'MEMORY_MB': 2048, u'DISK_GB': 20}}.:
  InstanceNotFound_Remote: Instance 79b14ed5-4a2d-422c-932a-25cd5e6bbe99 could not be found.
Traceback (most recent call last):

  File "/usr/lib/python2.7/dist-packages/nova/conductor/manager.py", line 124, in _object_dispatch
    return getattr(target, method)(*args, **kwargs)

  File "/usr/lib/python2.7/dist-packages/oslo_versionedobjects/base.py", line 184, in wrapper
    result = fn(cls, context, *args, **kwargs)

  File "/usr/lib/python2.7/dist-packages/nova/objects/instance.py", line 467, in get_by_uuid
    use_slave=use_slave)

  File "/usr/lib/python2.7/dist-packages/nova/db/sqlalchemy/api.py", line 235, in wrapper
    return f(*args, **kwargs)

  File "/usr/lib/python2.7/dist-packages/nova/objects/instance.py", line 459, in _db_instance_get_by_uuid
    columns_to_join=columns_to_join)

  File "/usr/lib/python2.7/dist-packages/nova/db/api.py", line 744, in instance_get_by_uuid
    return IMPL.instance_get_by_uuid(context, uuid, columns_to_join)



hw:cpu_policy dedicated
hw:cpu_threads_policy separate
hw:mem_page_size 1GB