#!/bin/bash

/bin/bash copy_file.sh

#Check HORIZON_START Env variable
if [ -z ${HORIZON_START+x} ]; then
  echo "ENV START_HORIZON is unset"
  /bin/bash
elif [ "$HORIZON_START" = "START_HORIZON" ]; then
  . /etc/apache2/envvars
  rm -rf /var/run/apache2/*
  a2enmod ssl
  /usr/sbin/apache2ctl -D FOREGROUND
else
 echo "HORIZON_START is set to '$HORIZON_START'"
fi

