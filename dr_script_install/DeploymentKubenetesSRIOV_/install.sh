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



cpu-pins: 

https://builders.intel.com/docs/networkbuilders/cpu-pin-and-isolation-in-kubernetes-app-note.pdf

https://builders.intel.com/docs/networkbuilders/enhanced-platform-awareness-in-kubernetes-application-note.pdf


kube proxy




CPU_PIN
vim /boot/efi/EFI/redhat/grub.cfg





