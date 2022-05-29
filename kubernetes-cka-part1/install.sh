#!/bin/bash
echo off

apt-get purge kubeadm kubectl kubelet kubernetes-cni cri-tools  kube* -y
apt-get update && apt-get install kubeadm=1.23.7-00 kubelet=1.23.7-00 kubectl=1.23.7-00  -y --allow-downgrades >> /var/log/install
systemctl stop kubelet >> /var/log/install
crictl rm --all
kubectl delete node node01
kubeadm reset --force
rm ~/.kube/config
rm -r /etc/cni

ssh root@node01 "apt-get update && apt-get install kubeadm=1.23.7-00 kubelet=1.23.7-00 -y  --allow-downgrades && systemctl stop kubelet"  >> /var/log/install
ssh root@node01 "kubeadm reset --force"  >> /var/log/install
ssh root@node01 "crictl rm --all"
ssh root@node01 "rm -r /etc/cni"

# Start Kubernetes
#echo "Starting cluster"

source ~/.bashrc

echo "done" >> /opt/.clusterstarted