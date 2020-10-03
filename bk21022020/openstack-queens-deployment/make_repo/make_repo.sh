#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}
 
yum erase rdo-release-rocky-0.noarch
yum install rdo-release-queens-0.noarch.rpm
yum install -y percona-release-0.1-6.noarch.rpm
yum install -y rdo-release-queens-0.noarch.rpm
#rm -rf /etc/yum.repos.d 
cp -r yum.repos.d /etc/
yum clean all
yum repolist
