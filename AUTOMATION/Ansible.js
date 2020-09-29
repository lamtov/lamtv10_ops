yum -y install ansible

	+ PlayBooks: Plain-text YAML file mô tả trạng thái 
		Modules ---> Tasks ---> Play ---> Playbooks
	+ Files
	+ Inventories: Lists Of Servers: AWS, Azure, GCP
	+ Command line
	+ Discovered variables
	+ Ansible Tower

How To Run:
	+ Ad-Hoc: ansible <Inventory> -m
		ansible web -a /bin/date
		ansible web -m ping 
	+ PlayBooks: ansible-playbook
		ansible-playbook -C my-playbook.yml 

	+ Automation Framework: Ansible Tower

Ví dụ:
----
	name: install and start apache
	hosts: web
	remote_user: justin
	become_method: sudo
	become_user: root 
	vars:
	 http_port: 80
	 max_clients: 200
	tasks:
	- name: install httpd 
	  yum: name=httpd state=latest
	- name: write apache config file 
	  template: src=srv/httpd.j2 dest=/etc/httpd.conf 
	  notify:
	  - restart apache 
	- name: start httpd
	  service: name=httpd state=running 

	handlers:
	- name: restart apache 
	  service: name=httpd state=restarted


Tutorial:
	Với 1 control machine và 1 target machine, để bắt đầu cài đặt thực hiện:
a. useradd ansible
   passwd ansible
b. Sửa /etc/ssh/sshd_config trên control machine và bỏ comment cho 
	PasswordAuthentication		yes
	PermitRootLogin				yes 

	systemctl restart sshd 
c.  Enable Passwordless authentication:
	+ Thêm user ansible vào /etc/sudoers trên cả 2 máy để đảm bảo user ansible có thể chạy mọi command yêu cầu quyền root 
		ansible 		ALL=(ALL)			NOPASSWD: ALL 
	+ Trên tất cả các máy chọn
		ssh-keygen
		ssh-copy-id root@172.16.30.85
		ssh root@172.16.30.85
	Sau bước này sẽ không cần password khi muốn ssh vào một máy.
d. Cài wget, rp,
	$ sudo yum install wget -y
	$ wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
	$ sudo rpm -ivh epel-release-latest-7.noarch.rpm
	$ sudo yum install ansible -y 
	$ ansible --version 


e. Chỉnh sửa ansible.cfg 
	$ sudo vim /etc/ansible/ansible.cfg 
	$ vim /etc/ansible/hosts: nội dung inventory gồm tập các group cho việc phân loại bên dưới group. 
		[webservers]
		172.16.30.85 

		*** Khi có sshkey 
			[api]
			192.168.106.175 ansible_ssh_user=tuanda  ansible_ssh_private_key_file=/etc/ansible/key_ssh_server/id_rsa
			Chạy:
			$$ ansible -i hosts api -m shell -a "whoami"
			192.168.106.175 | SUCCESS | rc=0 >>
			tuanda

	Để kiểm tra kết nối của các server bên dưới webservers group chạy ansible ping
	$ ansible webservers -m ping 
	$ ansible webservers --list-hosts

f. Các thành phần:
	- Control Machine: máy chạy ansible
	- Inventory: Thông tin các máy host để cài đặt 
	- Playbook: Tập các bước cài đặt 
				Ansible thiết lập cấu hình máy theo một vở diễn, các tác vụ trong mỗi vở mô tả trạng thái ta muốn có trong mỗi máy chứ ko phải chỉ là các lện cần chạy. 
				Các tác vụ liên quan đến nhau có thể được tập hợp lại thành một vai trò (role), sau đó áp dụng cho một nhóm các máy khi cần thiết. 

g. Ansible modules:
		ansible webservers -m setup 

	Lệnh cơ bản:
		-i: Load thư viện host 
		-m: gọi module của ansible 
		-a: command được gửi vào module 
		-u: user 
		-vvvv debug option

	Module cơ bản:
		- Module yum: Để cài đặt gói tin http 
		- Module service: Để chạy lệnh service start 
		- Module command: Để chạy lệnh trên client 
		- Moudle Template: Copy file từ ansible server tới client .

	Có thể viết module cho từng gói cài đặt hoặc nhóm vào item để chạy 1 lần luôn:
		- items
		- handlers
		Handler: là danh sách một hoặc nhiều tác vụ chờ được triệu gọi sử dụng từ task. Một tác vụ handler được khai báo cấu hình y hệt như một task nhưng yêu cầu phải có tên tác vụ rõ rạng
		Notify: Là keyword dùng để triệu gọi một hoặc nhiều handler trong một task.

		---
		- hosts: web 
		  tasks: 
		  - copy: 
		  		src: main.conf
		  		dest: /etc/nginx/nginx.conf 
		  	notify: restart nginx 
		  handler :
		  	- name: restart nginx 
		  	  service: name=nginx state=restarted 
		===> Khi mà task Copy file cấu hình main.conf chạy ko bị lỗi thì task copy sẽ gọi task handler lên bằng key cấu hình notify

		- variables.

===> Ansible Module dùng để chạy một task đơn lẻ nhưng nếu muốn chạy multiple tasks thì cần sử dụng Ansible PlayBooks

h. Ansible Playbooks
	- Playbooks định nghĩa var, config, deployment steps, assign roles, thực hiện multiple tasks.
	- Playbook viết bằng YAML gồm các phần:
		+ Mọi playbook bắt đầu với '-'
		+ Host section: Định nghĩa máy đích playbook sẽ chạy, dựa trên Ansible inventory
		+ variable section: Tuyên bố toàn bộ biến sẽ dùng trong Ansible (Password dùng trong Openstack)
		+ Tasks section: List ra tất cả task sẽ được chạy trên máy đích.

Ví dụ:
--- Playbook start
- hosts: webservers Specify the group or servers as per inventory to execute tasks
  become: true
  tasks:
  - name: Copy Tomcat ZIP file to install location Short description of the task
    copy: src=/home/ansible/niranjan/apache-tomcat-8.5.31.tar.gz dest=/opt/niranjan/tomcat

   		$ansible-playbook playbook.yml 


 Ví dụ: Tạo 1 file hoặc 1 thư mục:
 - hosts: webservers
  become: true
  tasks:
  - name: Create a file
    file: path=/home/ansible/niranjan.txt state=touch
or: file: path=/home/ansible/niranjan state=directory mode=775 owner=ansible group=ansible
//
  - name: Create User
    user: name=niranjan password=niranjan groups=ansible shell=/bin/bash
  - name: Copy content to file
    copy: content="Hello World Niranjan \n" dest=/home/ansible/niranjan.txt
  
  - name: Replace example
    replace:
     path: /home/ansible/niranjan.txt
     regexp: 'hello'
     replace: "world"
  - name: Install Package
    yum: name=httpd state=present
  - name: Start httpd service
    service: name=httpd state=started

 Ví dụ 2: Sử dụng variable và command 
 ---
 - hosts: webservers 
   become: true
   vars:
  	 download_url: http://xxx
  tasks:
  - name: Download file 
  	command: "wget --no-check-certificate --no-cookies --header 'Cookie: oraclelicense=accept-securebackup-cookie' {{download_url}} "
  - name: Install JDK 8
  	command: "rpm -ivh jdk-8u171-linux-x64.rpm"
  - name: Source profile
    shell: source /etc/profile.d/maven.sh 

****************************************************************************************************************************************
************************============  ANSIBLE AUTO OPS ===========================******************************************************


Để làm việc với Dynamic inventory thì cần sử dụng một file host.py 
KHi chạy sẽ chạy như sau:
ansible -i host.py all -m ping 
--> Viết  1 đoạn py thực hiện check vào mysql các kiểu xong xuất ra file cùng tên
Khi chạy thì python sẽ chek hộ, xuất file và gọi



Playbook được làm như sau:
	- Mọi pre_tasks được định nghĩa trong play
	- Mọi handlers triggers 
	- Mỗi role liệt kê trong roles sẽ được thực hiện theo turn. 
	- Mọi tasks định nghĩa trong play
	- Mọi handlers triggered sẽ run
	- Mọi post_tasks định nghĩa trong play


Ansible rolling update cho phép chạy từng host 1 


- delegate_to: host ||| và local_action: sdf

- run_one: Chỉ chạy task này 1 lần trên toàn bộ batch of hosts 
ví dụ chỉ định command sau chỉ chạy trên một host :
	- command: /opt/application/upgrade_db.py
			run_once: true
			delegate_to: web01.example.org

****++ Ví dụ chỉ chạy lệnh cài đặt bên dưới nếu os=RedHat hoặc Debian:
			---
			- hosts: webserver
			remote_user: ansible
			tasks:
			- name: Print the ansible_os_family value
			debug:
			msg: '{{ ansible_os_family }}'
			- name: Ensure the httpd package is updated
			yum:
			name: httpd
			state: latest
			become: True
			when: ansible_os_family == 'RedHat'
			- name: Ensure the apache2 package is updated
			apt:
			name: apache2
			state: latest
			become: True
			when: ansible_os_family == 'Debian'
*** Working with Includes:
**** Working with notify: Notify hay hơn bình thường  ở chỗ nếu ko có thay đổi như khi copy file hay install thì mới thay đổi.


*** Với with_sequence để tạo vòng for


+++ Check variable is set:
---
- hosts: all
remote_user: ansible
vars:
backup: True
tasks:
- name: Check if the backup_folder is set
fail:
msg: 'The backup_folder needs to be set'
when: backup_folder is not defined




RUn ansible with special inventory: ansible-playbook -i localhost playbooks/do_provision.yaml

Chapter 7. Creating a Custom Module


Mục tiêu để tạo các module như test, validate, prepare vv..

Để tạo custom modules cần làm những bước sau:
	+ Chỉ định path tới custom module trong biến môi trường ANSIBLE_LIBRARY
	+ Sử dụng --module-path command-line option
	+ Đặt module vào dir library trong Ansible 



https://blog.oddbit.com/post/2017-08-02-ansible-for-infrastructure-testing/
ansible-assertive project:
-	 assert action plugin sẽ thay thế Ansible native assert hoạt động với một số appropriate cho infrastructure testing
- 	 assertive callback plguin chỉnh sửa output của assert tasks và tập hợp, báo cáo lại kết quả

		Ý tưởng là bạn viết tất cả test sử dụng assert plugin để thay vì mỗi lần chạy test chỉ test  được một lỗi và trả về luôn ta có thể chạy một lần đếm được tất cả các lỗi và return luôn 
		PLAY [localhost] ***************************************************************

		TASK [Gathering Facts] *********************************************************
		ok: [localhost]

		TASK [assert] ******************************************************************
		failed: [localhost]  ASSERT('apples' in fruits)
		failed: you have no apples

		TASK [assert] ******************************************************************
		passed: [localhost]  ASSERT('lemons' in fruits)

		PLAY RECAP *********************************************************************
		localhost                  : ok=3    changed=1    unreachable=0    failed=0


	


- sử dụng -t tag và tag để chỉ chạy 1 phần playbook hoặc --skip-tags để bỏ qua một số phần

		- hosts: localhost
		tasks:
		- name: Ensure the file /tmp/ok exists
		file:
		name: /tmp/ok
		state: touch
		tags:
		- file_present
		- name: Ensure the file /tmp/ok does not exists
		file:
		name: /tmp/ok
		state: absent
		tags:
		- file_absent




- Sử dụng when java|failed kết hợp với register: java để áp dụng cho bài toán check và chạy



















*************************************************************************************************

---
- import_playbook: gather-facts.yml

# NOTE(mgoddard): In large environments, even tasks that are skipped can take a
# significant amount of time. This is an optimisation to prevent any tasks
# running in the subsequent plays for services that are disabled.
- name: Group hosts based on configuration
  hosts: all
  gather_facts: false
  tasks:
    - name: Group hosts based on OpenStack release
      group_by:
        key: "openstack_release_{{ openstack_release }}"

    - name: Group hosts based on Kolla action
      group_by:
        key: "kolla_action_{{ kolla_action }}"

    - name: Group hosts based on enabled services
      group_by:
        key: "{{ item }}"
      with_items:
        - enable_aodh_{{ enable_aodh | bool }}
        - enable_barbican_{{ enable_barbican | bool }}
        - enable_blazar_{{ enable_blazar | bool }}
        - enable_ceilometer_{{ enable_ceilometer | bool }}
        - enable_ceph_{{ enable_ceph | bool }}
        - enable_chrony_{{ enable_chrony | bool }}
        - enable_cinder_{{ enable_cinder | bool }}
        - enable_cloudkitty_{{ enable_cloudkitty | bool }}
        - enable_collectd_{{ enable_collectd | bool }}
        - enable_congress_{{ enable_congress | bool }}
        - enable_cyborg_{{ enable_cyborg | bool }}
        - enable_designate_{{ enable_designate | bool }}
        - enable_elasticsearch_{{ enable_elasticsearch | bool }}
        - enable_etcd_{{ enable_etcd | bool }}
        - enable_freezer_{{ enable_freezer | bool }}
        - enable_glance_{{ enable_glance | bool }}
        - enable_gnocchi_{{ enable_gnocchi | bool }}
        - enable_grafana_{{ enable_grafana | bool }}
        - enable_haproxy_{{ enable_haproxy | bool }}
        - enable_heat_{{ enable_heat | bool }}
        - enable_horizon_{{ enable_horizon | bool }}
        - enable_hyperv_{{ enable_hyperv | bool }}
        - enable_influxdb_{{ enable_influxdb | bool }}
        - enable_ironic_{{ enable_ironic | bool }}
        - enable_iscsid_{{ enable_iscsid | bool }}
        - enable_kafka_{{ enable_kafka | bool }}
        - enable_karbor_{{ enable_karbor | bool }}
        - enable_keystone_{{ enable_keystone | bool }}
        - enable_kibana_{{ enable_kibana | bool }}
        - enable_kuryr_{{ enable_kuryr | bool }}
        - enable_magnum_{{ enable_magnum | bool }}
        - enable_manila_{{ enable_manila | bool }}
        - enable_mariadb_{{ enable_mariadb | bool }}
        - enable_memcached_{{ enable_memcached | bool }}
        - enable_mistral_{{ enable_mistral | bool }}
        - enable_monasca_{{ enable_monasca | bool }}
        - enable_mongodb_{{ enable_mongodb | bool }}
        - enable_multipathd_{{ enable_multipathd | bool }}
        - enable_murano_{{ enable_murano | bool }}
        - enable_neutron_{{ enable_neutron | bool }}
        - enable_nova_{{ enable_nova | bool }}
        - enable_octavia_{{ enable_octavia | bool }}
        - enable_opendaylight_{{ enable_opendaylight | bool }}
        - enable_openvswitch_{{ enable_openvswitch | bool }}_enable_ovs_dpdk_{{ enable_ovs_dpdk | bool }}
        - enable_outward_rabbitmq_{{ enable_outward_rabbitmq | bool }}
        - enable_panko_{{ enable_panko | bool }}
        - enable_placement_{{ enable_placement | bool }}
        - enable_prometheus_{{ enable_prometheus | bool }}
        - enable_qdrouterd_{{ enable_qdrouterd | bool }}
        - enable_rabbitmq_{{ enable_rabbitmq | bool }}
        - enable_rally_{{ enable_rally | bool }}
        - enable_redis_{{ enable_redis | bool }}
        - enable_sahara_{{ enable_sahara | bool }}
        - enable_searchlight_{{ enable_searchlight | bool }}
        - enable_senlin_{{ enable_senlin | bool }}
        - enable_skydive_{{ enable_skydive | bool }}
        - enable_solum_{{ enable_solum | bool }}
        - enable_swift_{{ enable_swift | bool }}
        - enable_tacker_{{ enable_tacker | bool }}
        - enable_telegraf_{{ enable_telegraf | bool }}
        - enable_tempest_{{ enable_tempest | bool }}
        - enable_trove_{{ enable_trove | bool }}
        - enable_vitrage_{{ enable_vitrage | bool }}
        - enable_vmtp_{{ enable_vmtp | bool }}
        - enable_watcher_{{ enable_watcher | bool }}
        - enable_zookeeper_{{ enable_zookeeper | bool }}
        - enable_zun_{{ enable_zun | bool }}
  tags: always

- import_playbook: detect-release.yml
  vars:
    detect_release_hosts: openstack_release_auto

- name: Apply role prechecks
  gather_facts: false
  # Apply only when kolla action is 'precheck'.
  hosts: kolla_action_precheck
  roles:
    - role: prechecks

- name: Apply role chrony
  gather_facts: false
  hosts:
    - chrony-server
    - chrony
    - '&enable_chrony_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: chrony,
        tags: chrony,
        when: enable_chrony | bool }

- name: Apply role haproxy
  gather_facts: false
  hosts:
    - haproxy
    - '&enable_haproxy_True'
  roles:
    - { role: haproxy,
        tags: haproxy,
        when: enable_haproxy | bool }
  tasks:
    - block:
        - include_role:
            role: aodh
            tasks_from: loadbalancer
          tags: aodh
          when: enable_aodh | bool
        - include_role:
            role: barbican
            tasks_from: loadbalancer
          tags: barbican
          when: enable_barbican | bool
        - include_role:
            role: blazar
            tasks_from: loadbalancer
          tags: blazar
          when: enable_blazar | bool
        - include_role:
            role: ceph
            tasks_from: loadbalancer
          tags: ceph
          when: enable_ceph | bool
        - include_role:
            role: cinder
            tasks_from: loadbalancer
          tags: cinder
          when: enable_cinder | bool
        - include_role:
            role: cloudkitty
            tasks_from: loadbalancer
          tags: cloudkitty
          when: enable_cloudkitty | bool
        - include_role:
            role: congress
            tasks_from: loadbalancer
          tags: congress
          when: enable_congress | bool
        - include_role:
            role: cyborg
            tasks_from: loadbalancer
          tags: cyborg
          when: enable_cyborg | bool
        - include_role:
            role: designate
            tasks_from: loadbalancer
          tags: designate
          when: enable_designate | bool
        - include_role:
            role: elasticsearch
            tasks_from: loadbalancer
          tags: elasticsearch
          when: enable_elasticsearch | bool
        - include_role:
            role: freezer
            tasks_from: loadbalancer
          tags: freezer
          when: enable_freezer | bool
        - include_role:
            role: glance
            tasks_from: loadbalancer
          tags: glance
          when: enable_glance | bool
        - include_role:
            role: gnocchi
            tasks_from: loadbalancer
          tags: gnocchi
          when: enable_gnocchi | bool
        - include_role:
            role: grafana
            tasks_from: loadbalancer
          tags: grafana
          when: enable_grafana | bool
        - include_role:
            role: heat
            tasks_from: loadbalancer
          tags: heat
          when: enable_heat | bool
        - include_role:
            role: horizon
            tasks_from: loadbalancer
          tags: horizon
          when: enable_horizon | bool
        - include_role:
            role: influxdb
            tasks_from: loadbalancer
          tags: influxdb
          when: enable_influxdb | bool
        - include_role:
            role: ironic
            tasks_from: loadbalancer
          tags: ironic
          when: enable_ironic | bool
        - include_role:
            role: karbor
            tasks_from: loadbalancer
          tags: karbor
          when: enable_karbor | bool
        - include_role:
            role: keystone
            tasks_from: loadbalancer
          tags: keystone
          when: enable_keystone | bool
        - include_role:
            role: kibana
            tasks_from: loadbalancer
          tags: kibana
          when: enable_kibana | bool
        - include_role:
            role: magnum
            tasks_from: loadbalancer
          tags: magnum
          when: enable_magnum | bool
        - include_role:
            role: manila
            tasks_from: loadbalancer
          tags: manila
          when: enable_manila | bool
        - include_role:
            role: mariadb
            tasks_from: loadbalancer
          tags: mariadb
          when: enable_mariadb | bool
        - include_role:
            role: memcached
            tasks_from: loadbalancer
          tags: memcached
          when: enable_memcached | bool
        - include_role:
            role: mistral
            tasks_from: loadbalancer
          tags: mistral
          when: enable_mistral | bool
        - include_role:
            role: monasca
            tasks_from: loadbalancer
          tags: monasca
          when: enable_monasca | bool
        - include_role:
            role: mongodb
            tasks_from: loadbalancer
          tags: mongodb
          when: enable_mongodb | bool
        - include_role:
            role: murano
            tasks_from: loadbalancer
          tags: murano
          when: enable_murano | bool
        - include_role:
            role: neutron
            tasks_from: loadbalancer
          tags: neutron
          when: enable_neutron | bool
        - include_role:
            role: placement
            tasks_from: loadbalancer
          tags: placement
        - include_role:
            role: nova
            tasks_from: loadbalancer
          tags: nova
          when: enable_nova | bool
        - include_role:
            role: octavia
            tasks_from: loadbalancer
          tags: octavia
          when: enable_octavia | bool
        - include_role:
            role: opendaylight
            tasks_from: loadbalancer
          tags: opendaylight
          when: enable_opendaylight | bool
        - include_role:
            role: panko
            tasks_from: loadbalancer
          tags: panko
          when: enable_panko | bool
        - include_role:
            role: prometheus
            tasks_from: loadbalancer
          tags: prometheus
          when: enable_prometheus | bool
        - include_role:
            role: rabbitmq
            tasks_from: loadbalancer
          tags: rabbitmq
          vars:
            role_rabbitmq_cluster_cookie:
            role_rabbitmq_groups:
          when: enable_rabbitmq | bool or enable_outward_rabbitmq | bool
        - include_role:
            role: sahara
            tasks_from: loadbalancer
          tags: sahara
          when: enable_sahara | bool
        - include_role:
            role: searchlight
            tasks_from: loadbalancer
          tags: searchlight
          when: enable_searchlight | bool
        - include_role:
            role: senlin
            tasks_from: loadbalancer
          tags: senlin
          when: enable_senlin | bool
        - include_role:
            role: skydive
            tasks_from: loadbalancer
          tags: skydive
          when: enable_skydive | bool
        - include_role:
            role: solum
            tasks_from: loadbalancer
          tags: solum
          when: enable_solum | bool
        - include_role:
            role: swift
            tasks_from: loadbalancer
          tags: swift
          when: enable_swift | bool
        - include_role:
            role: tacker
            tasks_from: loadbalancer
          tags: tacker
          when: enable_tacker | bool
        - include_role:
            role: trove
            tasks_from: loadbalancer
          tags: trove
          when: enable_trove | bool
        - include_role:
            role: vitrage
            tasks_from: loadbalancer
          tags: vitrage
          when: enable_vitrage | bool
        - include_role:
            role: watcher
            tasks_from: loadbalancer
          tags: watcher
          when: enable_watcher | bool
        - include_role:
            role: zun
            tasks_from: loadbalancer
          tags: zun
          when: enable_zun | bool
      when:
        - enable_haproxy | bool
        - kolla_action in ['deploy', 'reconfigure', 'upgrade', 'config']

- name: Apply role collectd
  gather_facts: false
  hosts:
    - collectd
    - '&enable_collectd_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: collectd,
        tags: collectd,
        when: enable_collectd | bool }

- name: Apply role zookeeper
  gather_facts: false
  hosts:
    - zookeeper
    - '&enable_zookeeper_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: zookeeper,
        tags: zookeeper,
        when: enable_zookeeper | bool }

- name: Apply role elasticsearch
  gather_facts: false
  hosts:
    - elasticsearch
    - '&enable_elasticsearch_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: elasticsearch,
        tags: elasticsearch,
        when: enable_elasticsearch | bool }

- name: Apply role influxdb
  gather_facts: false
  hosts:
    - influxdb
    - '&enable_influxdb_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: influxdb,
        tags: influxdb,
        when: enable_influxdb | bool }

- name: Apply role telegraf
  gather_facts: false
  hosts:
    - telegraf
    - '&enable_telegraf_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: telegraf,
        tags: telegraf,
        when: enable_telegraf | bool }

- name: Apply role redis
  gather_facts: false
  hosts:
    - redis
    - '&enable_redis_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: redis,
        tags: redis,
        when: enable_redis | bool }

- name: Apply role kibana
  gather_facts: false
  hosts:
    - kibana
    - '&enable_kibana_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: kibana,
        tags: kibana,
        when: enable_kibana | bool }

- name: Apply role mariadb
  gather_facts: false
  hosts:
    - mariadb
    - '&enable_mariadb_True'
  roles:
    - { role: mariadb,
        tags: mariadb,
        when: enable_mariadb | bool }

- name: Apply role memcached
  gather_facts: false
  hosts:
    - memcached
    - '&enable_memcached_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: memcached,
        tags: [memcache, memcached],
        when: enable_memcached | bool }

- name: Apply role prometheus
  gather_facts: false
  hosts:
    - prometheus
    - prometheus-node-exporter
    - prometheus-mysqld-exporter
    - prometheus-haproxy-exporter
    - prometheus-cadvisor
    - prometheus-alertmanager
    - prometheus-openstack-exporter
    - prometheus-elasticsearch-exporter
    - '&enable_prometheus_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: prometheus,
        tags: prometheus,
        when: enable_prometheus | bool }

- name: Apply role iscsi
  gather_facts: false
  hosts:
    - iscsid
    - tgtd
    - '&enable_iscsid_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: iscsi,
        tags: iscsi,
        when: enable_iscsid | bool }

- name: Apply role multipathd
  gather_facts: false
  hosts:
    - multipathd
    - '&enable_multipathd_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: multipathd,
        tags: multipathd,
        when: enable_multipathd | bool }

- name: Apply role rabbitmq
  gather_facts: false
  hosts:
    - rabbitmq
    - '&enable_rabbitmq_True'
  roles:
    - { role: rabbitmq,
        tags: rabbitmq,
        role_rabbitmq_cluster_cookie: '{{ rabbitmq_cluster_cookie }}',
        role_rabbitmq_cluster_port: '{{ rabbitmq_cluster_port }}',
        role_rabbitmq_epmd_port: '{{ rabbitmq_epmd_port }}',
        role_rabbitmq_groups: rabbitmq,
        role_rabbitmq_management_port: '{{ rabbitmq_management_port }}',
        role_rabbitmq_monitoring_password: '{{ rabbitmq_monitoring_password }}',
        role_rabbitmq_monitoring_user: '{{ rabbitmq_monitoring_user }}',
        role_rabbitmq_password: '{{ rabbitmq_password }}',
        role_rabbitmq_port: '{{ rabbitmq_port }}',
        role_rabbitmq_user: '{{ rabbitmq_user }}',
        when: enable_rabbitmq | bool }

- name: Apply role rabbitmq (outward)
  gather_facts: false
  hosts:
    - outward-rabbitmq
    - '&enable_outward_rabbitmq_True'
  roles:
    - { role: rabbitmq,
        tags: rabbitmq,
        project_name: outward_rabbitmq,
        role_rabbitmq_cluster_cookie: '{{ outward_rabbitmq_cluster_cookie }}',
        role_rabbitmq_cluster_port: '{{ outward_rabbitmq_cluster_port }}',
        role_rabbitmq_epmd_port: '{{ outward_rabbitmq_epmd_port }}',
        role_rabbitmq_groups: outward-rabbitmq,
        role_rabbitmq_management_port: '{{ outward_rabbitmq_management_port }}',
        role_rabbitmq_password: '{{ outward_rabbitmq_password }}',
        role_rabbitmq_port: '{{ outward_rabbitmq_port }}',
        role_rabbitmq_user: '{{ outward_rabbitmq_user }}',
        when: enable_outward_rabbitmq | bool }

- name: Apply role qdrouterd
  gather_facts: false
  hosts:
    - qdrouterd
    - '&enable_qdrouterd_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: qdrouterd,
        tags: qdrouterd,
        when: enable_qdrouterd | bool }

- name: Apply role etcd
  gather_facts: false
  hosts:
    - etcd
    - '&enable_etcd_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: etcd,
        tags: etcd,
        when: enable_etcd | bool }

- name: Apply role keystone
  gather_facts: false
  hosts:
    - keystone
    - '&enable_keystone_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: keystone,
        tags: keystone,
        when: enable_keystone | bool }

- name: Apply role ceph
  gather_facts: false
  hosts:
    - ceph-mds
    - ceph-mgr
    - ceph-mon
    - ceph-nfs
    - ceph-osd
    - ceph-rgw
    - '&enable_ceph_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: ceph,
        tags: ceph,
        when: enable_ceph | bool }

- name: Apply role kafka
  gather_facts: false
  hosts:
    - kafka
    - '&enable_kafka_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: kafka,
        tags: kafka,
        when: enable_kafka | bool }

- name: Apply role storm
  gather_facts: false
  hosts:
    - storm-worker
    - storm-nimbus
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: storm,
        tags: storm,
        when: enable_storm | bool }

- name: Apply role karbor
  gather_facts: false
  hosts:
    - karbor
    - '&enable_karbor_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: karbor,
        tags: karbor,
        when: enable_karbor | bool }

- name: Apply role swift
  gather_facts: false
  hosts:
    - swift-account-server
    - swift-container-server
    - swift-object-server
    - swift-proxy-server
    - '&enable_swift_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: swift,
        tags: swift,
        when: enable_swift | bool }

- name: Apply role glance
  gather_facts: false
  hosts:
    - ceph-mon
    - glance-api
    - '&enable_glance_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: glance,
        tags: glance,
        when: enable_glance | bool }

- name: Apply role ironic
  gather_facts: false
  hosts:
    - ironic-api
    - ironic-conductor
    - ironic-inspector
    - ironic-pxe
    - '&enable_ironic_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: ironic,
        tags: ironic,
        when: enable_ironic | bool }

- name: Apply role cinder
  gather_facts: false
  hosts:
    - ceph-mon
    - cinder-api
    - cinder-backup
    - cinder-scheduler
    - cinder-volume
    - '&enable_cinder_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: cinder,
        tags: cinder,
        when: enable_cinder | bool }

- name: Apply role placement
  gather_facts: false
  hosts:
    - placement-api
    - '&enable_placement_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: placement,
        tags: placement,
        when: enable_placement | bool }

- name: Apply role nova
  gather_facts: false
  hosts:
    - ceph-mon
    - compute
    - nova-api
    - nova-conductor
    - nova-consoleauth
    - nova-novncproxy
    - nova-scheduler
    - '&enable_nova_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: nova,
        tags: nova,
        when: enable_nova | bool }

- name: Apply role opendaylight
  gather_facts: false
  hosts:
    - opendaylight
    - '&enable_opendaylight_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: opendaylight,
        tags: opendaylight,
        when: enable_opendaylight | bool }

- name: Apply role openvswitch
  gather_facts: false
  hosts:
    - openvswitch
    - '&enable_openvswitch_True_enable_ovs_dpdk_False'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: openvswitch,
        tags: openvswitch,
        when: "(enable_openvswitch | bool) and not (enable_ovs_dpdk | bool)"}

- name: Apply role ovs-dpdk
  gather_facts: false
  hosts:
    - openvswitch
    - '&enable_openvswitch_True_enable_ovs_dpdk_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: ovs-dpdk,
        tags: ovs-dpdk,
        when: "(enable_openvswitch | bool) and (enable_ovs_dpdk | bool)"}

- name: Apply role nova-hyperv
  gather_facts: false
  hosts:
    - hyperv
    - '&enable_hyperv_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: nova-hyperv,
        tags: nova-hyperv,
        when: enable_hyperv | bool }

# NOTE(gmmaha): Please do not change the order listed here. The current order is a
# workaround to fix the bug https://bugs.launchpad.net/kolla/+bug/1546789
- name: Apply role neutron
  gather_facts: false
  hosts:
    - neutron-server
    - neutron-dhcp-agent
    - neutron-l3-agent
    - neutron-lbaas-agent
    - ironic-neutron-agent
    - neutron-metadata-agent
    - neutron-metering-agent
    - compute
    - manila-share
    - '&enable_neutron_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: neutron,
        tags: neutron,
        when: enable_neutron | bool }

- name: Apply role kuryr
  gather_facts: false
  hosts:
    - compute
    - '&enable_kuryr_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: kuryr,
        tags: kuryr,
        when: enable_kuryr | bool }

- name: Apply role heat
  gather_facts: false
  hosts:
    - heat-api
    - heat-api-cfn
    - heat-engine
    - '&enable_heat_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: heat,
        tags: heat,
        when: enable_heat | bool }

- name: Apply role horizon
  gather_facts: false
  hosts:
    - horizon
    - '&enable_horizon_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: horizon,
        tags: horizon,
        when: enable_horizon | bool }

- name: Apply role murano
  gather_facts: false
  hosts:
    - murano-api
    - murano-engine
    - '&enable_murano_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: murano,
        tags: murano,
        when: enable_murano | bool }

- name: Apply role solum
  gather_facts: false
  hosts:
    - solum-api
    - solum-worker
    - solum-deployer
    - solum-conductor
    - '&enable_solum_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: solum,
        tags: solum,
        when: enable_solum | bool }

- name: Apply role magnum
  gather_facts: false
  hosts:
    - magnum-api
    - magnum-conductor
    - '&enable_magnum_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: magnum,
        tags: magnum,
        when: enable_magnum | bool }

- name: Apply role mistral
  gather_facts: false
  hosts:
    - mistral-api
    - mistral-engine
    - mistral-executor
    - '&enable_mistral_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: mistral,
        tags: mistral,
        when: enable_mistral | bool }

- name: Apply role sahara
  gather_facts: false
  hosts:
    - sahara-api
    - sahara-engine
    - '&enable_sahara_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: sahara,
        tags: sahara,
        when: enable_sahara | bool }

- name: Apply role mongodb
  gather_facts: false
  hosts:
    - mongodb
    - '&enable_mongodb_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: mongodb,
        tags: mongodb,
        when: enable_mongodb | bool }

- name: Apply role panko
  gather_facts: false
  hosts:
    - panko-api
    - '&enable_panko_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: panko,
        tags: panko,
        when: enable_panko | bool }

- name: Apply role manila
  gather_facts: false
  hosts:
    - ceph-mon
    - manila-api
    - manila-data
    - manila-share
    - manila-scheduler
    - '&enable_manila_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: manila,
        tags: manila,
        when: enable_manila | bool }

- name: Apply role gnocchi
  gather_facts: false
  hosts:
    - ceph-mon
    - gnocchi-api
    - gnocchi-metricd
    - gnocchi-statsd
    - '&enable_gnocchi_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: gnocchi,
        tags: gnocchi,
        when: enable_gnocchi | bool }

- name: Apply role ceilometer
  gather_facts: false
  vars_files:
    - "roles/panko/defaults/main.yml"
  hosts:
    - ceilometer-central
    - ceilometer-notification
    - ceilometer-compute
    - ceilometer-ipmi
    - '&enable_ceilometer_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: ceilometer,
        tags: ceilometer,
        when: enable_ceilometer | bool }

- name: Apply role monasca
  gather_facts: false
  hosts:
    - monasca
    - monasca-agent
    - monasca-api
    - monasca-grafana
    - monasca-log-api
    - monasca-log-transformer
    - monasca-log-persister
    - monasca-log-metrics
    - monasca-thresh
    - monasca-notification
    - monasca-persister
    - '&enable_monasca_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: monasca,
        tags: monasca,
        when: enable_monasca | bool }

- name: Apply role aodh
  gather_facts: false
  hosts:
    - aodh-api
    - aodh-evaluator
    - aodh-listener
    - aodh-notifier
    - '&enable_aodh_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: aodh,
        tags: aodh,
        when: enable_aodh | bool }

- name: Apply role barbican
  gather_facts: false
  hosts:
    - barbican-api
    - barbican-keystone-listener
    - barbican-worker
    - '&enable_barbican_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: barbican,
        tags: barbican,
        when: enable_barbican | bool }

- name: Apply role congress
  gather_facts: false
  hosts:
    - congress-api
    - congress-policy-engine
    - congress-datasource
    - '&enable_congress_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: congress,
        tags: congress,
        when: enable_congress | bool }

- name: Apply role cyborg
  gather_facts: false
  hosts:
    - cyborg
    - '&enable_cyborg_True'
  serial: '{{ serial|default("0") }}'
  roles:
    - { role: cyborg,
        tags: cyborg,
        when: enable_cyborg | bool }

- name: Apply role tempest
  gather_facts: false
  hosts:
    - tempest
    - '&enable_tempest_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: tempest,
        tags: tempest,
        when: enable_tempest | bool }

- name: Apply role designate
  gather_facts: false
  hosts:
    - designate-api
    - designate-central
    - designate-producer
    - designate-mdns
    - designate-worker
    - designate-sink
    - designate-backend-bind9
    - '&enable_designate_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: designate,
        tags: designate,
        when: enable_designate | bool }

- name: Apply role rally
  gather_facts: false
  hosts:
    - rally
    - '&enable_rally_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: rally,
        tags: rally,
        when: enable_rally | bool }

- name: Apply role vmtp
  gather_facts: false
  hosts:
    - vmtp
    - '&enable_vmtp_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: vmtp,
        tags: vmtp,
        when: enable_vmtp | bool }

- name: Apply role trove
  gather_facts: false
  hosts:
    - trove-api
    - trove-conductor
    - trove-taskmanager
    - '&enable_trove_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: trove,
        tags: trove,
        when: enable_trove | bool }

- name: Apply role watcher
  gather_facts: false
  hosts:
    - watcher-api
    - watcher-engine
    - watcher-applier
    - '&enable_watcher_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: watcher,
        tags: watcher,
        when: enable_watcher | bool }

- name: Apply role grafana
  gather_facts: false
  hosts:
    - grafana
    - '&enable_grafana_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: grafana,
        tags: grafana,
        when: enable_grafana | bool }

- name: Apply role cloudkitty
  gather_facts: false
  hosts:
    - cloudkitty-api
    - cloudkitty-processor
    - '&enable_cloudkitty_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: cloudkitty,
        tags: cloudkitty,
        when: enable_cloudkitty | bool }

- name: Apply role freezer
  gather_facts: false
  hosts:
    - freezer-api
    - freezer-scheduler
    - '&enable_freezer_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: freezer,
        tags: freezer,
        when: enable_freezer | bool }

- name: Apply role senlin
  gather_facts: false
  hosts:
    - senlin-api
    - senlin-engine
    - '&enable_senlin_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: senlin,
        tags: senlin,
        when: enable_senlin | bool }

- name: Apply role searchlight
  gather_facts: false
  hosts:
    - searchlight-api
    - searchlight-listener
    - '&enable_searchlight_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: searchlight,
        tags: searchlight,
        when: enable_searchlight | bool }

- name: Apply role tacker
  gather_facts: false
  hosts:
    - tacker-server
    - tacker-conductor
    - '&enable_tacker_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: tacker,
        tags: tacker,
        when: enable_tacker | bool }

- name: Apply role octavia
  gather_facts: false
  hosts:
    - octavia-api
    - octavia-health-manager
    - octavia-housekeeping
    - octavia-worker
    - '&enable_octavia_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: octavia,
        tags: octavia,
        when: enable_octavia | bool }

- name: Apply role zun
  gather_facts: false
  hosts:
    - zun-api
    - zun-wsproxy
    - zun-compute
    - '&enable_zun_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: zun,
        tags: zun,
        when: enable_zun | bool }

- name: Apply role skydive
  gather_facts: false
  hosts:
    - skydive-agent
    - skydive-analyzer
    - '&enable_skydive_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: skydive,
        tags: skydive,
        when: enable_skydive | bool }

- name: Apply role vitrage
  gather_facts: false
  hosts:
    - vitrage-api
    - vitrage-graph
    - vitrage-notifier
    - vitrage-ml
    - '&enable_vitrage_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: vitrage,
        tags: vitrage,
        when: enable_vitrage | bool }

- name: Apply role blazar
  gather_facts: false
  hosts:
    - blazar-api
    - blazar-manager
    - '&enable_blazar_True'
  serial: '{{ kolla_serial|default("0") }}'
  roles:
    - { role: blazar,
        tags: blazar,
        when: enable_blazar | bool }


---
- name: "Configure haproxy for {{ project_name }}"
  import_role:
    role: haproxy-config
  vars:
    project_services: "{{ aodh_services }}"
  tags: always

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
																															>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>






Phan2: Tao Ansible cho Openstack
1. ansible.conf
** File ansible.conf chứa cấu hình thư mục cho cả ansible

- Sửa inventory = /etc/ansible/inventory/multinode

** Inventory: Chứa tập các Group Host:

		[controller]
		SPGM01DRCTRL01  chrony_server=true
		SPGM01DRCTRL02
		SPGM01DRCTRL03

		[compute_type_1]
		spgm01drcomp1
		spgm01drcomp2
		spgm01drcomp3

		[compute_type_2]

		[compute:children]
		compute_type_1
		compute_type_2

		[ops_node:children]
		controller
		compute
** Group_VAR: Chứa variable cho các Group trong Inventory
		all: chứa các biến default cho toàn ansible
		Tạo các thư mục và cho các file yml vào trong
		vd: /all/common.yml
    

    Các thư mục con trong thư mục group_vars tương ứng với tên của các inventory 


** roles:
  Gọi từng roles một, mỗi role có thể tương ứng với một service cần Tạo 
    - defaults   : Các biến mặc định 
    - files 
    - handlers 
    - meta 
    - tasks: Các bước cài đặt 
    - templates:  các file .j2 dùng cho module template copy file từ ansible sang một máy nào đó.
    - test 
    - vars 


** variable:
	hostvars:
	  tower:
	    compute01: "XXXXXX01"
	    compute02: "YYYYYY02"
	  red: "RED" 
	  green: "GREEN"
	  blue: "BLUE"



===> Convert String to Boolean:
    {% if enable_glance_image_cache | bool %}

##### Tower name is: {{ hostvariables.tower[host_name] }}


*** Ansible Docker
 - name: Glance BOOTSTRAP
  docker_container: 
    name: '{{ item.name }}'
    image: '{{ item.image }}'
    networks_mode: "host"
    user: '{{ item.user }}'
    volumes: '{{ item.volumes }}'
  with_items: 
    - '{{docker_container}}[0]'
  when: ( "{{ host_name }}"" == "{{ first_controller }}" ) 

- name: Cerate  Glance Container 
  docker_container: 
    name: '{{ item.name }}'
    image: '{{ item.image }}'
    networks_mode: "host"
    user: '{{ item.user }}'
    volumes: '{{ item.volumes }}'
  with_items: '{{docker_container}}'


docker_container:
  - name: glance-bootstrap
    image: docker-registry:4000/glance:q
    network_mode: host
    restart_policy: unless-stopped
    volumes:
      - '{{ VAR_LOG_DIR }}/glance:/var/log/glance'
      - /var/lib/glance:/var/lib/glance
      - '{{ usr_share_docker }}:/usr/share/docker/'
      - /etc/localtime:/etc/localtime
    user: glance 
    env: 
      - GLANCE_START:'BOOTSTRAP' 

  
	
===
Sua notify
Sua recurse


- Cac loi xay ra: 
* Trừ các file trong thư mục template các file còn lại muốn gọi biến phải đặt trong dấu '{{ }}' nhưng biến vẫn ở dạng thường ko kèm dấu ''
* không đặt tên biến trùng với tên module : docker-container 
* Phân biệt list và dist 
   trong docker-container volumes dạng list còn env dạng dist 
* Không đặt dấu ' ' trong các string của ansible
 ví dụ: ' ~/open.rc' là lỗi 
* Dùng command đôi khi xảy ra lỗi nếu có thể dùng shell 
* Để source ~/open.rc cạnh lệnh ở trong shell 
   source ~/open.rc && xxx 
* Với module command bỏ args đi 









