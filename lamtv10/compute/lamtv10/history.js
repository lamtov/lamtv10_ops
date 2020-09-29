history

 chown -R vt_admin:vt_admin new_ops/
  290  ll
  291  cd new_ops/
  292  ll
  293  pwd
  294  ll
  295  chown -R root:root ops_ssl/
  296  ll
  297  ip addr show
  298  ll
  299  cd ops_ssl/lamtv101209/docker/
  300  ll
  301  cd keystone/
  302  ll
  303  ll
  304  cd /usr/share/docker/keystone/
  305  ll
  306  cd keystone/
  307  ll
  308  mv keystone.conf keystone.conf.bk
  309  ll
  310  cd /usr/share/docker/keystone/
  311  ll
  312  cd keystone/
  313  ll
  314  ip addr show
  315  docker ps -a
  316  docker stop keystone
  317  ll
  318  cd /u01/setup/lamtv10/n
  319  cd /u01/setup/lamtv10/
  320  ll
  321  cd new_ops/
  322  ll
  323  cd ops_ssl/
  324  ll
  325  cd lamtv101209/
  326  ll
  327  cd docker/
  328  ll
  329  cd keystone/
  330  ll
  331  cd keystone/
  332  ll
  333  cp ./*  /usr/share/docker/keystone/keystone/
  334  cp -r  ./*  /usr/share/docker/keystone/keystone/
  335  docker images
  336  docker run  -d --name ssl_keystone --network=host  -u root -v /u01/docker/docker_log/apache2:/var/log/apache2 -v /etc/keystone/credential-keys:/etc/keystone/credential-keys -v /etc/keystone/fernet-keys:/etc/keystone/fernet-keys -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime   -e KEYSTONE_START='START_KEYSTONE' docker-registry:4000/ssl_keystone_v1:q
  337  docker ps -a
  338  curl https
  339  curl https://o3.controller:5000
  340  vim /etc/hosts
  341  curl https://o3.controller:5000
  342  netstat -nap | grep 5000
  343  mysql
  344  vim ~/open.rc
  345  vim /etc/hosts
  346  source ~/open.rc
  347  openstack endpoint list
  348  source ~/open.rc
  349  vim ~/open.rc
  350  source ~/open.rc
  351  openstack endpoint list
  352  mysql
  353  source ~/open.rc
  354  openstack endpoint list --debug
  355  ll
cd /u01/setup/lamtv10/n
  357  cd /u01/setup/lamtv10/
  358  ll
  359  cd new_ops/ops_ssl/
  360  ll
  361  cd lamtv101209/docker/glance/
  362  ll
  363  cd glance/
  364  ll
  365  cp ./* /usr/share/docker/glance/glance/
  366  cp -r  ./* /usr/share/docker/glance/glance/
  367  ll
  368  cd ..
  369  ll
  370  cd ..
  371  ll
  372  cd nova/
  373  ll
  374  cd nova
  375  ll
  376  cp -r f /usr/share/docker/nova/nova/
  377  cp -r ssl/ /usr/share/docker/nova/nova/
  378  ll
  379  cd ..
  380  ll
  381  cd ..
  382  ll
  383  cd neutron/
  384  ll
  385  cd neutron/
  386  ll
  387  cp -r ssl/ /usr/share/docker/neutron/neutron/
  388  cp -r metadata_agent.ini /usr/share/docker/neutron/neutron/
  389  cp -r neutron.conf /usr/share/docker/neutron/neutron/
  390  ll
  391  cd ..
  392  ll
  393  cd ..
  394  ll
  395  cd cinder/
  396  ll
  397  cd cinder/
  398  ll
  399  cp ./* /usr/share/docker/cinder/cinder/
  400  cp -r  ./* /usr/share/docker/cinder/cinder/
  401  cd /u01/setup/lamtv10/
  402  ll
  403  cd ..
  404  ll
  405  cd ..
  406  ll
  407  cd setup/lamtv10/new_ops/
  408  ll
  409  cd ops_ssl/
  410  ll
  411  cd lamtv101209/
  412  ll
  413  cd docker/
  414  ll
  415  source ~/open.rc
  416  tail -f /u01/docker/docker_log/nova/nova-api.log
  417  vim /usr/share/docker/nova/nova/nova.conf
  418  cd /u01/setup/lamtv10/new_ops/ops_ssl/
  419  ll
  420  cp haproxy/haproxy.cfg /etc/haproxy/
  421  cd /usr/share/docker/
  422  ll
  423  cd glance/
  424  ll
  425  cd glance/
  426  ll
  427  mv glance-api.conf  glance-api.conf.bk
  428  mv glance-registry.conf glance-registry.conf.bk
  429  ll
  430  vim glance-api.conf
  431  vim glance-registry.conf
  432  ll
  433  docker run -d --name ssl_glance-api --network=host --restart unless-stopped -v /u01/docker/docker_log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_API' docker-registry:4000/ssl_glance_v1:q
  434  docker run -d --name ssl_glance-registry --network=host --restart unless-stopped -v /u01/docker/docker_log/glance:/var/log/glance -v /var/lib/glance:/var/lib/glance -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u glance -e GLANCE_START='START_GLANCE_REGISTRY' docker-registry:4000/ssl_glance_v1:q
  435  docker ps -a
  436  docker stop glance-registry
  437  docker stop glance-api
  438  docker restart ssl_glance-registry ssl_glance-api
  439  docker ps -a
  440  docker stop cinder-scheduler cinder-api nova-placement-api nova-novncproxy nova-consoleauth horizon nova-api nova-conductor neutron-server nova-scheduler
  441  docker ps -a
  442  cd ../../nova/nova
  443  ll
  444  mv nova.conf nova.conf.bk
  445  ll
  446  docker run -d --name ssl_nova-consoleauth --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_CONSOLEAUTH' docker-registry:4000/ssl_nova_v1:q
  447  docker run -d --name ssl_nova-api --network=host --privileged --restart unless-stopped -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_API' docker-registry:4000/ssl_nova_v1:q
  448  docker run -d --name ssl_nova-scheduler --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_SCHEDULER' docker-registry:4000/ssl_nova_v1:q
  449  docker run -d --name ssl_nova-conductor --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_CONDUCTOR' docker-registry:4000/ssl_nova_v1:q
  450  docker run -d --name ssl_nova-novncproxy --network=host --restart unless-stopped --privileged -u nova -v /u01/docker/docker_log/nova:/var/log/nova -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_NOVNCPROXY' docker-registry:4000/ssl_nova_v1:q
  451  docker run -d --name ssl_nova-placement-api --network=host --restart unless-stopped --privileged -u root -v /u01/docker/docker_log/apache2:/var/log/apache2 -v /u01/docker/docker_log/nova/:/var/log/nova/ -v /var/lib/nova:/var/lib/nova -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NOVA_START='START_NOVA_PLACEMENT_API' docker-registry:4000/ssl_nova_v1:q
  452  docker ps -a
  453  vim nova.conf
  454  cd ../../neutron/
  455  ll
  456  cd neutron/plugins/
 ll
  458  cd ..
  459  ll
  460  mv neutron.conf neutron.conf.bk
  461  mv metadata_agent.ini metadata_agent.ini.bk
  462  vim dhcp_agent.ini
  463  vim metadata_agent.ini.bk
  464  ll
  465  vim neutron.conf
  466  docker ps -a
  467  docker run -d --name ssl_neutron-server --network=host --restart unless-stopped --privileged -v /u01/docker/docker_log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u neutron -e NEUTRON_START='START_NEUTRON_SERVER'  docker-registry:4000/ssl_neutron_v1:q
  468  docker ps -a
  469  docker logs ssl_neutron-server
  470  ll
  471  vim plugins/ml2/ml2_conf_sriov.ini
  472  docker ps -a
  473  docker restart ssl_neutron-server
  474  docker ps -a
  475  ll
  476  cd ..
  477  cd cinder/
  478  ;;
  479  ll
  480  cd cinder/
  481  ll
  482  mv cinder.conf cinder.conf.bk
  483  ll
  484  vim cinder.conf
  485  ll
  486  vim cinder
  487  ll
  488  docker run -d --name ssl_cinder-api --network=host --restart unless-stopped -v /u01/docker/docker_log/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder -v $VAR_LOG_DIR/apache2:/var/log/apache2  -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e CINDER_START='START_CINDER_API' docker-registry:4000/ssl_cinder_api_v1:q
  489  docker run -d --name ssl_cinder-scheduler --network=host --restart unless-stopped -v /u01/docker/docker_log/cinder:/var/log/cinder -v /var/lib/cinder:/var/lib/cinder -v /var/log/apache2:/var/log/apache2  -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -u root -e CINDER_START='START_CINDER_SCHEDULER' docker-registry:4000/ssl_cinder_scheduler_v1:q
  490  docker ps -a
  491  cd /etc/httpd/
  492  ll
  493  cd conf.d/
  494  ll
  495  vim glance_api.conf
  496  vim neutron.conf
  497  vim nova_api.conf
  498  vim nova_metadata.conf
  499  vim nova_placement_api.conf
  500  vim nova_vnc.conf
  501  ll
  502  ll
  503  cat glance_api.conf
  504  cat neutron.conf
  505  ll
  506  cat nova_api.conf
  507  cat nova_metadata.conf
  508  cat nova_placement_api.conf
  509  cat nova_vnc.conf
  510  systemctl restart httpd
  511  systemctl status httpd
  512  source ~/open.rc
  513  openstack host list --debug
  514  curl https://os.controller:8774
  515  netstat -nap | grep 8774
  516  systemctl stop haproxy.service
  517  netstat -nap | grep 8774
  518  docker ps -a
  519  systemctl stop httpd
  520  netstat -nap | grep 8774
  521  curl http://127.0.0.1:8774
  522  ll
  523  cd /usr/share/docker/nova/
  524  ll
  525  vim nova
  526  cd nova
  527  vim nova.confo
  528  vim nova.conf
  529  vim /etc/hosts
  530  tail -f /u01/docker/docker_log/nova/nova-api.log
  531  netstat -nap | grep 8774
  532  vim /etc/hosts
  533  docker ps -a
  534  docker restart nova-api
  535  netstat -nap | grep 8774
  536  curl http://127.0.0.1:8774
  537  docker stop nova-api
  538  curl http://127.0.0.1:8774
  539  docker ps -a
  540  docker restart ssl_nova-api
  541  netstat -nap | grep 8774
  542  curl http://127.0.0.1:8774
  543  tail -f /u01/docker/docker_log/nova/nova-api.log
  544  netstat -nap | grep 8774
  545  curl http://::1:8774
  546  vim /etc/hosts
  547  docker restart ssl_nova-api
  548  netstat -nap | grep 8774
  549  curl http://::1:8774
  550  curl http://127.0.0.1:8774
  551  ll
  552  vim nova.conf
  553  docker restart ssl_nova-api
  554  curl http://127.0.0.1:8774
  555  ll
  556  cd ..
  557  ll
  558  cd ..
  559  ll
  560  vim cinder/cinder/cinder.conf
  561  vim glance/glance/glance-api.conf
  562  vim glance/glance/glance-registry.conf
  563  ll
  564  vim keystone/keystone/keystone.conf
  565  vim neutron/neutron/neutron.conf
  566  ll
  567  docker ps -a
  568  docker restart ssl_neutron-server ssl_nova-placement-api ssl_nova-novncproxy ssl_nova-conductor ssl_nova-scheduler ssl_nova-api ssl_nova-consoleauth ssl_glance-registry ssl_glance-api
  569  systemctl restart httpd
  570  source ~/open.rc
  571  openstack host list
  572  openstack user list
  573  vim ~/open.rc
  574  source ~/open.rc
  575  openstack endpoint list
  576  curl https://os.controller:5000
  577  openstack endpoint list --debug
  578  vim /etc/hosts
  579  ll
  580  docker ps -a
  581  docker restart ssl_keystone
  582  openstack endpoint list --debug
  583  openstack user list
  584  openstack hostl ist
  585  openstack host list
  586  openstack image list --debug
  587  openstack volume list --debug
  588  curl https://os.controller:8774
  589  curl http://127.0.0.1:8774
  590  openstack volume list --debug
  591  curl https://os.controller:8774/v2.1/servers/detail
  592  openstack  host  list --debug
  593  vim /etc/hosts
  594  cd /etc/haproxy/
  595  ll
  596  mv haproxy.cfg haproxy.cfg.bk
  597  ll
  598  vim haproxy.cfg
  599  systemctl restart haproxy.service
  600  ll
  601  systemctl restart haproxy.service
602  ip addr show
  603  vim /etc/hosts
  604  source ~/open.rc
  605  openstack endpoint list
  606  openstack image list
  607  openstack volume list
  608  openstack host list
  609  openstack hypervisor list
931  source ~/open.rc
  932  openstack network agent list --debug
  933  openstack endpoint list --debug
  934  cd /usr/share/docker/horizon/
  935  ll
  936  cat openstack-dashboard/local_settings.py
  937  :q
  938  docker images
  939  docker run -d --name ssl_horizon --network=host --restart unless-stopped -u root -v /u01/docker/docker_log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e HORIZON_START='START_HORIZON' docker-registry:4000/ssl_horizon_v1:q
  940  docker ps a-
  941  docker ps -a
  942  curl https://os.controller:443
  943  docker logs ssl_horizon
  944  tail -f /u01/docker/docker_log/apache2/horizon
  945  tail -f /u01/docker/docker_log/apache2/horizon.log
  946  date
  947  tail -f /u01/docker/docker_log/apache2/error.log
  948  docker ps -a
  949  docker exec -it ssl_horizon bash
  950  netstat -nap | grep 443
  951  ll
  952  docker ps -a
  953  ll
  954  vim apache2/conf-enabled/openstack-dashboard.conf
9  cd horizon/
  960  ll
  961  netstat -nap | grep 80
  962  docker ps -a
  963  docker stop ssl_horizon
  964  docker rm ssl_horizon
  965  ll
  966  mkdir horizon_bk
  967  mv ./* horizon_bk/
  968  ll
  969  cd ..
  970  ll
  971  cd /u01/setup/lamtv10/new_ops/ops_ssl/
  972  ll
  973  cd lamtv101209/
  974  ll
  975  cd docker/horizon/
  976  ll
  977  cp -r ./* /usr/share/docker/horizon/
  978  cd /usr/share/docker/horizon/
  979  ll
  980  vim apache2/conf-enabled/openstack-dashboard.conf
  981  docker run -d --name ssl_horizon --network=host --restart unless-stopped -u root -v /u01/docker/docker_log/apache2:/var/log/apache2 -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e HORIZON_START='START_HORIZON' docker-registry:4000/ssl_horizon_v1:q
  982  netstat -nap | grep 443
  983  curl https://os.controller:443
  984  firefox
  985  tail -f /u01/docker/docker_log/nova/nova-api.log
  986  ll
  987  cd ~
  988  ll
  989  source ~/open.rc
  990   nova boot --flavor 4C4R4G --nic net-id=99acf64a-c858-4378-8816-99b01c80aa84    --key-name lamtv10 --image  48d00dc6-eecf-42d6-900f-c27028a51f19  --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=1 --availability-zone nova:SPGM01DRCOMP2 lamtv_test_ssl
  991   nova --debug boot --flavor 4C4R4G --nic net-id=99acf64a-c858-4378-8816-99b01c80aa84    --key-name lamtv10 --image  48d00dc6-eecf-42d6-900f-c27028a51f19  --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=1 --availability-zone nova:SPGM01DRCOMP2 lamtv_test_ssl




10.61.64.216		ucttocs3		8023
ssh vt_admin@10.255.26.130
 
10.255.26.100	vt_admin	SPGM01DRctrl01#2@19	root	SPGM01drCTRL01#2@19	SPGM01DRCTRL01	   
10.255.26.101	vt_admin	SPGM01DRctrl02#2@19	root	SPGM01drCTRL02#2@19	SPGM01DRCTRL02	   
10.255.26.103	vt_admin	SPGM01DRctrl03#2@19	root	SPGM01drCTRL03#2@19	SPGM01DRCTRL03	   
10.255.26.72s	vt_admin	SPGM01DRcomp1#2@19	root	SPGM01drCOMP1#2@19	SPGM01DRCOMP1	   
10.255.26.73s	vt_admin	SPGM01DRcomp2#2@19	root	SPGM01drCOMP2#2@19	SPGM01DRCOMP2	   
10.255.26.74s	vt_admin	SPGM01DRcomp3#2@19	root	SPGM01drCOMP3#2@19	SPGM01DRCOMP3	   
10.255.26.75s	vt_admin	SPGM01DRcomp4#2@19	root	SPGM01drCOMP4#2@19	SPGM01DRCOMP4	   
10.255.26.76s	vt_admin	SPGM01DRcomp5#2@19	root	SPGM01drCOMP5#2@19	SPGM01DRCOMP5	   
10.255.26.77s	vt_admin	SPGM01DRcomp6#2@19	root	SPGM01drCOMP6#2@19	SPGM01DRCOMP6	   
10.255.26.78s	vt_admin	SPGM01DRcomp7#2@19	root	SPGM01drCOMP7#2@19	SPGM01DRCOMP7	   
10.255.26.79s	vt_admin	SPGM01DRcomp8#2@19	root	SPGM01drCOMP8#2@19	SPGM01DRCOMP8	   
10.255.26.80s	vt_admin	SPGM01DRcomp9#2@19	root	SPGM01drCOMP9#2@19	SPGM01DRCOMP9	   
10.255.26.81s	vt_admin	SPGM01DRcomp10#2@19	root	SPGM01drCOMP10#2@19	SPGM01DRCOMP10	   
10.255.26.82s	vt_admin	SPGM01DRcomp11#2@19	root	SPGM01drCOMP11#2@19	SPGM01DRCOMP11	   
10.255.26.83s	vt_admin	SPGM01DRcomp12#2@19	root	SPGM01drCOMP12#2@19	SPGM01DRCOMP12	   
10.255.26.84s	vt_admin	SPGM01DRcomp13#2@19	root	SPGM01drCOMP13#2@19	SPGM01DRCOMP13	   
10.255.26.85s	vt_admin	SPGM01DRcomp14#2@19	root	SPGM01drCOMP14#2@19	SPGM01DRCOMP14	   
10.255.26.86s	vt_admin	SPGM01DRcomp15#2@19	root	SPGM01drCOMP15#2@19	SPGM01DRCOMP15	   
10.255.26.87s	vt_admin	SPGM01DRcomp16#2@19	root	SPGM01drCOMP16#2@19	SPGM01DRCOMP16	   
10.255.26.88s	vt_admin	SPGM01DRcomp17#2@19	root	SPGM01drCOMP17#2@19	SPGM01DRCOMP17	   
10.255.26.89s	vt_admin	SPGM01DRcomp18#2@19	root	SPGM01drCOMP18#2@19	SPGM01DRCOMP18	   
10.255.26.90s	vt_admin	SPGM01DRcomp19#2@19	root	SPGM01drCOMP19#2@19	SPGM01DRCOMP19	   
10.255.26.91s	vt_admin	SPGM01DRcomp20#2@19	root	SPGM01drCOMP20#2@19	SPGM01DRCOMP20	   
10.255.26.92 f2	vt_admin	SPGM01DRcomp21#2@19	root	SPGM01drCOMP21#2@19	SPGM01DRCOMP21	   
10.255.26.93 f1	vt_admin	SPGM01DRcomp22#2@19	root	SPGM01drCOMP22#2@19	SPGM01DRCOMP22	   
10.255.26.94	vt_admin	SPGM01DRcomp23#2@19	root	SPGM01drCOMP23#2@19	SPGM01DRCOMP23	   
10.255.26.95	vt_admin	SPGM01DRcomp24#2@19	root	SPGM01drCOMP24#2@19	SPGM01DRCOMP24	   
10.255.26.96	vt_admin	SPGM01DRcomp25#2@19	root	SPGM01drCOMP25#2@19	SPGM01DRCOMP25	   
10.255.26.97	vt_admin	SPGM01DRcomp26#2@19	root	SPGM01drCOMP26#2@19	SPGM01DRCOMP26	   
10.255.26.98	vt_admin	SPGM01DRcomp27#2@19	root	SPGM01drCOMP27#2@19	SPGM01DRCOMP27	   
10.255.26.99	vt_admin	SPGM01DRcomp28#2@19	root	SPGM01drCOMP28#2@19	SPGM01DRCOMP28	 

select * from keystone.endpoint order by url;
UPDATE keystone.endpoint SET url="https://os.controller:5000/v3" WHERE url="http://os-controller:5000/v3";
