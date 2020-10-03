#!/bin/bash



scp -r root@10.255.26.72:/u01/setup/neutron_5_4 /u01/setup
#cd /u01/setup/neutron_5_4
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#cd ${DIR}
#Import source
source /u01/setup/neutron_5_4/etc_hosts.env

sed -i "s|MY_CPT_IP_FROM_HOST_NAME|${COMPUTE_IP[`hostname`]}|g"   /u01/setup/neutron_5_4/neutron.conf
sed -i "s|MY_CPT_IP_FROM_HOST_NAME|${COMPUTE_IP[`hostname`]}|g"  /u01/setup/neutron_5_4/openvswitch_agent.ini
sed -i "s|MY_CPT_IP_FROM_HOST_NAME|${COMPUTE_IP[`hostname`]}|g"   /u01/setup/neutron_5_4/nova.conf
cp /u01/setup/neutron_5_4/neutron.conf /usr/share/docker/neutron/neutron/neutron.conf
cp /u01/setup/neutron_5_4/openvswitch_agent.ini  /usr/share/docker/neutron/neutron/plugins/ml2/openvswitch_agent.ini
cp /u01/setup/neutron_5_4/nova.conf /etc/nova/nova.conf 
cp /u01/setup/neutron_5_4/libvirtd.conf  /etc/libvirt/libvirtd.conf 
cp /u01/setup/neutron_5_4/sysconfig/libvirtd   /etc/sysconfig/




docker pull docker-registry:4000/neutron_dpdk:q


docker stop ovs-agent
docker stop dhcp-agent
docker stop metadata-agent
docker rm metadata-agent
docker rm ovs-agent
docker rm dhcp-agent
#detailtask "+Create container ovs-agent dhcp-agent metadata-agent\n"
docker run -d --name ovs-agent --network=host --privileged --user neutron -v /u01/docker/docker_log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_OVS_AGENT'   docker-registry:4000/neutron_dpdk:q

docker run -d --name dhcp-agent --network=host  --privileged --user neutron -v /u01/docker/docker_log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run:/run:shared -v /run/netns:/run/netns:shared -v /run/openvswitch:/run/openvswitch -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_DHCP_AGENT' docker-registry:4000/neutron_dpdk:q
# --restart unless-stopped
docker run -d --name metadata-agent --network=host  --privileged --user neutron -v /u01/docker/docker_log/neutron:/var/log/neutron -v /var/lib/neutron:/var/lib/neutron -v /run/netns:/run/netns:shared -v /usr/share/docker/:/usr/share/docker/ -v /etc/localtime:/etc/localtime -e NEUTRON_START='START_NEUTRON_METADATA_AGENT' docker-registry:4000/neutron_dpdk:q


systemctl restart libvirtd openstack-nova-compute


ovs-ofctl add-flow br-mpbn in_port=enp98s0f1,action=pop_vlan,NORMAL
ovs-ofctl add-flow br-mpbn in_port=enp220s0f1,action=pop_vlan,NORMAL
ovs-ofctl add-flow br-linksite in_port=enp103s0f1,action=pop_vlan,NORMAL
ovs-ofctl add-flow br-linksite in_port=enp225s0f1,action=pop_vlan,NORMAL
ovs-ofctl add-flow br-sigtran1 in_port=enp98s0f2,action=pop_vlan,NORMAL
ovs-ofctl add-flow br-sigtran1 in_port=enp220s0f2,action=pop_vlan,NORMAL
ovs-ofctl add-flow br-sigtran2 in_port=enp103s0f0,action=pop_vlan,NORMAL
ovs-ofctl add-flow br-sigtran2 in_port=enp225s0f0,action=pop_vlan,NORMAL
ovs-ofctl add-flow br-dcn in_port=enp98s0f3,action=pop_vlan,NORMAL
ovs-ofctl add-flow br-dcn in_port=enp220s0f3,action=pop_vlan,NORMAL



ovs-ofctl dump-flows br-mpbn


cat /proc/mounts  | wc -l


#scp -r root@10.255.26.72:/u01/setup/neutron_5_4/run.sh ./
#bash run.sh
