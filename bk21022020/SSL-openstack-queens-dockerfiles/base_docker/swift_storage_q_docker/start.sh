#!/bin/bash

#sudo -E copy_file.sh

/bin/bash  copy_file.sh


#Check SWIFT_START Env variable
if [ -z ${SWIFT_START+x} ]; then
  echo "ENV START_SWIFT is unset"


elif [ "$SWIFT_START" = "START_SWIFT_STORAGE" ]; then
  #if contract 2after upgrade finish
  swift-init all start

   tail -f /var/log/dpkg.log

else
  echo "SWIFT START is $SWIFT_START" 
fi
