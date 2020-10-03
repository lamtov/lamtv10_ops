MASAKARI




Huong dan cai dat masakari:
	- Tai masakari pike cai cho openstack pike 
	https://github.com/BoTranVan/ghichep-OpenStack/blob/master/Masakari/docs/masakari.md
	- Tai masakari monitor cai cho openstack pike
	https://github.com/BoTranVan/ghichep-OpenStack/blob/master/Masakari/docs/masakari-monitors.md
	- tai va cai dat python-masakari client 
		masakari-monitors==0.0.0
		python-masakariclient==3.0.1
		masakari-dashboard==0.1.0

	- Cai dat lib python nhu sau : 

pip uninstall python-openstackclient==3.12.0
pip install openstacksdk==0.9.17
pip install libvirt-python==3.5.0

pip install iso8610==0.1.11
pip install jsonschema==2.5.1
pip install keystoneauth1==3.1.0
pip install keystonemiddleware==4.17.0
pip install microversion-parse==0.1.4 
pip install oslo.config==5.2.0
pip install oslo.context==2.20.0
pip install oslo.db==4.33.0
pip install oslo.messaging==5.30.0
pip install oslo.i18n==3.17.0
pip install oslo.log==3.30.0
pip install oslo.middleware==3.30.0
pip install oslo.policy==1.25.1
pip install oslo.service==1.25.0
pip install oslo.utils==3.28.0
pip install oslo.versionedobjects==1.26.0
pip install pbr==2.0.0 
pip install python-novaclient==9.1.0
pip install six==1.10.0
pip install stevedore==1.25.0
pip install taskflow==2.14.0 
pip install oslo.concurrency==3.25.0
pip install oslo.middleware==3.30.0
pip install oslo.privsep==1.22.0
pip install oslo.context==2.17.0
pip install oslo.cache=1.28.0
pip install Babel==2.6.0

pip install osc_lib==1.7.0
pip install openstacksdk==0.9.17
pip install os-client-config==1.28.0
pip install python-masakariclient==3.0.1
	- Cau hinh cho masakari server 

/etc/masakari/masakari.conf
			[DEFAULT]
			graceful_shutdown_timeout = 5

			use_syslog = True
			debug = True
			logging_exception_prefix = %(color)s%(asctime)s.%(msecs)03d TRACE %(name)s %(instance)s
			logging_debug_format_suffix = from (pid=%(process)d) %(funcName)s %(pathname)s:%(lineno)d
			logging_default_format_string = %(asctime)s.%(msecs)03d %(color)s%(levelname)s %(name)s [-%(color)s] %(instance)s%(color)s%(message)s
			logging_context_format_string = %(asctime)s.%(msecs)03d %(color)s%(levelname)s %(name)s [%(request_id)s %(user)s %(tenant)s%(color)s] %(instance)s%(color)s%(message)s

			enabled_apis = masakari_api
			masakari_api_workers = 2
			masakari_api_listen = 172.16.30.85
			masakari_api_listen_port = 15868

			os_privileged_user_tenant = service
			os_privileged_user_password = 2md1gLgBXezyJjo2YNVtZMnu5YNhRVT2
			os_privileged_user_name = nova
			os_privileged_user_auth_url = http://os-controller:35357

			auth_strategy=keystone

			[wsgi]
			api_paste_config = /etc/masakari/api-paste.ini

			[keystone_authtoken]
			auth_uri = http://os-controller:5000
			auth_url = http://os-controller:35357
			auth_type = password
			project_domain_id = default
			user_domain_id = default
			project_name = service
			username = masakari
			password = qBYfmowOWSoywLjfxBAmw4UbbwR4fe6T
			memcached_servers = controller01:11211,controller02:11211,controller03:11211

			[database]
			connection = mysql+pymysql://masakari:B4PEOrVcWMDAqI9UkLzOBbiOnmsrXtbf@os-controller/masakari?charset=utf8

			[oslo_messaging_rabbit]
			rabbit_hosts = controller01:5672,controller02:5672,controller03:5672
			rabbit_userid = openstack
			rabbit_password = KFTA8eHMgiX4DDUcCKSsoTpZFGnCoBrA
			rabbit_retry_interval = 1
			rabbit_retry_backoff = 2
			rabbit_max_retries = 0
			rabbit_durable_queues = true
			rabbit_ha_queues = true

			[instance_failure]
			process_all_instances = false

			[host_failure]
			evacuate_all_instances = false


/etc/masakari-config-generator.conf
			[DEFAULT]
			output_file = etc/masakari/masakari.conf.sample
			wrap_width = 80
			namespace = keystonemiddleware.auth_token
			namespace = masakari.api
			namespace = masakari.conf
			namespace = masakari.engine
			namespace = oslo.config
			namespace = oslo.db
			namespace = oslo.db.concurrency
			namespace = oslo.log
			namespace = oslo.messaging
			namespace = oslo.middleware
			namespace = oslo.policy
			namespace = oslo.service.service
			namespace = oslo.service.wsgi
			namespace = oslo.versionedobjects



/etc/policy.json
			{
    "admin_api": "is_admin:True",
    "context_is_admin":  "role:admin",
    "admin_or_owner":  "is_admin:True or project_id:%(project_id)s",
    "default": "rule:admin_api",
    "os_masakari_api:extensions": "rule:admin_api",
    "os_masakari_api:segments": "rule:admin_api",
    "os_masakari_api:os-hosts": "rule:admin_api",
    "os_masakari_api:notifications": "rule:admin_api"
		}


/etc/api.ini
			[composite:masakari_api]
			use = call:masakari.api.urlmap:urlmap_factory
			/: apiversions
			/v1: masakari_api_v1


			[composite:masakari_api_v1]
			use = call:masakari.api.auth:pipeline_factory_v1
			keystone = cors http_proxy_to_wsgi request_id faultwrap sizelimit authtoken keystonecontext osapi_masakari_app_v1

			# filters
			[filter:cors]
			paste.filter_factory = oslo_middleware.cors:filter_factory
			oslo_config_project = masakari

			[filter:http_proxy_to_wsgi]
			paste.filter_factory = oslo_middleware.http_proxy_to_wsgi:HTTPProxyToWSGI.factory

			[filter:request_id]
			paste.filter_factory = oslo_middleware:RequestId.factory

			[filter:faultwrap]
			paste.filter_factory = masakari.api.openstack:FaultWrapper.factory

			[filter:sizelimit]
			paste.filter_factory = oslo_middleware:RequestBodySizeLimiter.factory

			[filter:authtoken]
			paste.filter_factory = keystonemiddleware.auth_token:filter_factory

			[filter:keystonecontext]
			paste.filter_factory = masakari.api.auth:MasakariKeystoneContext.factory

			[filter:noauth2]
			paste.filter_factory = masakari.api.auth:NoAuthMiddleware.factory

			# apps
			[app:osapi_masakari_app_v1]
			paste.app_factory = masakari.api.openstack.ha:APIRouterV1.factory

			[pipeline:apiversions]
			pipeline = faultwrap http_proxy_to_wsgi apiversionsapp

			[app:apiversionsapp]
			paste.app_factory = masakari.api.openstack.ha.versions:Versions.factory









 usage: masakari [--masakari-api-version] [-d] [--os-auth-plugin AUTH_PLUGIN]
                [--os-auth-url AUTH_URL] [--os-project-id PROJECT_ID]
                [--os-project-name PROJECT_NAME] [--os-tenant-id TENANT_ID]
                [--os-tenant-name TENANT_NAME] [--os-domain-id DOMAIN_ID]
                [--os-domain-name DOMAIN_NAME]
                [--os-project-domain-id PROJECT_DOMAIN_ID]
                [--os-project-domain-name PROJECT_DOMAIN_NAME]
                [--os-user-domain-id USER_DOMAIN_ID]
                [--os-user-domain-name USER_DOMAIN_NAME]
                [--os-username USERNAME] [--os-user-id USER_ID]
                [--os-password PASSWORD] [--os-trust-id TRUST_ID]
                [--os-cacert CA_BUNDLE_FILE | --verify | --insecure]
                [--os-token TOKEN] [--os-access-info ACCESS_INFO]
                <subcommand> ...

masakari shell




  --segment-id <SEGMENT_ID>
                        Name or ID of segment.
  --name <HOST_NAME>    Name of host.
  --type <TYPE>         Type of host.
  --control-attributes <CONTROL_ATTRIBUTES>
                        Control attributes of host.
  --reserved <RESERVED>
  --on-maintenance <ON_MAINTENANCE>





masakarirc:
		export OS_PROJECT_DOMAIN_NAME=Default
		export OS_USER_DOMAIN_NAME=Default
		export OS_PROJECT_NAME=service
		export OS_TENANT_NAME=service
		export OS_USERNAME=masakari
		export OS_PASSWORD=qBYfmowOWSoywLjfxBAmw4UbbwR4fe6T
		export OS_AUTH_URL=http://os-controller:35357
		export OS_IDENTITY_API_VERSION=3
		#export OS_IMAGE_API_VERSION=2

		export OS_PROJECT_ID=738eefc285c846dd86504d0c09bb55de
		#export OS_PROJECT_ID=5526d54b0fd149d991834e99364d7f87


Create Masakariservice :

openstack user create --password-prompt masakari
openstack role add --project service  --user masakari admin 
openstack role assignment list --user masakari
openstack service create --name masakari --description "OpenStack High Availability" ha   /* Khoi tao mot Service voi ten la "masakari"  va endpoint la "ha" */


Crate Masakari endpoint: 

	openstack endpoint create --region North_VN ha public http://172.16.30.82:5000/v1/%\(tenant_id\)s        
	openstack endpoint create --region North_VN ha admin http://172.16.30.82:5000/v1/%\(tenant_id\)s         
	openstack endpoint create --region North_VN ha internal http://172.16.30.82:5000/v1/%\(tenant_id\)s      
openstack endpoint create --region North_VN keystone identity http://172.16.30.82:5000/v3/   

Create Masakari segment:

	masakari segment-create --name masakariTest --description  Masakari4Test --recovery-method  auto --service-type ha

	masakari host-create --segment-id 0d1a5139-97df-4c91-a4d7-8030f20a0cc0   --control-attributes  SSH --name compute02 --type QEMU --reserved true --on-maintenance false 
	masakari host-update --segment-id 0d1a5139-97df-4c91-a4d7-8030f20a0cc0 --id  4459a246-5eff-4881-880b-3b458b9b4f6d  --control-attributes  SSH --name compute03 --type QEMU --reserved true --on-maintenance false 
	masakari host-update --segment-id 0d1a5139-97df-4c91-a4d7-8030f20a0cc0 --id 9211ad1b-e4fd-49da-8298-adb5e61fc63b --control-attributes  SSH --name compute02 --type QEMU --reserved true --on-maintenance false 
	
	masakari host-list --segment-id 30dac626-68d9-401e-9a84-f7176a94bea5


	https://developer.openstack.org/api-ref/instance-ha/?expanded=list-failoversegments-detail,list-hosts-detail


positional arguments:
  <subcommand>
    host-create         Create a host.
    host-delete         Delete a host.
    host-list           List hosts.
    host-show           Show a host details.
    host-update         Update a host.
    notification-create
                        Create a notification.
    notification-list   List notifications.
    notification-show   Show a notification details.
    segment-create      Create segment.
    segment-delete      Delete a segment.
    segment-list        List segments.
    segment-show        Show a segment details.
    segment-update      Update a segment.


   	masakari host-create --segment-id <SEGMENT_ID> --name <HOST_NAME> --type <TYPE> --control-attributes <CONTROL_ATTRIBUTES> [--reserved <RESERVED>] [--on-maintenance <ON_MAINTENANCE>]
   	masakari segment-delete --id <SEGMENT_ID>
	masakari host-list --segment-id <SEGMENT_ID>
	masakari host-show --segment-id <SEGMENT_ID> --id <HOST_ID>
	masakari host-delete --segment-id <SEGMENT_ID> --id <HOST_ID>
	masakari host-update --segment-id <SEGMENT_ID> --id <HOST_ID> [--name <HOST_NAME>] [--type <TYPE>] [--control-attributes <CONTROL_ATTRIBUTES>]  [--reserved <RESERVED>] [--on-maintenance <ON_MAINTENANCE>]
	masakari notification-create --type <TYPE> --hostname <HOSTNAME> --generated-time <GENERATED_TIME> --payload <PAYLOAD>
	masakari notification-list
	masakari notification-show --id <NOTIFICATION_ID>
	masakari notification-create --type <TYPE> --hostname <HOSTNAME> --generated-time <GENERATED_TIME> --payload <PAYLOAD>
	masakari segment-create --name <SEGMENT_NAME> --description <DESCRIPTION> --recovery-method  <RECOVERY_METHOD> --service-type <SERVICE_TYPE>
	masakari segment-delete --id <SEGMENT_ID>
	masakari segment-list
	masakari segment-show --id <SEGMENT_ID>
 	masakari segment-update --id <SEGMENT_ID> [--name <SEGMENT_NAME>] [--description <DESCRIPTION>] [--recovery-method <RECOVERY_METHOD>] [--service-type <SERVICE_TYPE>]




======================STOP NOVA-COMPUTE
2018-10-31 16:59:28.213 86060 INFO masakarimonitors.ha.masakari [-] Send a notification. {'notification': {'hostname': 'compute02', 'type': 'PROCESS', 'payload': {'process_name': '/usr/bin/python /usr/local/bin/masakari-hostmonitor', 'event': 'STOPPED'}, 'generated_time': datetime.datetime(2018, 10, 31, 9, 59, 28, 213151)}}


===================== STOP VM 
 INFO masakarimonitors.service [-] Starting masakarimonitors-instancemonitor
2018-11-01 09:12:25.999 2491 INFO masakarimonitors.instancemonitor.libvirt_handler.callback [-] Libvirt Event: type=VM, hostname=compute03, uuid=b6747d52-eda1-4ffb-b984-11bb27b402fe, time=2018-11-01 02:12:25.998980, event_id=LIFECYCLE, detail=STOPPED_DESTROYED)
2018-11-01 09:12:25.999 2491 INFO masakarimonitors.ha.masakari [-] Send a notification. {'notification': {'hostname': 'compute03', 'type': 'VM', 'payload': {'instance_uuid': 'b6747d52-eda1-4ffb-b984-11bb27b402fe', 'vir_domain_event': 'STOPPED_DESTROYED', 'event': 'LIFECYCLE'}, 'generated_time': datetime.datetime(2018, 11, 1, 2, 12, 25, 998980)}}
2018-11-01 09:12:27.185 2491 INFO masakarimonitors.ha.masakari [-] Stop retrying to send a notification because same notification have been already sent.



DEBUG masakari.api.openstack.wsgi [req-276e7b32-cb1a-42dd-87ce-8040fc88c1e9 67b2742aa2974a3b8bef3d09588a5f67 738eefc285c846dd86504d0c09bb55de] Returning 409 to user: Notification received from host compute02 of type 'VM' is ignored as the host is already under maintenance. from (pid=292) __call__ /usr/local/lib/python2.7/dist-packages/masakari/api/openstack/wsgi.py:1048

											======> Sua thanh --on-maintenance false 



==============================tai masakari-engine
 INFO masakari.engine.manager [req-bcdaa6b5-58cd-423a-9b0d-b07a0abe42ac 67b2742aa2974a3b8bef3d09588a5f67 738eefc285c846dd86504d0c09bb55de] Processing notification 6810fa54-1f98-46bc-8977-f80c187bb02e of type: VM
2018-11-01 14:33:36.014 INFO masakari.engine.manager [req-bcdaa6b5-58cd-423a-9b0d-b07a0abe42ac 67b2742aa2974a3b8bef3d09588a5f67 738eefc285c846dd86504d0c09bb55de] Notification '6810fa54-1f98-46bc-8977-f80c187bb02e' received with payload {u'instance_uuid': u'c1a37895-7407-4f1a-9e97-95d16d03fd72', u'vir_domain_event': u'STOPPED_SHUTDOWN', u'event': u'LIFECYCLE'} is ignored.
2018-11-01 14:33:36.016 INFO masakari.engine.manager [req-bcdaa6b5-58cd-423a-9b0d-b07a0abe42ac 67b2742aa2974a3b8bef3d09588a5f67 738eefc285c846dd86504d0c09bb55de] Notification 6810fa54-1f98-46bc-8977-f80c187bb02e exits with status: ignored.








vim /usr/share/docker/masakari/masakari/masakari.conf 


/usr/local/lib/python2.7/dist-packages/masakari/engine


*** Huong dan test masakari truong hop instance  failse 
	- 2 loi
	1. virsh list --all 
	2. ps -ef | grep x86 // xem thong tin process been canhj libvirt+ ... theo guest=instance name
	libvirt+ 135538      1 17 08:53 ?        00:00:03 /usr/bin/qemu-system-x86_64 -name guest=instance-000004b0,debug-threads=on -S -object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-225
	3. kill -9 135538




--		

										///////////////////////////////////////////////////////////////////////////


													 2014  openstack server list
													 2015  openstack server show lsss
													 2016  openstack compute service list
													 2017  openstack host show compute02
													 2018  openstack host show compute03
													 2019  openstack project show 5526d54b0fd149d991834e99364d7f87
													 2020  openstack project show 738eefc285c846dd86504d0c09bb55de
													 2021  openstack host show compute02
													 2022  openstack host show compute03
													 2023  openstack server list
													 2024  openstack server migrate 42bac147-f57f-4704-b075-afb40a896917 --live lsss
													 2025  openstack server migrate 42bac147-f57f-4704-b075-afb40a896917 --live compute03
													 2026  openstack host show compute03
													 2027  openstack host show compute02 //xem thong tin o dong 4 de biet project dang dung bao nhieu resource



													













										////////////////////////////////////////////////////////////////////////////


Lỗi xảy ra khi xóa đi cài lại pacemaker corosync thì cài corosync trước, pacemaker sau
vim /etc/hosts/
  pcs cluster destroy // thực hiện ở cả 2 .
 pcs cluster auth node1 node2
 pcs cluster setup --start --name lamtv compute02  compute03 --force  // Trong trường hợp báo lỗi thì thêm --force ở cuối sẽ xóa hết cluster cũ đi
 pcs resource create ..


pcs property list
pcs status corosync
pcs status resource 

pcs property set stonith-enabled=true 


/lib/systemd/system/




DEMO:
	- TH1: Khong them vao segment 
			--> Van chay binh thuong, van goi vao service masakari co endpoint la ha --> thong bao loi Host with name could not be found

2018-11-05 09:59:45.270 33208 DEBUG masakarimonitors.instancemonitor.libvirt_handler.eventfilter [-] libvirt Event Received.type = VM             hostname = compute02 uuid = 493efae2-bf29-46cf-94f5-0a1c9cd97e90 time = 2018-11-05 02:59:45.270419 eventID = 0 eventType = 5             detail = 0 vir_event_filter /usr/local/lib/python2.7/dist-packages/masakarimonitors/instancemonitor/libvirt_handler/eventfilter.py:58
2018-11-05 09:59:45.270 33208 DEBUG masakarimonitors.instancemonitor.libvirt_handler.eventfilter [-] Event Filter Matched. vir_event_filter /usr/local/lib/python2.7/dist-packages/masakarimonitors/instancemonitor/libvirt_handler/eventfilter.py:62
2018-11-05 09:59:45.271 33208 INFO masakarimonitors.instancemonitor.libvirt_handler.callback [-] Libvirt Event: type=VM, hostname=compute02, uuid=493efae2-bf29-46cf-94f5-0a1c9cd97e90, time=2018-11-05 02:59:45.270419, event_id=LIFECYCLE, detail=STOPPED_SHUTDOWN)
2018-11-05 09:59:45.272 33208 INFO masakarimonitors.ha.masakari [-] Send a notification. {'notification': {'hostname': 'compute02', 'type': 'VM', 'payload': {'instance_uuid': '493efae2-bf29-46cf-94f5-0a1c9cd97e90', 'vir_domain_event': 'STOPPED_SHUTDOWN', 'event': 'LIFECYCLE'}, 'generated_time': datetime.datetime(2018, 11, 5, 2, 59, 45, 270419)}}
2018-11-05 09:59:45.919 33208 DEBUG openstack.session [-] Looking for versions at http://172.16.30.85:15868 _parse_versions_response /usr/local/lib/python2.7/dist-packages/openstack/session.py:144
2018-11-05 09:59:45.926 33208 DEBUG openstack.session [-] Using http://172.16.30.85:15868/v1/738eefc285c846dd86504d0c09bb55de as public ha endpoint get_endpoint /usr/local/lib/python2.7/dist-packages/openstack/session.py:340
2018-11-05 09:59:46.172 33208 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (HttpException: Bad Request (HTTP 400) (Request-ID: req-dcf511bb-01ec-4505-be76-b22fd18c4612), Host with name compute02 could not be found.): HttpException: HttpException: Bad Request (HTTP 400) (Request-ID: req-dcf511bb-01ec-4505-be76-b22fd18c4612), Host with name compute02 could not be found.
2018-11-05 09:59:56.212 33208 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (HttpException: Bad Request (HTTP 400) (Request-ID: req-01773998-e089-49d9-b8d3-00be5d2078f2), Host with name compute02 could not be found.): HttpException: HttpException: Bad Request (HTTP 400) (Request-ID: req-01773998-e089-49d9-b8d3-00be5d2078f2), Host with name compute02 could not be found.
2018-11-05 10:00:06.250 33208 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (HttpException: Bad Request (HTTP 400) (Request-ID: req-37e71e3d-fcb8-4e43-9a82-bf8b8d325683), Host with name compute02 could not be found.): HttpException: HttpException: Bad Request (HTTP 400) (Request-ID: req-37e71e3d-fcb8-4e43-9a82-bf8b8d325683), Host with name compute02 could not be found.
2018-11-05 10:00:16.291 33208 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (HttpException: Bad Request (HTTP 400) (Request-ID: req-2da45cd5-b0e2-43be-80e5-8cf2cafaa73a), Host with name compute02 could not be found.): HttpException: HttpException: Bad Request (HTTP 400) (Request-ID: req-2da45cd5-b0e2-43be-80e5-8cf2cafaa73a), Host with name compute02 could not be found.
2018-11-05 10:00:26.335 33208 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (HttpException: Bad Request (HTTP 400) (Request-ID: req-1ec4333a-3e77-4638-bd01-fdd2eec46def), Host with name compute02 could not be found.): HttpException: HttpException: Bad Request (HTTP 400) (Request-ID: req-1ec4333a-3e77-4638-bd01-fdd2eec46def), Host with name compute02 could not be found.
2018-11-05 10:00:36.372 33208 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (HttpException: Bad Request (HTTP 400) (Request-ID: req-cf8e92b3-5f22-49b5-995e-44f11a562956), Host with name compute02 could not be found.): HttpException: HttpException: Bad Request (HTTP 400) (Request-ID: req-cf8e92b3-5f22-49b5-995e-44f11a562956), Host with name compute02 could not be found.
2018-11-05 10:00:46.415 33208 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (HttpException: Bad Request (HTTP 400) (Request-ID: req-13cb82bb-8bcf-4b1a-a72d-e7155a4f27d1), Host with name compute02 could not be found.): HttpException: HttpException: Bad Request (HTTP 400) (Request-ID: req-13cb82bb-8bcf-4b1a-a72d-e7155a4f27d1), Host with name compute02 could not be found.
2018-11-05 10:00:56.458 33208 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (HttpException: Bad Request (HTTP 400) (Request-ID: req-f153f89d-2459-42a3-8018-3e040ccd373c), Host with name compute02 could not be found.): HttpException: HttpException: Bad Request (HTTP 400) (Request-ID: req-f153f89d-2459-42a3-8018-3e040ccd373c), Host with name compute02 could not be found.
2018-11-05 10:01:06.501 33208 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (HttpException: Bad Request (HTTP 400) (Request-ID: req-080178ac-f11f-420b-afc9-ff9a3e6cdc30), Host with name compute02 could not be found.): HttpException: HttpException: Bad Request (HTTP 400) (Request-ID: req-080178ac-f11f-420b-afc9-ff9a3e6cdc30), Host with name compute02 could not be found.
2018-11-05 10:01:16.549 33208 WARNING masakarimonitors.ha.masakari [-] Retry sending a notification. (HttpException: Bad Request (HTTP 400) (Request-ID: req-4a9ea610-a04c-4a01-9c93-3b0ed3158788), Host with name compute02 could not be found.): HttpException: HttpException: Bad Request (HTTP 400) (Request-ID: req-4a9ea610-a04c-4a01-9c93-3b0ed3158788), Host with name compute02 could not be found.

	
	- TH2: Them vao segment
		+ Khi thuc hien masakari-processor thi goi 2 service la masakari-instancemonitor va masakari-hostmonitor len (neu ko co 2 file .service  thi se gui thong bao toi masakari-api)

				//Giai thich qua https://github.com/openstack/masakari-monitors/blob/master/etc/masakarimonitors/process_list.yaml.sample
		+ masakari-api nhan duoc thong bao --> khong xu ly duoc va luu host ve trang thai undermaintenance
		+ Trong trang thai maintenance moi loi gui len deu bi bo qua
	- TH3: Khi thuc hien chay masakari-processor va tat nova-compute (service  nova-compute stop) thi khong thay thong bao len api vi luc nay masakari-processor tu xu ly va xu ly xong, ko co thong bao 
	- TH4: Shutdown instance -->  thong bao loi bi bo qua , 
				// Giai thich qua https://github.com/openstack/masakari/blob/master/masakari/engine/instance_events.py
	- TH5: Kill -9 instancepid --> Neu instance  co metadata='HAEnabled=True' thi co thuc hien restart instance 

				//Giai thich qua https://docs.openstack.org/masakari/latest/sample_config.html
	- TH5: Tat masakari-processor va bat masakari-hostmonitor ---> Thuc hien tat nova-compute va tat corosync masakari bat dau chay ham nova evacuate  

			Giai thich: Trong code https://github.com/openstack/masakari-monitors/blob/stable/pike/masakarimonitors/hostmonitor/host_handler/handle_host.py
						co doan lay thong tin cua cac node thong qua lenh 
						/*line156*/	    def _get_cib_xml(self):
									        try:
									            # Execute cibadmin command.
									            out, err = utils.execute('cibadmin', '--query', run_as_root=True)  //cibadmin --query dua ra thong tin cua cluster va status cua cac node 

									            if err:
									                msg = ("cibadmin command output stderr: %s") % err
									                raise Exception(msg)

									        except Exception as e:
									            LOG.warning("Exception caught: %s", e)
									            return

									        return out
						=====> cib_xml = self._get_cib_xml()       //Lay thong tin dang list
						=====> self.xml_parser.set_cib_xml(cib_xml)      //luu thong tin
						=====> node_state_tag_list = self.xml_parser.get_node_state_tag_list()  //dua ve mang 
						====>  trong file https://github.com/openstack/masakari-monitors/blob/stable/pike/masakarimonitors/hostmonitor/host_handler/hold_host_status.py 
								dong thu 34 lay thong tin cua mot host :        self.host_status[node_state_tag.get('uname')] = \
            																	node_state_tag.get('crmd')



	- Co che gui tin qua notification
			https://docs.openstack.org/oslo.messaging/ocata/notification_listener.html

	- Chu y trong cau hinh masakari-hostmonitor: 
			[host]
			monitoring_driver = default
			monitoring_interval = 10                           //Chu ky check status
			api_retry_max = 12
			api_retry_interval = 10
			ipmi_timeout = 5
			ipmi_retry_max = 3
			ipmi_retry_interval = 10
			stonith_wait = 30
			tcpdump_timeout = 5
			corosync_multicast_interfaces = br-mgnt
			corosync_multicast_ports = 5405

	- Chu y khi tao instance can check ram o cac hypervisor va set  METADATA Cho cac FLAVOR: hw:mem_page_size =2MB

			va kiem tra xem co du ram khong bang  grep Hug /proc/meminfo
					root@compute03:~# grep Hug /proc/meminfo
					AnonHugePages:         0 kB
					HugePages_Total:   12288
					HugePages_Free:    10240
					HugePages_Rsvd:        0
					HugePages_Surp:        0
					Hugepagesize:       2048 kB



sadads







