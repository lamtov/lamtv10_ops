#!/bin/bash

echo "+ Update pacemaker & corosync configuration"
cp -R ${SHARED_CONF_DIR}/corosync/. /etc/corosync/
cp -R ${SHARED_CONF_DIR}/pacemaker/. /etc/pacemaker/

echo "+ Update pacemaker & corosync authkey permission"
chown root:root /etc/corosync/authkey
chmod 400 /etc/corosync/authkey
chown root:haclient /etc/pacemaker/authkey
chmod 640 /etc/pacemaker/authkey

cp -r ${SHARED_CONF_DIR}/${SERVICE}/hosts /etc/hosts
echo "+ Update masakaki-monitors configuration"
cp -R ${SHARED_CONF_DIR}/masakarimonitors/. /etc/masakarimonitors/

