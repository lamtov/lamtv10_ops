#!/bin/bash

#backup current config
cp -r /etc/openstack-dashboard ${SHARED_CONF_DIR}/${SERVICE}/backup/openstack-dashboard-$(date +%Y%m%d-%H%M%S)
cp -r /etc/apache2 ${SHARED_CONF_DIR}/${SERVICE}/backup/apache2-$(date +%Y%m%d-%H%M%S)

#copy new configuration file
cp -r ${SHARED_CONF_DIR}/${SERVICE}/openstack-dashboard/. /etc/openstack-dashboard/
cp -r ${SHARED_CONF_DIR}/${SERVICE}/apache2/conf-enabled/. /etc/apache2/conf-enabled/
cp -r ${SHARED_CONF_DIR}/${SERVICE}/hosts /etc/hosts

#change permission
chown www-data: /var/lib/openstack-dashboard/secret_key
chmod 0600 /var/lib/openstack-dashboard/secret_key








