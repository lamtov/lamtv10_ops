backup_log.js


docker stop ssl_cinder-scheduler ssl_cinder-api ssl_horizon ssl_neutron-server ssl_nova-placement-api ssl_nova-novncproxy ssl_nova-conductor ssl_nova-scheduler ssl_nova-api ssl_nova-consoleauth ssl_glance-registry ssl_glance-api ssl_keystone cinder-volume

mv /u01/docker/docker_log/apache2/keystone_access.log /u01/docker/docker_log/apache2/keystone_access.log.bk
mv /u01/docker/docker_log/apache2/keystone.log /u01/docker/docker_log/apache2/keystone.log.bk
mv /u01/docker/docker_log/apache2/horizon_access.log /u01/docker/docker_log/apache2/horizon_access.log.bk
mv /u01/docker/docker_log/apache2/horizon.log /u01/docker/docker_log/apache2/horizon.log.bk
mv /u01/docker/docker_log/glance/glance-api.log /u01/docker/docker_log/glance/glance-api.log.bk
mv /u01/docker/docker_log/glance/glance-registry.log /u01/docker/docker_log/glance/glance-registry.log.bk
mv /u01/docker/docker_log/cinder/cinder-manage.log /u01/docker/docker_log/cinder/cinder-manage.log.bk
mv /u01/docker/docker_log/cinder/cinder-scheduler.log /u01/docker/docker_log/cinder/cinder-scheduler.log.bk
mv /u01/docker/docker_log/cinder/cinder-volume.log /u01/docker/docker_log/cinder/cinder-volume.log.bk
mv /u01/docker/docker_log/nova/nova-api.log /u01/docker/docker_log/nova/nova-api.log.bk
mv /u01/docker/docker_log/nova/nova-scheduler.log /u01/docker/docker_log/nova/nova-scheduler.log.bk
mv /u01/docker/docker_log/nova/nova-conductor.log /u01/docker/docker_log/nova/nova-conductor.log.bk
mv /u01/docker/docker_log/nova/nova-novncproxy.log /u01/docker/docker_log/nova/nova-novncproxy.log.bk
mv /u01/docker/docker_log/nova/nova-consoleauth.log /u01/docker/docker_log/nova/nova-consoleauth.log.bk
mv /u01/docker/docker_log/nova/nova-placement-api.log /u01/docker/docker_log/nova/nova-placement-api.log.bk
mv /u01/docker/docker_log/neutron/neutron-server.log /u01/docker/docker_log/neutron/neutron-server.log.bk

tail -n 10000 /u01/docker/docker_log/apache2/keystone_access.log.bk > /u01/docker/docker_log/apache2/keystone_access.log
tail -n 10000 /u01/docker/docker_log/apache2/keystone.log.bk  > /u01/docker/docker_log/apache2/keystone.log
tail -n 10000 /u01/docker/docker_log/apache2/horizon_access.log.bk  > /u01/docker/docker_log/apache2/horizon_access.log
tail -n 10000 /u01/docker/docker_log/apache2/horizon.log.bk  >  /u01/docker/docker_log/apache2/horizon.log
tail -n 10000 /u01/docker/docker_log/glance/glance-api.log.bk  >  /u01/docker/docker_log/glance/glance-api.log
tail -n 10000 /u01/docker/docker_log/glance/glance-registry.log.bk  >  /u01/docker/docker_log/glance/glance-registry.log
tail -n 10000 /u01/docker/docker_log/cinder/cinder-manage.log.bk  >  /u01/docker/docker_log/cinder/cinder-manage.log
tail -n 10000 /u01/docker/docker_log/cinder/cinder-scheduler.log.bk  >  /u01/docker/docker_log/cinder/cinder-scheduler.log
tail -n 10000 /u01/docker/docker_log/cinder/cinder-volume.log.bk  >  /u01/docker/docker_log/cinder/cinder-volume.log
tail -n 10000 /u01/docker/docker_log/nova/nova-api.log.bk  >  /u01/docker/docker_log/nova/nova-api.log
tail -n 10000 /u01/docker/docker_log/nova/nova-scheduler.log.bk   >  /u01/docker/docker_log/nova/nova-scheduler.log
tail -n 10000 /u01/docker/docker_log/nova/nova-conductor.log.bk   >  /u01/docker/docker_log/nova/nova-conductor.log
tail -n 10000 /u01/docker/docker_log/nova/nova-novncproxy.log.bk   >  /u01/docker/docker_log/nova/nova-novncproxy.log
tail -n 10000 /u01/docker/docker_log/nova/nova-consoleauth.log.bk   >  /u01/docker/docker_log/nova/nova-consoleauth.log
tail -n 10000 /u01/docker/docker_log/nova/nova-placement-api.log.bk  >   /u01/docker/docker_log/nova/nova-placement-api.log
tail -n 10000 /u01/docker/docker_log/neutron/neutron-server.log.bk   >  /u01/docker/docker_log/neutron/neutron-server.log


rm -rf /u01/docker/docker_log/apache2/keystone_access.log.bk 
rm -rf /u01/docker/docker_log/apache2/keystone.log.bk
rm -rf /u01/docker/docker_log/apache2/horizon_access.log.bk
rm -rf /u01/docker/docker_log/apache2/horizon.log.bk
rm -rf /u01/docker/docker_log/glance/glance-api.log.bk
rm -rf /u01/docker/docker_log/glance/glance-registry.log.bk
rm -rf /u01/docker/docker_log/cinder/cinder-manage.log.bk
rm -rf /u01/docker/docker_log/cinder/cinder-scheduler.log.bk
rm -rf /u01/docker/docker_log/cinder/cinder-volume.log.bk
rm -rf /u01/docker/docker_log/nova/nova-api.log.bk
rm -rf /u01/docker/docker_log/nova/nova-scheduler.log.bk
rm -rf /u01/docker/docker_log/nova/nova-conductor.log.bk
rm -rf /u01/docker/docker_log/nova/nova-placement-api.log.bk
rm -rf /u01/docker/docker_log/nova/nova-consoleauth.log.bk
rm -rf /u01/docker/docker_log/neutron/neutron-server.log.bk
rm -rf /u01/docker/docker_log/nova/nova-placement-api.log.bk


docker start ssl_cinder-scheduler ssl_cinder-api ssl_horizon ssl_neutron-server ssl_nova-placement-api ssl_nova-novncproxy ssl_nova-conductor ssl_nova-scheduler ssl_nova-api ssl_nova-consoleauth ssl_glance-registry ssl_glance-api ssl_keystone cinder-volume