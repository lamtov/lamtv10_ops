KOLLA.sh
http://events17.linuxfoundation.org/sites/events/files/slides/CloudOpen2015.pdf
https://www.google.com/imgres?imgurl=https%3A%2F%2Fi.stack.imgur.com%2FJQHjw.png&imgrefurl=https%3A%2F%2Faskubuntu.com%2Fquestions%2F412574%2Fpxe-boot-server-installation-steps-in-ubuntu-server-vm&tbnid=CKHSi6VLYCIeQM&vet=12ahUKEwjt9ZWFnYXmAhUiGSsKHf39DxkQMygHegUIARDdAQ..i&docid=t9GcHuLE7dkl0M&w=739&h=487&q=pxe%20boot%20linux%20configuration%20step%20by%20step&ved=2ahUKEwjt9ZWFnYXmAhUiGSsKHf39DxkQMygHegUIARDdAQ

1. 
Chuẩn bị trên deployment server:
	Docker, Ansible, Openstack client libraries, NTP installation, "/etc/host" to contain managed nodes, sshpass 
Chuẩn bị trên managed nodes: Docker 

+++ Deployment server để là một file qcow2 cài sẵn tất cả ---> tiết kiệm 1 con server 
+++ Tạo một DockerTool box để chạy các tool, command, .....

+++ Tạo một Docker Ansible thay cho cái trò alias 
docker create --name test1 docker-registry:4000/ssl_keystone_api_ln:q 
docker cp test1:/usr/lib/python2.7/dist-packages/openstackclient /u01/docker/
docker rm test1
docker run -it -v /u01/docker/oepnstackclient:/usr/lib/python2.7/dist-packages/openstackclient docker-registry:4000/ssl_keystone_api_ln:q ls /usr/lib/python2.7/dist-packages/openstackclient 






Tải về Docker Openstack Images.
Tạo Docker Local Registry và load với image đã tải về
Edit file ($/kolla/ansible/inventory) để chỉ ra nodes nào đang sử dụng role nào
Edit "globals.yml" trong /etc/kolla để chỉ định hoặc cấu hình các openstack features sẽ được cài đặt 
Xác minh config files: kolla-ansible prechecks -i $multinode_file 
Bắt đầu deploy: kolla-ansible deploy -i $multinode_file

2. Upgrade: 
kolla-ansible upgrade (mikata -> neutron)

3. Tính năng:
prechecks: ok đảm bảo deployment targets đang trong trạng thái mà Kolla có thể triển khai lên.
	$kolla-ansible prechecks 

- recover: The fastest way during to recover from a deployment failure is to remove the failed deployment:
	$kolla-ansible destroy -i <<inventory-file>>


Operating: 
kolla-ansible -i INVENTORY deploy : deploy and start tất cả Kolla containers
kolla-ansible -i INVENTORY destroy: clean container và volume trong cluster 
kolla-ansible -i INVENTORY mariadb_recovery: recover a completely stopped mariadb cluster
kolla-ansible -i INVENTORY prechecks: check all requirement trước khi deploy mỗi Openstack
kolla-ansible -i INVENTORY post-deploy: post deploy trên deploy node
kolla-ansible -i INVENTORY pull: pull tất cả image cho containers
kolla-ansible -i INVENTORY reconfigure: Config lại Openstack service
kolla-ansible -i INVENTORY upgrade: upgrade Openstack enviroment
kolla-ansible -i INVENTORY check: post-deployment smoke test
kolla-ansible -i INVENTORY stop: stop running container
kolla-ansible -i INVENTORY deploy-containers: Check xem có cần update containers ko.


- Mariadb backup and restore:


- upgrade:
    tools/kolla-ansible -i ${RAW_INVENTORY} -vvv prechecks &> /tmp/logs/ansible/upgrade-prechecks
    tools/kolla-ansible -i ${RAW_INVENTORY} -vvv pull &> /tmp/logs/ansible/pull-upgrade
    tools/kolla-ansible -i ${RAW_INVENTORY} -vvv upgrade &> /tmp/logs/ansible/upgrade
    tools/kolla-ansible -i ${RAW_INVENTORY} -vvv check &> /tmp/logs/ansible/check-upgrade


- Test: 
	+ check-config
	+ check-failure (docker ps -a status = created, restarting, paused, exited, dead)
	+ check-log (Kiểm tra xem trong tất cả log file có tồn tại log error nào ko, nếu có thì báo failing job)
	+ test-ironic: node create, flavor create, node list, port list, openstack server create
	+ test-openstack: 
		compute service list
		network agent list 
		server create || server show 
		volume create || volume show 
		attach volume  || remove volume
		delete server 
		curl $DASHBOARD_URL 
	==> thieu test metadata, test ping , ...
- Test tacker: 
	+  
	+


https://github.com/osic/ref-impl-kolla/tree/master/documents/ease-of-use
https://github.com/osic/ref-impl-kolla/blob/master/documents/ease-of-use/1-osic-create-docker-registry.md
- Part 1: Creating docker registry
install docker
docker run -d -p 4000:5000 --restart=always --name registry registry:2
install redhat registry
	Edit docker config to get insecure-registry 
	/etc/docker/daemon.json:
		{"insecure-registries" : [docker-registry:4000], "graph":"/var/lib/docker"

		===> Verify Docker registry is running.

- Part2: Deploying Openstack Kolla
	2.1 EnvironmentL
		+ Một deployment host =============> Con này nên để dạng qcow2 con này chứa sẵn hết docker-registry, redhat registry
		+ Nine compute host
		+ Three controller/infrastructure hosts
		+ Three monitoring host
		+ Three network host 
		+ Three storage host.

		==> [control] [network] [compute] [monitoring] [storage] storage01 ansible_ssh_host=172.22.0.103 ansible_ssh_host_ironic=10.3.72.179
	2.2 kolla-build --registry localhost:4000 --base ubuntu --type source --tag 3.0.0 --push	
	2.3 Copy config cần thiết cho kolla deployment cp -r /opt/kolla/etc/kolla /etc/
	    GLOBALS_FILE=/etc/kolla/globals.yml

	    --> gen globals_file 
	    Config globals_file:
		sudo sed -i 's/^#kolla_base_distro.*/kolla_base_distro: "ubuntu"/' $GLOBALS_FILE
		sudo sed -i 's/^#kolla_install_type.*/kolla_install_type: "source"/' $GLOBALS_FILE
		registry_host=$(echo "`hostname -I | cut -d ' ' -f 1`:4000")
		sudo sed -i 's/#docker_registry:.*/docker_registry: "'${registry_host}'"/g' $GLOBALS_FILE

		#Enable required OpenStack Services
		sudo sed -i 's/#enable_cinder:.*/enable_cinder: "yes"/' $GLOBALS_FILE
		sudo sed -i 's/#enable_heat:.*/enable_heat: "yes"/' $GLOBALS_FILE
		sudo sed -i 's/#enable_horizon:.*/enable_horizon: "yes"/' $GLOBALS_FILE

		#Enable backend for Cinder and Glance
		sudo sed -i 's/#glance_backend_file:.*/glance_backend_file: "yes"/' $GLOBALS_FILE
		sudo sed -i 's/#cinder_volume_group:.*/cinder_volume_group: "cinder-volumes"/' $GLOBALS_FI

	2.4 Generate password:
		kolla-genpwd
		check: vi /etc/kolla/passwords.yml


	2.5 Bootstrap Servers: 
		- Cấu hình ổ cứng cho cinder, swift
		Sử dụng kết hợp các task ansible và các script.sh nếu có thể
		---
		- name: Prepare node disks
		  hosts: storage
		  remote_user: root
		  tasks:
		    - name: Install xfsprogs package
		      apt:
		        name: xfsprogs
		        state: present
		        update_cache: yes
		    - name: Copy script
		      copy: src=../scripts/kolla-cinder-prep.sh dest=/root/ mode=0777
		    - name: Copy cinder disk file
		      copy: src=../scripts/cinder.lst dest=/root/ mode=0777
		    - name: Execute the script
		      shell: /bin/bash /root/kolla-cinder-prep.sh >> /root/out.cinder
		      ignore_errors: yes

	==> Để dạng switch case nếu cần

	2.6: Deploy Kolla
	--syntax-check Chạy cái này trước để kiểm tra ansible viết đúng hay sai trước khi đưa vào sử dụng.
	--check  Không thực hiện cái gì cả mà thay vào đó kiểm tra xem sẽ có những thay đổi nào sẽ được thực thi
	--inventory Chỉ định rõ inventory  thay vì dùng mặc định
	-e, --extra-vars: Đặt các biến bổ xung như KEY=VALUE hoặc chỉ định file yml
		Ví dụ: ansible-playbook -i ansible/inventory/multinode -e @/etc/kolla/globals.yml -e @/etc/kolla/passwords.yml -e CONFIG_DIR=/etc/kolla  /usr/local/share/kolla/ansible/prechecks.yml --ask-pass
			Lệnh trên chạy một cái playbook precheck.yml 


	Ansible Task: 

	command: 
	register: Sử dụng để bắt  output của một task vào một biến, sau đó có thể sử dụng giá trị của biến này vào các chiến lược khác nhaun như tạo điều kiện, logging...
		Ví dụ kết quả của register:
		"find_output": {
	        "changed": true, 
	        "cmd": "find *.txt", 
	        "delta": "0:00:00.008597", 
	        "end": "2017-09-30 15:07:15.940235", 
	        "rc": 0, 
	        "start": "2017-09-30 15:07:15.931638", 
	        "stderr": "", 
	        "stderr_lines": [], 
	        "stdout": "check.txt\ncheck2.txt", 
	        "stdout_lines": [
	            "check.txt", 
	            "check2.txt"
	        ]
	    }
	when: 
	changed_when và failed_when: Tương tự như ansible when chỉ khác là nó đánh dấu task là failed và Success[changed] khi mà điều kiện được thỏa mãn hoặc ko.
		Mặc định với mỗi task ansible sẽ đánh dấu màu vàng khi changed  nhưng khi chạy command hoặc shell làm sao để nó biết là lúc nào thì hoàn tất hoặc lỗi 
		Ví dụ: 
			shell: "httpd -k start"
			changed_when: "'already running' not in starthttpdout.stdout"
		Lúc này kết quả sẽ trả về màu xanh ok hay nói cách khác là unchanged


	Failed_when: Sử dụng để validate ví dụ validate system meeting recommended System Requirement:
	---
	- hosts: app
	  tasks:
	  - name: Making sure the /tmp has more than 1gb
	    shell: "df -h /tmp|grep -v Filesystem|awk '{print $4}'|cut -d G -f1"
	    register: tmpspace
	    failed_when: "tmpspace.stdout|float < 1"

	  - name: Making sure the /opt has more than 4gb
	    shell: "df -h /opt|grep -v Filesystem|awk '{print $4}'|cut -d G -f1"
	    register: tmpspace
	    failed_when: "tmpspace.stdout|float < 4"

	  - name: Making sure the Physical Memory more than 2gb
	    shell: "cat /proc/meminfo|grep -i memtotal|awk '{print $2/1024/1024}'"
	    register: memory
	    failed_when: "memory.stdout|float < 2"



	debug:
	wait_for: https://docs.ansible.com/ansible/latest/modules/wait_for_module.html Đợi cho đến khi đạt điều kiện thì mới cho chạy tiếp
	set_fact: Cho phép setting một biến mới, biến này sẽ tồn tại cho subsequent plays trong một ansible-playbook run 

- name: Change the working directory to somedir/ and run the command as db_owner if /path/to/database does not exist.
  command: /usr/bin/make_database.sh db_user db_name
  become: yes
  become_user: db_owner
  args:
    chdir: somedir/
    creates: /path/to/database




    gather_fact: xecuting the configured facts modules, the default is to use the setup module.




	------------------------------------
	Dùng file .lst để lưu list 
	Trong file sh chạy như sau: 
	for i in $(cat ilo.csv)
	do
    NAME=`echo $i | cut -d',' -f1`
    IP=`echo $i | cut -d',' -f2`
    TYPE=`echo $i | cut -d',' -f3`
	done

	Dùng file .csv để lưu database sql
	--------------------------------------------

	+ precheck
	+ pull image
	-e action=pull
	+ deploy openstack service  ??? còn tuần tự tính sao
	ansible-playbook -i ansible/inventory/multinode -e @/etc/kolla/globals.yml -e @/etc/kolla/passwords.yml -e CONFIG_DIR=/etc/kolla  -e action=deploy /usr/local/share/kolla/ansible/site.yml --ask-pass

	+ deploy ceph

	+ verify Installation




	2.7 Riêng với BM 

	Ironic Overview:
		Là Openstack bare metal provisioning là một chương trình tích hợp trong Openstack mục đích để cung  cấp bare metal machine thay cho VM, tách ra từ Nova baremetal driver. 
		Nó là pm tốt nhất trong số các bare metal hypervisor API và tập các plugins tương tác với bare metal hypervisors. Mặc định nó sẽ sửu dụng PXE và IPMI để cung cấp và turn on/ off machine.

	--> Thao tác làm việc với BM:

	Đầu tiên cài đặt deployment host và có thể ssh vào nó sử dụng ip.
	Sau đó download pre-packaged LXC container có chứa tool gọi là Cobbler sẽ sử dụng để PXE boot các server còn lại. PXE booting là cơ chế khi một server đơn lẻ (deployment host) có thể được sử dụng để cung cấp cho các server còn lại sử dụng PXE-enabled Network Interface Cards cơ chết boot từ một network host kernel.
	Cobbler overview: 
		Là tool mạnh và dễ sử dụng để nhanh chóng setup network  install environment có tích hợp PXE mechanism.  Cobbler is a Linux based provisioning system which lets you, among other things, configure Network installation for each server from its MAC address, manage DNS and serve DHCP requests, etc.

	Lệnh chạy:
		- Tạo file input.csv 
		- python update_cobbler_system.py input.csv

		cobbler system add --name=hostname --mac=mac --profile=profile --hostname=hostname --interface=interface --ip-address=ip --subnet=255.255.255.0 --gateway=172.22.0.0.1 --name-server=8.8.8.8 --kopts=\"interface="interface quiet=0 console=tty0 console=ttyS0,115200n8\" --server=172.22.0.22

		- cobbler system list
		- cobbler sync
		- begin PXE booting:
		source ~/openrc
		# Reboot individual server 
		nova stop
		nova start 

	Setup Network Interface:
		- generate_ansible_host.py
		- Generate ssh fingerprints của hosts định nghĩa trong multinode inventory và copy chúng vào known_host file. ssh fingerprints sẽ được sử dụng bởi ansible để deploy service vào host.
		--> create-known-hosts.yaml
		- Thực thi playbook này để tạo và cấu hình network interface trên tất cả host:
		create-network-interface.yml
		re-address.sh
		Verify


	BM: https://www.google.com/imgres?imgurl=https%3A%2F%2Fi.stack.imgur.com%2FJQHjw.png&imgrefurl=https%3A%2F%2Faskubuntu.com%2Fquestions%2F412574%2Fpxe-boot-server-installation-steps-in-ubuntu-server-vm&tbnid=CKHSi6VLYCIeQM&vet=12ahUKEwjt9ZWFnYXmAhUiGSsKHf39DxkQMygHegUIARDdAQ..i&docid=t9GcHuLE7dkl0M&w=739&h=487&q=pxe%20boot%20linux%20configuration%20step%20by%20step&ved=2ahUKEwjt9ZWFnYXmAhUiGSsKHf39DxkQMygHegUIARDdAQ
	https://www.tecmint.com/install-pxe-network-boot-server-in-centos-7/
	-- how to install PXE Server trên RHEL/CentOS 



























