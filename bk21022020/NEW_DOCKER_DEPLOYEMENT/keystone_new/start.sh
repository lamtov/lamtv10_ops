#!/bin/bash

/bin/bash copy_file.sh

#Check KEYSTONE_START Env variable
if [ -z ${KEYSTONE_START+x} ]; then
  echo "ENV START_KEYSTONE is unset"
  /bin/bash
elif [ "$KEYSTONE_START" = "BOOTSTRAP" ]; then
  #if bootstrap
  su -s /bin/sh -c "keystone-manage db_sync" keystone

  keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
  keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

  keystone-manage bootstrap --bootstrap-password $ADMIN_PASS \
    --bootstrap-admin-url http://$CONTROLLER_HOST:5000/v3/ \
    --bootstrap-internal-url http://$CONTROLLER_HOST:5000/v3/ \
    --bootstrap-public-url http://$CONTROLLER_HOST:5000/v3/ \
    --bootstrap-region-id $REGION_NAME
elif [ "$KEYSTONE_START" = "DOCTOR" ]; then
  #if UPGRADE
  su -s /bin/sh -c "keystone-manage doctor" keystone
elif [ "$KEYSTONE_START" = "UPGRADE" ]; then
  #if UPGRADE
  su -s /bin/sh -c "keystone-manage db_sync --expand" keystone
  su -s /bin/sh -c "keystone-manage db_sync --migrate" keystone
elif [ "$KEYSTONE_START" = "CONTRACT" ]; then
  #if contract after upgrade finish
  su -s /bin/sh -c "keystone-manage db_sync --contract" keystone
elif [ "$KEYSTONE_START" = "DBCHECK" ]; then
  #check db_sync after upgrade
  su -s /bin/sh -c "keystone-manage db_sync --check" keystone
elif [ "$KEYSTONE_START" = "DBSYNC" ]; then
  #upgrade keystone with minimal downtime
  su -s /bin/sh -c "keystone-manage db_sync" keystone
elif [ "$KEYSTONE_START" = "START_KEYSTONE" ]; then
  . /etc/apache2/envvars
  rm -rf /var/run/apache2/*
  /usr/sbin/apache2ctl -D FOREGROUND
else
 echo "KEYSTONE_START is set to '$KEYSTONE_START'"
fi


