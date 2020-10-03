https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

1. Install Docker
vim /etc/docker/daemon.json
{
        "insecure-registries" : ["localhost:5000","127.0.0.1:5000","172.21.3.83:5000","docker-local:5000", "172.16.30.228:5000"],
        "debug" : true,
        "experimental" : true,

 "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]


}
systemctl daemon-reload
systemctl restart docker 

#############################

Identify configured swap devices and files with cat /proc/swaps.
Turn off all swap devices and files with swapoff -a.
Remove any matching reference found in /etc/fstab.




systemctl stop firewalld
systemctl stop iptables

setenforce 0
vim  /etc/selinux/config
SELINUX=disabled
SELINUXTYPE=targeted


###########################
systemctl -p 
sestatus

cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system


#########################

2. Install K8s
$ sudo apt-get install curl -y
$ sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"


$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add


$ sudo apt-get install kubeadm kubelet kubectl -y

------------------------------------------------------------------------
## assign specic hostnames to each server

$ sudo hostnamectl set-hostname HOSTNAME

Log out and log back in. Finally map hostnames to IP addresses. For this, open the hosts
file for editing with the command:

In order to run Kubernetes, you must first disable swap.
$ sudo swapoff -a

To make that permanent (otherwise, swap will re-enable at reboot), issue the command:
$ sudo nano /etc/fstab

In the fstab file, comment out the swap entry, as shown in Figure 1:

------------------------------------------------------------






Initializing the Master

The next step is to initialize your master. To do this, issue the command:

$ kubeadm reset

$ kubeadm init --image-repository docker-registry:4000/k8s.gcr.io --pod-network-cidr=10.244.0.0/16

$ kubectl get nodes 
$ kubectl get pod --all-namespaces -o wide
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config





Make sure to switch out the IP address of your master in the above command.


When the initialization completes, you will be given the precise command used to join the
nodes to the master:

$ kubeadm join

$ kubeadm token create --print-join-command

Example:
kubeadm join 172.16.29.194:6443 --token 6j7d5u.pim2s3pbzrsjmhx0 --discovery-token-ca-cert-hash sha256:53de72e7109e6d6928fc47beb32ecd53a71a1eb5a93b40d62695d65f4c7cacb6


On the master only, create a directory for the cluster with the command:
$ mkdir -p $HOME/.kube

$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

$ sudo chown $(id -u):$(id -g) $HOME/.kube/config



 1000  route -n
 1001  ping 172.16.30.191
 1002  route -n
 1003  ssh root@172.16.30.191
 1004  telnet 172.16.30.191 22
 1005  arp --help
 1006  arp -an
 1007  arp -anv
 1008  ifconfig 
 1009  ifconfig | grep 193
 1010  ping 172.16.30.191
 1011  ip a | grep 193
 1012  ping 172.16.30.191
 1013  traceroute 172.16.30.191
 1014  route -n
 1015  ifconfig eno2.0
 1016  ifconfig eno2.8
 1017  ip route add
 1018  ip route add 172.16.30.0/24 dev eno1
 1019  route -n
 1020  ping 172.16.30.191
 1021  ping google.com
 1022  ssh root@172.16.30.191
 1023  cd /etc/ansible/



 1010  conda install -c anaconda numpy
 conda install -c anaconda flask
 1011  conda install -c anaconda pymysql
 1012  conda install -c conda-forge flask-restplus
 1013  conda install -c conda-forge ansible 
 1014  conda install -c anaconda configparser
 1015  conda install -c anaconda sqlalchemy 
 1016  conda install -c conda-forge flask-sqlalchemy
 1017  conda install -c conda-forge flask-migrate
 1018  conda install -c anaconda flask-login
 1019  conda install -c conda-forge pytest
 1020  conda install -c conda-forge flask-wtf
 1021  pip install yamlreader
 1022  pip install Flask-Session
 1023  conda install -c conda-forge packaging
 1024  conda install -c conda-forge fabric
 1025  conda info
 1026  python
 1027  conda info
 1028  history



################################# Cai flannel.yaml
vim flannel.yaml 
 containers:
      - name: kube-flannel
        image: 172.16.30.228:5000/quay.io/coreos/flannel:v0.11.0-amd64
        command:
        - /opt/bin/flanneld
        args:
        - --ip-masq
        - --kube-subnet-mgr
        - --iface=bond1


kubectl apply -f flannel.yaml
kubectl get node
kubectl get pod --all-namespaces -o wide
Tai thoi diem nay Node moi o trang thai ready va cac dns moi hoat dong 



################################# Tren cac worker node 
kubeadm reset
rm -rf /etc/cni/net.d
rm -rf  $HOME/.kube/config
kubeadm join 172.16.30.57:6443 --token tsw73y.69xyyydcy1wjfxah     --discovery-token-ca-cert-hash sha256:8ac34af983f8e66d638882df1f384a7614ca294d0ad7d0569d1b9c6a4a02c091

ifconfig flannel1.1 

route -n 

Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         172.16.29.254   0.0.0.0         UG    100    0        0 eno1
10.10.1.0       0.0.0.0         255.255.255.0   U     0      0        0 ens2f0
10.244.0.0      0.0.0.0         255.255.255.0   U     0      0        0 cni0
10.244.1.0      10.244.1.0      255.255.255.0   UG    0      0        0 flannel.1
10.244.2.0      10.244.2.0      255.255.255.0   UG    0      0        0 flannel.1
172.16.29.0     0.0.0.0         255.255.255.0   U     100    0        0 eno1
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
192.168.122.0   0.0.0.0         255.255.255.0   U     0      0        0 virbr0


tcpdump -i bond0 -vvvv
tcpdump -i bond0 icmp  #### Loc ra tat ca cac tin PING


