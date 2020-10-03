#!/bin/bash

sudo -E copy_file.sh

#Check GLANCE_START Env variable
if [ -z ${GLANCE_START+x} ]; then
  echo "ENV START_GLANCE is unset"
  /bin/bash
elif [ "$GLANCE_START" = "BOOTSTRAP" ]; then
  #if bootstrap
  glance-manage db_sync
elif [ "$GLANCE_START" = "UPGRADE" ]; then
  #if UPGRADE
  glance-manage db expand
  glance-manage db migrate
elif [ "$GLANCE_START" = "CONTRACT" ]; then
  #if contract after upgrade finish
  glance-manage db contract
elif [ "$GLANCE_START" = "START_GLANCE_API" ]; then
  glance-api
elif [ "$GLANCE_START" = "START_GLANCE_REGISTRY" ]; then
  glance-registry
else
 echo "GLANCE_START is set to '$GLANCE_START'"
fi



