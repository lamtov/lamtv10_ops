#!/bin/bash

sudo -E copy_file.sh

#Check CINDER_START Env variable
if [ -z ${CINDER_START+x} ]; then
  echo "ENV START_CINDER is unset"
elif [ "$CINDER_START" = "START_CINDER_VOLUME" ]; then
  #if contract 2after upgrade finish
  cinder-volume
else 
  echo "CINDER START is $CINDER_START" 
fi




