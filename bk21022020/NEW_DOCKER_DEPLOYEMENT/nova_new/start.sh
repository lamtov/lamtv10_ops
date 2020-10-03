#!/bin/bash

sudo -E copy_file.sh

#Check NOVA_START Env variable
if [ -z ${NOVA_START+x} ]; then
  echo "ENV START_NOVA is unset"
  /bin/bash
elif [ "$NOVA_START" = "BOOTSTRAP" ]; then
  #if bootstrap
  nova-manage api_db sync
  nova-manage cell_v2 map_cell0
  nova-manage cell_v2 create_cell --name=$CELL_NAME --verbose
  nova-manage db sync
elif [ "$NOVA_START" = "UPGRADE" ]; then
  #if UPGRADE
  nova-manage db sync
  nova-manage api_db sync
elif [ "$NOVA_START" = "CONTRACT" ]; then
  #if contract after upgrade finish
  nova-manage db online_data_migrations
elif [ "$NOVA_START" = "START_NOVA_API" ]; then
  nova-api
elif [ "$NOVA_START" = "START_NOVA_CONDUCTOR" ]; then
  nova-conductor
elif [ "$NOVA_START" = "START_NOVA_CONSOLEAUTH" ]; then
  nova-consoleauth
elif [ "$NOVA_START" = "START_NOVA_NOVNCPROXY" ]; then
  nova-novncproxy
elif [ "$NOVA_START" = "START_NOVA_SCHEDULER" ]; then
  nova-scheduler
elif [ "$NOVA_START" = "START_NOVA_PLACEMENT_API" ]; then
  . /etc/apache2/envvars
  rm -rf /var/run/apache2/*
  /usr/sbin/apache2ctl -D FOREGROUND
else
 echo "NOVA_START is set to '$NOVA_START'"
fi


