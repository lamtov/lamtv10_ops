#!/bin/bash

#backup current config
cp -r /etc/${SERVICE} ${SHARED_CONF_DIR}/${SERVICE}/backup/${SERVICE}-$(date +%Y%m%d-%H%M%S)
cp -r /etc/sudoers.d/ ${SHARED_CONF_DIR}/${SERVICE}/backup/sudoers.d-$(date +%Y%m%d-%H%M%S)

#copy new configuration file
cp -r ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/. /etc/${SERVICE}/
cp -r ${SHARED_CONF_DIR}/${SERVICE}/sudoers.d/. /etc/sudoers.d/

cp -r ${SHARED_CONF_DIR}/${SERVICE}/hosts /etc/hosts

#change permission
chown -R ${SERVICE}.${SERVICE} /etc/${SERVICE}/
chown -R ${SERVICE}.${SERVICE} /var/lib/${SERVICE}/
chown -R ${SERVICE}.${SERVICE} /var/log/${SERVICE}/

