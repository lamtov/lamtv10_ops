#!/bin/bash

/bin/bash copy_file.sh

#Check CINDER_START Env variable
if [ -z ${CINDER_START+x} ]; then
  echo "ENV START_CINDER is unset"
  /bin/bash
elif [ "$CINDER_START" = "BOOTSTRAP" ]; then
  #if bootstrap
  #lance-manage db_sync
  cinder-manage db sync
elif [ "$CINDER_START" = "UPGRADE" ]; then
  #if UPGRADE
  cinder-manage db expand
  cinder-manage db migrate
elif [ "$CINDER_START" = "CONTRACT" ]; then
  #if contract 2after upgrade finish
  cinder-manage db contract
elif [ "$CINDER_START" = "START_CINDER_API" ]; then
  . /etc/apache2/envvars
  rm -rf /var/run/apache2/*
  /usr/sbin/apache2ctl -D FOREGROUND
elif [ "$GLANCE_START" = "START_CINDER_SCHEDULER" ]; then
  cinder-scheduler
else
 echo "CINDER_START is set to '$CINDER_START'"
fi




