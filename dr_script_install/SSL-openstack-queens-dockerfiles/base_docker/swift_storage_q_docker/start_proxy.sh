#!/bin/bash

sudo -E copy_file.sh

#Check SWIFT_START Env variable
if [ -z ${SWIFT_START+x} ]; then
  echo "ENV START_SWIFT is unset"

elif [ "$SWIFT_START" = "SWIFT_BOOTSTRAP" ]; then
        cd /etc/swift/
        swift-ring-builder account.builder create 10 3 1
	swift-ring-builder object.builder create 10 3 1
	swift-ring-builder container.builder create 10 3 1


elif [ "$SWIFT_START" = "SWIFT_INITIAL_ACCOUNT_RINGS" ]; then
	cd /etc/swift/
	swift-ring-builder account.builder add --region 1 --zone 1 --ip STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS --port 6202 --device DEVICE_NAME --weight DEVICE_WEIGHT
	#swift-ring-builder account.builder add  --region 1 --zone 1 --ip 10.0.0.51 --port 6202 --device sdb --weight 100 
	swift-ring-builder account.builder rebalance


elif [ "$SWIFT_START" = "SWIFT_INITIAL_CONTAINER_RINGS" ]; then
        cd /etc/swift/
        swift-ring-builder container.builder add --region 1 --zone 1 --ip STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS --port 6201 --device DEVICE_NAME --weight DEVICE_WEIGHT
        #swift-ring-builder container.builder add  --region 1 --zone 1 --ip 10.0.0.51 --port 6202 --device sdb --weight 100 
        swift-ring-builder container.builder rebalance


elif [ "$SWIFT_START" = "SWIFT_INITIAL_OBJECT_RINGS" ]; then
        cd /etc/swift/
        swift-ring-builder object.builder add --region 1 --zone 1 --ip STORAGE_NODE_MANAGEMENT_INTERFACE_IP_ADDRESS --port 6200 --device DEVICE_NAME --weight DEVICE_WEIGHT
        #swift-ring-builder account.builder add  --region 1 --zone 1 --ip 10.0.0.51 --port 6202 --device sdb --weight 100 
        swift-ring-builder object.builder rebalance





elif [ "$SWIFT_START" = "SWIFT_VERIFY" ]; then
        cd /etc/swift/
	swift-ring-builder account.builder
	swift-ring-builder container.builder
	swift-ring-builder object.builder
	


elif [ "$SWIFT_START" = "START_SWIFT_PROXY" ]; then
  #if contract 2after upgrade finish
  swift-proxy
else 
  echo "SWIFT START is $SWIFT_START" 
fi



