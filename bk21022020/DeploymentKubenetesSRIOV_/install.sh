install.sh
https://github.com/intel/sriov-network-device-plugin#quick-start
https://github.com/intel/sriov-network-device-plugin
https://github.com/intel/sriov-network-device-plugin#build-sriov-cni
https://github.com/intel/sriov-cni/#build
https://github.com/intel/sriov-network-device-plugin#build-and-run-sriov-network-device-plugin
https://stackoverflow.com/questions/52322840/how-to-delete-a-service-account-in-kubernetes/52323436


https://builders.intel.com/docs/networkbuilders/adv-network-features-in-kubernetes-app-note.pdf


/home/tupt18/multus-cni/images



$ git clone https://github.com/intel/sriov-cni.git
$ cd sriov-cni
$ make
$ cp build/sriov /opt/cni/bin


git clone https://github.com/intel/sriov-network-device-plugin.git
$ cd sriov-network-device-plugin
nfvpe/sriov-device-plugin:latest



  974  mkdir -p /root/work/src/golint
  975  cp golint /root/work/src/golint/
  976  go build golint
  977  go get golint
  978  go get -u golang.org/x/lint/golint
  979  ll /root/work/src
  980  ll /root/work/src/golint/
  981  ll
  982  go get github.com/wadey/gocovmerge
  983  go get github.com/axw/gocov/...
  984  go get github.com/AlekSi/gocov-xml
  985  go get github.com/tebeka/go2xunit
  986  ll /root/work/src/
  987  ll
  988  scp -r ./* root@172.16.29.194:/root/work/src
  989  ll /root/work/src/golint/
  990  ll
  991  cd /root/work/src/
  992  ll
  993  scp -r ./* root@172.16.29.194:/root/work/src/







/home/tupt18/sriov-network-device-plugin/deployments
kubectl delete serviceaccount -n kube-system sriov-device-plugin
 1055  ll
 1056  cd sriov-network-device-plugin/
 1057  ll
 1058  cd deployments/
 1059  ll
 1060  cd k8s-v1.16/
 1061  ll
 1062  vim sriovdp-daemonset.yaml 
 1063  cat sriovdp-daemonset.yaml 
 1064  ll
 1065  mkidr -p /root/work/src/
 1066  mkdir -p /root/work/src/
 1067  vim ../../deployments/configMap.yaml 
 1068  vim sriovdp-daemonset.yaml 
 1069  ll
 1070  cd ..
 1071  ll
 1072  kubectl create -f deployments/configMap.yaml
 1073  kubectl get net-attach-def
 1074  kubectl delete net-attach-def sriov-net1
 1075  kubectl get net-attach-def
 1076  kubectl create -f deployments/k8s-v1.16/sriovdp-daemonset.yaml
 1077  kubectl get serviceaccount --all-namespaces 
 1078  kubectl get serviceaccount --all-namespaces  | grep sriov
 1079  history


kubectl get net-attach-def sriov-net1  -o yaml

 1096  vim deployments/k8s-v1.16/sriovdp-daemonset.yaml 
 1097  ll  ll /opt/cni/bin/
 1098  ll
 1099  scp -r /opt/cni/bin/sriov  root@172.16.29.195:/opt/cni/bin/
 1100  scp -r /opt/cni/bin/sriov  root@172.16.29.198:/opt/cni/bin/
 1102  cd deployments/
 1103  ll
 1104  vim pod-tc1.yaml 
 1105  kubectl apply -f pod-tc1.yaml 
 1106  kubectl get pod
 1107  kubectl logs testpod1
 1108  kubectl describe pod/testpod1
 1109  kubectl exec testpod1
 1110  kubectl exec testpod1 op a
 1111  kubectl exec testpod1 ip a
 1112  kubectl exec testpod1 ifconfig
 1113  history





# delete namespace
https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/troubleshoot/ns_terminating.html




####
cpu, ram resource limit:
resources:
  requests:
    cpu: 50m
    memory: 50Mi
  limits:
    cpu: 100m
    memory: 100Mi

  request duoc dung tai thoi diem schedule con limit duoc dung tai thoi diem run time 
  Vi du nhu tren container can Node chay yeu cau co it nhat 50Mi va duoc su dung cua node chay nhieu nhat 100Mi



    Limit duoc set cho container:

  The limit cua pod bang tong limit cua cac container ben trong 
  $kyubectl get pods test -o=jsonpath='{.spec.containers[0].resources}' map[]

  $docker inspect 5c3af3101afb -f "{{.HostConfig.Memory}}"


CPU LIMIT: 50m voi m dai dien cho "thousandth of a core" nghia la container process can 50/1000 cua mot core (5%) vaf duoc cho phep su dung toi da 100/1000 (10%) Do do 2000m se la 2 full cores. 

  $docker inspect 472abbbbbbb --format '{{.HostConfig.CpuShares}} {{.HostConfig.CpuQuota}} {{.HostConfig.CpuPeriod}}' 
  Cac request se su dung cpu shares system. Cpu shares se chia moi core ve 1024 slices va dam bao rang moi process se nhan mot share cua slices do. Neu nhu  co 1024 slices va moi cua 2 process dat cpu.shares bang 512 thi moi se co mot nua available time. Tuy nhien Cpu shares system khong the enforce upper bounds. Neu mot process khong su dung phan share cua no thi other free. 




####
cpu-pins: 

https://builders.intel.com/docs/networkbuilders/cpu-pin-and-isolation-in-kubernetes-app-note.pdf

https://builders.intel.com/docs/networkbuilders/enhanced-platform-awareness-in-kubernetes-application-note.pdf


kube proxy


******************************************************** CPUPIN

CPU_PIN
vim /boot/efi/EFI/redhat/grub.cfg


   linuxefi /vmlinuz-0-rescue-a0666c0814c545a5942d052651e22908 root=/dev/mapper/rhel-root ro crashkernel=auto spectre_v2=retpoline rd.lvm.lv=rhel/root rd.lvm.lv=rhel/swap rhgb quiet default_hugepagesz=1G hugepagesz=1G hugepages=120 intel_iommu=on iommu=pt isolcpus=2-17,38-53,20-35,56-71
        initrdefi /initramfs-0-rescue-a0666c0814c545a5942d052651e22908.img

3-17,39-53,21-35,57-71


[root@compute02 ~]# cat /etc/sysctl.conf 
# sysctl settings are defined through files in
# /usr/lib/sysctl.d/, /run/sysctl.d/, and /etc/sysctl.d/.
#
# Vendors settings live in /usr/lib/sysctl.d/.
# To override a whole file, create a new file with the same in
# /etc/sysctl.d/ and put new settings there. To override
# only specific settings, add a file with a lexically later
# name in /etc/sysctl.d/ and put new settings there.
#
# For more information, see sysctl.conf(5) and sysctl.d(5).
vm.nr_hugepages = 210

----------------------------------------------------------------------------------
kubectl get cmk-nodereport controller03 -o json | less


[root@controller03 0]# cat ~/cmk.rc 
export CMK_PROC_FS='/proc'
export CMK_NUM_CORES=2
source ~/cmk.rc 



vim ~/bash.sh
for i in 1 2 ; do while : ; do :  ; done & done

[root@controller03 bin]# taskset -cp $$
pid 68752's current affinity list: 0,1,18-37,54-71

 taskset -pc 0,1 53


/opt/bin/cmk isolate --conf-dir=/etc/cmk --pool=exclusive  'bash ~/bash.sh'
/opt/bin/cmk isolate --conf-dir=/etc/cmk --pool=exclusive  'for i in 1 2 ; do while : ; do :  echo "lamtv10" ; done & done'


sysctl -w kernel.sched_rt_runtime_us=-1

/opt/bin/cmk isolate --conf-dir=/etc/cmk --pool=exclusive  'sudo chrt -r 1 python ~/loadf.py'


/opt/bin/cmk isolate --conf-dir=/etc/cmk --pool=exclusive 'tail -f /u01/docker/docker_log/glance/glance-api.log'



kill -9 `ps -ef | grep 'load.py' | awk '{print $2}'`


import psutil

psutil.cpu_count()

p = psutil.Process()
p.cpu_affinity()
p.cpu_affinity([32,3,39])

from multiprocessing import Pool

def f(x):
    # Put any cpu (only) consuming operation here. I have given 1 below -
    while True:
        x * x

# decide how many cpus you need to load with.
no_of_cpu_to_be_consumed = 2

p = Pool(processes=no_of_cpu_to_be_consumed)
p.map(f, range(no_of_cpu_to_be_consumed))


2 20 38 56




###################

 docker run   --privileged    -it docker-registry:4000/horizon_v2:q sysctl -w kernel.sched_rt_runtime_us=-1 | chrt -f 1 whoami



kubectl delete  pod client-pin-lamtv10 -n cmk-namespace
kubectl apply  -f  client-pin.yaml 
kubectl get pod -n cmk-namespace

sysctl -a | grep sched_rt_runtime_us


--allowed-unsafe-sysctls='kernel.sched_rt_runtime_us' 



cat /proc/33157/cmdline 

kubectl get cmk-nodereport compute03 -o json | less

 vim /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf 


=========================>>>>
Solution: https://access.redhat.com/solutions/2884991
https://serverfault.com/questions/573025/taskset-not-working-over-a-range-of-cores-in-isolcpus
https://github.com/intel/CPU-Manager-for-Kubernetes/issues/244
https://github.com/moby/moby/issues/31086



def isolcpus():
    with open(os.path.join(proc.procfs(), "cmdline")) as f:
        return parse_isolcpus(f.read())


# Returns list of isolated cpu ids from /proc/cmdline content.
def parse_isolcpus(cmdline):
    cpus = []

    # Ensure that newlines are removed.
    cmdline_stripped = cmdline.rstrip()

    cmdline_fields = cmdline_stripped.split()
    for cmdline_field in cmdline_fields:
        pair = cmdline_field.split("=")
        if len(pair) != 2:
            continue

        key = pair[0]
        value = pair[1]

        if key == "isolcpus":
            cpus_str = value.split(",")
            cpus += parse_cpus_from_isolcpus(cpus_str)

    # Get unique cpu_ids from list
    cpus = list(set(cpus))
    return cpus

print(islcpus())



https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-api/