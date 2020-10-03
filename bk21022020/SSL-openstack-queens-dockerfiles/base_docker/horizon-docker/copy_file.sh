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

cp  ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/ssl/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
cp  ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/settings/settings.py /usr/share/openstack-dashboard/openstack_dashboard/settings.py

mkdir /etc/openstack-dashboard/ssl/
cp  ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/ssl/private_key.pem /etc/openstack-dashboard/ssl/private_key.pem
cp  ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/ssl/rootCA.pem /etc/openstack-dashboard/ssl/rootCA.pem
cp  ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/ssl/server_cert.pem /etc/openstack-dashboard/ssl/server_cert.pem


