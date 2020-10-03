#!/bin/bash

#backup current config
cp -r /etc/${SERVICE} ${SHARED_CONF_DIR}/${SERVICE}/backup/${SERVICE}-$(date +%Y%m%d-%H%M%S)

#copy new configuration file
cp -r ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/. /etc/${SERVICE}/

cp -r ${SHARED_CONF_DIR}/${SERVICE}/hosts /etc/hosts

cp  ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/ssl/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
#change permission
chown -R ${SERVICE}.${SERVICE} /etc/${SERVICE}/
chmod 700 /etc/${SERVICE}/{credential-keys,fernet-keys}

cp  ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/apache2/keystone.conf  /etc/apache2/sites-enabled/keystone.conf
cp  ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/apache2/apache2.conf /etc/apache2/apache2.conf
cp -r  ${SHARED_CONF_DIR}/tracing_server/ /etc/

