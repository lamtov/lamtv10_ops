Deploying Kolla on 100 node - Validation
========================================
Intro
------

This document summarizes my overall experience of deploying Openstack Kolla on 100 Node cluster, do's and dont's and overall results.

Environment
-----------

The cluster consists of both Dell and Lenovo bare metal servers. <br />
__Dell Server Specification:__ <br />
__RAM:__ 256GB <br />
__VCPUs:__ 48 VCPU <br />
__Disk:__ 600GB <br />

__Lenovo Server Specification:__ <br />
__RAM:__ 256GB <br />
__VCPUs:__ 48 VCPU <br />
__Disk:__ 600GB <br />

__Node Distribution:__ <br />
__Controller Nodes:__ 5 <br />
__Compute Nodes:__ 45 <br />
__Network Nodes:__ 15 <br />
__Storage Nodes:__ 20 <br />
__Monitoring Nodes:__ 15 <br />

__Services Deployed:__
Keystone, Nova, Cinder, Swift, Neutron, Glance, Heat, Horizon

Deployment Experience:
----------------------

#### Step 1: PXE Booting Server<br />
This step involves performing all the operation performed in:
[1-osic-provisioning.md](https://github.com/osic/ref-impl-kolla/blob/master/documents/1-osic-provisioning.md). This included creating host file for all 100 nodes and PXE booting using cobbler. <br />
__Approx. time taken: 2 hours 15 mins.__ 

__Do's and Dont's:__ <br />
1. Do make sure that the ethernet interfaces of each server matches the server type. <br />
2. Do not reboot the server without doing `cobbler sync`. <br />
3. Do not reboot the server without creating cobbler system profile.<br />
4. Do make sure that there is a DHCP entry of the server corresponds to the correct MAC address in case the server doesnt PXE boot.<br />

#### Step 2: Deploy Kolla<br />
Perform all the operations listed in [2-osic-inventory-docker-registry.md](https://github.com/osic/ref-impl-kolla/blob/master/documents/2-osic-inventory-docker-registry.md) for creation of docker registry and [3-osic-deploy-kolla.md](https://github.com/osic/ref-impl-kolla/blob/master/documents/3-osic-deploy-kolla.md) for deploying kolla.<br />

__Without custom ansible configuration__
__Approx. time taken for creating docker registry:__  1 min<br />
__Approx. time taken for preparing target host:__ 3 mins<br />
__Approx time taken for Building Kolla images and pushing into docker registry:__ 7 mins<br />

__Approx time taken for Deploying Kolla (Bootstraping + docker image pull + deploy):__ 4 hours <br />
__Total time: 4 hours 11 mins__<br />

__With custom ansible configuration__<br/>
__Forks:__ 100<br/>
__Pipelining:__ yes<br/>
__Approx time taken for Deploying Kolla (Bootstraping + docker image pull + deploy):__  17 minutes and 23 seconds <br />
__Total time: 29 minutes 23 seconds__<br />


__Do's and Dont's:__<br />
1. Do make sure that you reboot the server when kernel gets updated.<br />
2. Do make sure you are able to ssh as root into target host from deployment host before starting kolla deployment.<br />
3. Do not run cinder and swift before running bootstrap server.<br />


Overall Results:
----------------
Due to prebuilt docker images for almost all services, deploying kolla is fast, simple and straightforward.

Total Time: 6 hours 26 mins
---------------------------

Total Time with custom ansible configs: 2 hours 44 mins
-------------------------------------------------------
