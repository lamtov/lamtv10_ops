1  vim /etc/ssh/sshd_config 
    2  passwd 
    3  ifconfig 
  if
    5  ip link show 
    6  vim /etc/network/interfaces
    7  ifup ens3
    8  ifconfig 
    9  ifconfig ens3 0
   10  vim /etc/network/interfaces
   11  ifup ens3
   12  reboot
   13  ifconfig 
   14  vim /etc/network/interfaces
   15  ifup ens3
   16  ifdown ens3
   17  reboot
   18  hostname compute02
   19  vim /etc/hostname 
   20  ip link  show 
   21  vim /etc/network/interfaces
   22  ifup ens8
   23  ifup ens10
   24  vim /etc/network/interfaces
   25  ifup ens10
   26  ifup ens8
   27  ifconfig 
   28  exit
   29  ifconfig
   30  rm -rf /etc/hosts
   31  vim /etc/hosts


https://docs.openstack.org/queens/install/



************** LOI SO 1::::: ------- The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 8AA44104D035F123
     Thuc hien add key 
       export REGISTRY_IP=172.16.30.89
       # add gpg keys
      curl -fsSL http://${REGISTRY_IP}/keys/docker.gpg | sudo apt-key add -
      curl -fsSL http://${REGISTRY_IP}/keys/public.key | sudo apt-key add -
      curl -fsSL http://${REGISTRY_IP}/keys/percona.gpg | sudo apt-key add -
      curl -fsSL http://${REGISTRY_IP}/keys/ansible.gpg | sudo apt-key add -
      # Update
      apt-get update



************* Cai dat voi bash.sh 
      apt-get update
      apt-get -y upgrade
      apt-get -y dist-upgrade
      apt-get -y install --no-install-recommends  apt-utils  curl    gawk iproute2  kmod  lvm2   netbase  open-iscsi  python python-memcache git python-pip python-pymysql sudo nano tgt 
      apt-get clean
      apt-get install -y --no-install-recommends software-properties-common
      add-apt-repository cloud-archive:queens
      apt-get -y update
      apt-get -y dist-upgrade




==========================================Cai dat cho QUeens registry tren 172.16.30.89

  B1: Down cac goi can thiet tai http://ubuntu-cloud.archive.canonical.com/ubuntu/dists/xenial-updates/queens/main/binary-amd64/Packages

        wget http://ubuntu-cloud.archive.canonical.com/ubuntu/dists/xenial-updates/queens/main/binary-amd64/Packages
        cat Packages | grep Filename > filename.txt

  B2: Su dung file makeFolder.sh tao cac thu muc chua cac file tren repo 172.16.30.89
              while read line; do
                  path=${line:10}

                  dir=$(dirname $path)
                  folder="/repo/ubuntu-cloud.archive.canonical.com/ubuntu/"
                  folder+=$dir
                  echo $dir
                  echo $folder

                  mkdir $folder
              done < filename.txt
      /// Chu y: tao foler cho ca "/repo/ubuntu-cloud.archive.canonical.com/ubuntu/" va cho ca "/repo/ubuntu/"

  B3: Su dung file cloneAupload.sh de tai va day cac file len /repo/ubuntu-cloud.archive.canonical.com/ubuntu/
        #sshpass -p 'Vttek@123' ssh root@172.16.30.89

        #while read line; do
        #path=${line:10}

        #dir=$(dirname $filepath)
        #folder="/repo/ubuntu-cloud.archive.canonical.com/ubuntu/"
        #folder+=$dir
        #done < test.txt
        #exit
        total=1170

        while read line; do
        filepath=${line:10}

        filename=$(basename $filepath)
        filedir=$(dirname $filepath)
        echo $filename
        echo $filedir
        ((total--))



        linkFile="http://ubuntu-cloud.archive.canonical.com/ubuntu/"
        linkFile+=${line:10}
        wget $linkFile

        linkupload="root@172.16.30.89:/repo/ubuntu-cloud.archive.canonical.com/ubuntu/"
        linkupload+=$filedir
        echo $filename
        echo $linkupload
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        echo "Conlai: "+$total
        echo "  "
        echo "====================================================================================="

        sshpass -p 'Vttek@123' scp $filename $linkupload
        // Chu y can cai dat sshpass

    B4: upload phan con lai len /repo/ubuntu/
           total=1170

          while read line; do
          filepath=${line:10}

          filename=$(basename $filepath)
          filedir=$(dirname $filepath)
          echo $filename
          echo $filedir
          ((total--))



          linkFile="http://ubuntu-cloud.archive.canonical.com/ubuntu/"
          linkFile+=${line:10}
          #get $linkFile

          linkupload="root@172.16.30.89:/repo/ubuntu/"
          linkupload+=$filedir



          echo $filename
          echo $linkupload
          echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
          echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
          echo "Conlai: "+$total
          echo "  "
          echo "====================================================================================="

          sshpass -p 'Vttek@123' scp $filename $linkupload

          done < filename.txt
               
  B6: edit /etc/apt/source.list Sua pike thanh queens
          deb [arch=amd64] http://172.16.30.89/ubuntu xenial-updates/queens main
          deb [arch=amd64] http://172.16.30.89/repo.percona.com/apt xenial main
          deb [arch=amd64] http://172.16.30.89/nova.clouds.archive.ubuntu.com/ubuntu xenial main universe
          deb [arch=amd64] http://172.16.30.89/nova.clouds.archive.ubuntu.com/ubuntu xenial-backports main universe
          deb [arch=amd64] http://172.16.30.89/nova.clouds.archive.ubuntu.com/ubuntu xenial-updates main universe
          deb [arch=amd64] http://172.16.30.89/docker xenial edge
          deb [arch=amd64] http://172.16.30.89/influxdata xenial stable
          deb [arch=amd64] http://172.16.30.89/td-agent-3 xenial contrib

          Thuc hien  add-apt-repository cloud-archive:queens && apt-get update && apt-get upgrade

 B7 apt install nova-compute //Bo xung 4 file con thieu 

        python3-dateutil_2.4.2-1_all.deb  python3-mako_1.0.3+ds1-1ubuntu1_all.deb  python3-markupsafe_0.23-2build2_amd64.deb  python-jmespath_0.9.0-2_all.deb



        yum install openstack-nova-compute











*********** Cai dat COPMPUTE 
---------------------------------https://docs.openstack.org/nova/rocky/install/compute-install-rdo.html


http://172.16.30.89/epel7server/Packages/p/python-dogpile-core-0.4.1-2.el7.noarch.rpm: 
http://172.16.30.89/epel7server/Packages/p/python-linecache2-1.0.0-1.el7.noarch.rpm:
#*/
systemctl enable libvirtd.service openstack-nova-compute.service
systemctl start libvirtd.service openstack-nova-compute.service












      Compute 
        Nova hypervisor 
        Solariszone
        NTP: Network Time Protocol    
        EVS controller
        Layer 3 agent
        DHCP agent 
        - ntp 
        - ovs-vswitchd
        - qemu-system-x86
        - neutron-dhcp-ag
        - neutron-openvsw
        - corosync
        - nova-compute 
        - kworker
        - watchdog




yum install openvswitch
 systemctl start openvswitch.service
[root@compute02 ~]# systemctl enable openvswitch.service


docker run  -d --name ovs-agent --network=host --restart unless-stopped --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_OVS_AGENT' 172.16.30.82:4000/neutron:q


      +++++++++

      Loi xay ra :
        2018-12-18T07:55:08.842Z|02567|socket_util|ERR|6640:127.0.0.1: bind: Permission denied
        2018-12-18T07:55:09.412Z|02568|socket_util|ERR|6640:127.0.0.1: bind: Permission denied


https://linuxize.com/post/how-to-disable-selinux-on-centos-7/
    sudo setenforce 0
     /etc/selinux/config
              # This file controls the state of SELinux on the system.
              # SELINUX= can take one of these three values:
              #       enforcing - SELinux security policy is enforced.
              #       permissive - SELinux prints warnings instead of enforcing.
              #       disabled - No SELinux policy is loaded.
              SELINUX=disabled
              # SELINUXTYPE= can take one of these two values:
              #       targeted - Targeted processes are protected,
              #       mls - Multi Level Security protection.
              SELINUXTYPE=targeted
    sestatus









      ++++++++++



docker run -d --name dhcp-agent --network=host --restart unless-stopped --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_DHCP_AGENT' 172.16.30.82:4000/neutron:q


docker run -d  --name metadata-agent --network=host --restart unless-stopped --privileged --user neutron -v /var/log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run/netns:/run/netns:shared -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_METADATA_AGENT' 172.16.30.82:4000/neutron:q






*************** CAI DAT REDHAT 7 ********************
  yum clean all
  yum repolist
  yum install unix2dos
  

      vim /etc/yum.repos.d/rhel76.repo
      [rhel76]
      name=rhel76
      baseurl=http://172.16.30.89/rhel76
      enabled=1
      gpgcheck=0



      vim /etc/yum.conf 
      [main]
      cachedir=/var/cache/yum/$basearch/$releasever
      keepcache=0
      debuglevel=2
      logfile=/var/log/yum.log
      exactarch=1
      obsoletes=1
      gpgcheck=1
      plugins=1
      installonly_limit=3

      #  This is the default, if you make this bigger yum won't see if the metadata
      # is newer on the remote and so you'll "gain" the bandwidth of not having to
      # download the new metadata and "pay" for it by yum not having correct
      # information.
      #  It is esp. important, to have correct metadata, for distributions like
      # Fedora which don't keep old packages around. If you don't like this checking
      # interupting your command line usage, it's much better to have something
      # manually check the metadata once an hour (yum-updatesd will do this).
      # metadata_expire=90m

      # PUT YOUR REPOS HERE OR IN separate files named file.repo



      vim /etc/sysconfig/network-scripts/ifcfg-ens3 
        TYPE=Ethernet
        PROXY_METHOD=none
        BROWSER_ONLY=no
        BOOTPROTO=static
        DEFROUTE=yes
        IPV4_FAILURE_FATAL=no
        IPV6INIT=no
        IPV6_AUTOCONF=no
        IPV6_DEFROUTE=no
        IPV6_FAILURE_FATAL=no
        IPV6_ADDR_GEN_MODE=stable-privacy
        NAME=ens3
        DEVICE=ens3
        ONBOOT=yes
        IPADDR=172.16.30.169
        NETMASK=255.255.255.0
        #SUBCHANNELS=0.0.0600,0.0.0601,0.0.0602
        GATEWAY=172.16.30.254


====> Len con 84 lay vm ve cai


dmesg | grep IOMMU | grep enabled


 neutron net-create --provider:physical_network=physnet1 --provider:network_type=flat sriov
  neutron port-create c3e57e37-fea1-4ec9-b836-196ad81c20b9 --name p1 --binding:vnic-type direct --device_owner network:dhcp

    nova boot --flavor 4C4R8G --image Ubuntu.xenial  --nic net-id=c3e57e37-fea1-4ec9-b836-196ad81c20b9 --nic port-id=ca3ca738-2e1f-4fe0-9f6f-c32fe52139e5 the_alpha




    flavor
    hw:cpu_policy     dedicated
    hw:cpu_threads_policy       separate
    hw:mem_page_size      1GB