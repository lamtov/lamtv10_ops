#!/bin/bash

sudo -E copy_file.sh

#Check MASAKARI_START Env variable
if [ -z ${MASAKARI_START+x} ]; then
  echo "ENV START_MASAKARI is unset"
  /bin/bash
elif [ "$MASAKARI_START" = "BOOTSTRAP" ]; then
  #if BOOTSTRAP
  echo "+ Backup corosync configuration"
  cp /etc/corosync/corosync.conf /etc/corosync/corosync.conf.$(date +"%m-%d-%Y.%H:%M:%S")
  
  echo "+ Backup masakari configuration"
  cp /etc/masakarimonitors/masakarimonitors.conf /etc/masakarimonitors/masakarimonitors.conf.$(date +"%m-%d-%Y.%H:%M:%S")
  
  echo "+ Generate pacemaker & corosync keygen"
  apt-get install haveged -y
  corosync-keygen
  dd if=/dev/urandom of=/etc/pacemaker/authkey bs=4096 count=1
  
  echo "+ Copy pacemaker & corosync keygen to the shared configuration directories"
  cp /etc/pacemaker/authkey ${SHARED_CONF_DIR}/pacemaker/
  cp /etc/corosync/authkey ${SHARED_CONF_DIR}/corosync/
elif [ "$MASAKARI_START" = "START_MASAKARI_MONITORS" ]; then
  echo "+ Start pacemaker & corosync"
  /etc/init.d/corosync start && /etc/init.d/pacemaker start
  
  echo "+ Waiting for pacemaker and corosync cluster are available"
  sleep 10
  
  echo "+ Start masakari-monitors services"
  masakari-hostmonitor
  masakari-instancemonitor
  masakari-processmonitor
else
  echo "MASAKARI_START is set to '$MASAKARI_START'"
fi

