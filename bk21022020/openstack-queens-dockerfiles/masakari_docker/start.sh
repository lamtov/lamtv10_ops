#!/bin/bash

sudo -E copy_file.sh

#Check MASAKARI_START Env variable
if [ -z ${MASAKARI_START+x} ]; then
  echo "ENV START_MASAKARI is unset"
  /bin/bash
elif [ "$MASAKARI_START" = "BOOTSTRAP" ]; then
  #if bootstrap
  masakari-manage db sync
elif [ "$MASAKARI_START" = "UPGRADE" ]; then
  #if UPGRADE
  masakari-manage db sync
elif [ "$MASAKARI_START" = "CONTRACT" ]; then
  #if contract after upgrade finish
  masakari-manage db sync
elif [ "$MASAKARI_START" = "START_MASAKARI_API" ]; then
  masakari-api
elif [ "$MASAKARI_START" = "START_MASAKARI_ENGINE" ]; then
  masakari-engine
else
 echo "MASAKARI_START is set to '$MASAKARI_START'"
fi

