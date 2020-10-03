systemctl enable openstack-swift-account.service openstack-swift-account-auditor.service openstack-swift-account-reaper.service openstack-swift-account-replicator.service
systemctl start openstack-swift-account.service openstack-swift-account-auditor.service  openstack-swift-account-reaper.service openstack-swift-account-replicator.service
systemctl enable openstack-swift-container.service  openstack-swift-container-auditor.service openstack-swift-container-replicator.service openstack-swift-container-updater.service
 systemctl start  openstack-swift-container.service   openstack-swift-container-auditor.service openstack-swift-container-replicator.service openstack-swift-container-updater.service
systemctl enable openstack-swift-object.service openstack-swift-object-auditor.service   openstack-swift-object-replicator.service openstack-swift-object-updater.service
 systemctl start  openstack-swift-object.service openstack-swift-object-auditor.service   openstack-swift-object-replicator.service openstack-swift-object-updater.service


 clear
    2  df -h
    3  df -lsbk
    4  fdisk
    5  fdisk -S
    6  lsblk
    7  fdisk -l
    8  vim /etc/hosts
    9  fdisk -l
   10  mkfs.xfs /dev/sdc
   11  mkdir -p /srv/node/sdc
   12  vim /etc/fstab
   13  mount /srv/node/sdc
   14  vim /etc/rsyncd.conf 
   15  systemctl enable rsyncd.service
   16  systemctl restart rsyncd.service
   17  yum install openstack-swift-account openstack-swift-container openstack-swift-object
   18  cd /etc/yum.repos.d/
   19  ll
   20  mkdir bk
   21  mv ./* bk/
   22  ll
   23  scp -r root@172.16.30.192:/etc/yum.repos.d/* ./
   24  ll
   25  yum clean all
   26  yum repolist
   27  vim /etc/hosts
   28  yum clean all
   29  yum repolist
   30  yum install openstack-swift-account openstack-swift-container openstack-swift-object
   31  chown -R swift:swift /srv/node
   32  mkdir -p /var/cache/swift
   33  chown -R root:swift /var/cache/swift
   34  chmod -R 775 /var/cache/swift
   35  cd /etc/swift/
   36  ll
   37  vim account-server.conf 
   38  vi account-server.conf 
   39  vi container-server.conf 
   40  vi object-server.conf 
   41  vim account-server.conf 
   42  vim container-server.conf 
   43  vim account-server.conf 
   44  vim object-server.conf 
   45  vim account-server.conf 
   46  systemctl enable openstack-swift-account.service openstack-swift-account-auditor.service   openstack-swift-account-reaper.service openstack-swift-account-replicator.service
   47  systemctl start openstack-swift-account.service openstack-swift-account-auditor.service   openstack-swift-account-reaper.service openstack-swift-account-replicator.service
   48  systemctl enable openstack-swift-container.service   openstack-swift-container-auditor.service openstack-swift-container-replicator.service   openstack-swift-container-updater.service
   49  systemctl start openstack-swift-container.service   openstack-swift-container-auditor.service openstack-swift-container-replicator.service   openstack-swift-container-updater.service
   50  ll
   51  vim swift.conf 
   52  systemctl enable openstack-swift-object.service openstack-swift-object-auditor.service   openstack-swift-object-replicator.service openstack-swift-object-updater.service
   53  systemctl start openstack-swift-object.service openstack-swift-object-auditor.service   openstack-swift-object-replicator.service openstack-swift-object-updater.service
   54  systemctl status openstack-swift*
   55  tail -f /var/log/swift/
   56  vim /etc/rsyncd.conf 
   57  vim /etc/rsyncd.conf 
   58  systemctl status rsyncd
   59  ll
   60  vim object-server.conf 
   61  vim account-server.conf 
   62  vim container-server.conf 
   63  systemctl status iptables;
   64  systemctl status iptables
   65  systemctl status firewalld
   66  systemctl stop firewalld
   67  systemctl disable firewalld
   68  sestatus
   69  vim /etc/selinux/config
   70  sysctl -p
   71  systemctl restart openstack-swift*
   72  systemctl status openstack-swift*
   73  systemctl restart openstack-swift-container.service
   74  systemctl status openstack-swift-container.service
   75  vim /etc/swift/container-server.conf 
   76  ll
   77  vim object-server.conf 
   78  vi object-server.conf 
   79  vi container-server.conf 
   80  vi object-server.conf 
   81  systemctl restart openstack-swift*
   82  systemctl status openstack-swift*
   83  ll /srv/node/sdc/
   84  ll /srv/node/
   85  tail -f /var/log/swift/
   86  vim /etc/swift/swift.conf 
   87  systemctl restart openstack-swift*
   88  systemctl status openstack-swift*
   89  nestat -nap | grep 6200
   90  yum install netstat
   91  yum install telnet
   92  netsta
   93  yum install net-tools
   94  netstat
   95  netstat -nap
   96  netstat -nap | grep 6200
   97  netstat -nap | grep 6201
   98  netstat -nap | grep 6202
   99  sestatus
  100  systemctl status firewalld
  101  systemctl status openstack-swift*
  102  ll /srv/node/sdc
  103  ll /srv/node/
  104  chown -R root:swift /etc/swift
  105  systemctl restart openstack-swift*
  106  systemctl status openstack-swift*
  107  vim /etc/swift/object
  108  vim /etc/swift/object-server.conf 
  109  chown -R swift:swift /srv/node
  110  systemctl restart openstack-swift*
  111  systemctl status openstack-swift*
  112  ll /srv/node/sdc/
  113  ll /srv/node/
  114  reboot
  115  fdisk -l
  116  df -h
  117  history
