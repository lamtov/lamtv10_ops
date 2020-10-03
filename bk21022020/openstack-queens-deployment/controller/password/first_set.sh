#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}
#Import source 
source etc_hosts.env


sed -i "s|MY_CTL_HOST_FROM_HOST_NAME|${CONTROLLER_NAME[`hostname`]}|g"  ./passwd.env
sed -i "s|MY_CTL_IP_FROM_HOST_NAME|${CONTROLLERS_IP[`hostname`]}|g"  ./passwd.env
sed -i "s|MY_CPT_HOST_FROM_HOST_NAME|${COMPUTE_NAME[`hostname`]}|g"  ./passwd.env
sed -i "s|MY_CPT_IP_FROM_HOST_NAME|${COMPUTE_IP[`hostname`]}|g"  ./passwd.env