#!/bin/bash

#create ceph forder
mkdir -p /etc/ceph/
mkdir -p /var/cache/swift
#backup current config
cp -r /etc/${SERVICE} ${SHARED_CONF_DIR}/${SERVICE}/backup/${SERVICE}-$(date +%Y%m%d-%H%M%S)
cp -r /etc/ceph ${SHARED_CONF_DIR}/${SERVICE}/backup/ceph-$(date +%Y%m%d-%H%M%S)
cp -r /etc/sudoers.d/ ${SHARED_CONF_DIR}/${SERVICE}/backup/sudoers.d-$(date +%Y%m%d-%H%M%S)

#copy new configuration file
cp -r ${SHARED_CONF_DIR}/${SERVICE}/${SERVICE}/. /etc/${SERVICE}/
cp -r ${SHARED_CONF_DIR}/${SERVICE}/ceph/. /etc/ceph/
cp -r ${SHARED_CONF_DIR}/${SERVICE}/sudoers.d/. /etc/sudoers.d/


#change permission
#chown -R root:swift /etc/${SERVICE}/
#chown -R ${SERVICE}.${SERVICE} /var/lib/${SERVICE}/
#chown -R ${SERVICE}.${SERVICE} /var/log/${SERVICE}/

chgrp root  /etc/ceph/ceph.client.images.keyring
chmod 0640 /etc/ceph/ceph.client.images.keyring

chown -R root:root /srv/node
chown -R root:root /var/cache/swift
chmod -R 755 /var/cache/swift

