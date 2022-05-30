https://devopstales.github.io/home/migrate-docker-to-crio/
https://computingforgeeks.com/deploy-kubernetes-cluster-on-ubuntu-with-kubeadm/



systemctl stop kubelet
crictl rmi --all
kubeadm reset --force
rm ~/.kube/config
rm -r /etc/cni
rm -r /opt/cni/bin
apt-get purge kubeadm kubectl kubelet kubernetes-cni docker.io kube* -y

VERSION=1.24
OS=xUbuntu_20.04
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list

curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key | apt-key add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | apt-key add -

apt-get update
apt-get install cri-o cri-o-runc -y


systemctl enable --now crio
#systemctl status crio

apt-get update && apt-get install kubeadm=1.23.7-00 kubelet=1.23.7-00 kubectl=1.23.7-00  -y --allow-downgrades





crictl ps

echo "runtime-endpoint: unix:///var/run/crio/crio.sock" > /etc/crictl.yaml
crictl ps

# Start cri-o
systemctl enable --now crio
systemctl status crio