#!/bin/bash
echo off
apt-get purge kubeadm kubectl kubelet kubernetes-cni kube* -y
apt-get update && apt-get install kubeadm=1.23.1-00 kubelet=1.23.1-00 kubectl=1.23.1-00  -y --allow-downgrades >> /var/log/install
systemctl stop kubelet >> /var/log/install
kubectl delete node node01
kubeadm reset --force


kubeadm reset # on debian base sudo 
apt-get purge kubeadm kubectl kubelet kubernetes-cni kube* #on centos basesudo yum remove kubeadm kubectl kubelet kubernetes-cni kube*# on debian basesudo apt-get autoremove#on centos basesudo yum autoremove sudo rm -rf ~/.kube

rm ~/.kube/config
ssh root@node01 "apt-get update && apt-get install kubeadm=1.23.1-00 kubelet=1.23.1-00 -y  --allow-downgrades && systemctl stop kubelet"  >> /var/log/install
ssh root@node01 "kubeadm reset --force"  >> /var/log/install

# Start Kubernetes
echo "Starting cluster"

source ~/.bashrc

echo "done" >> /opt/.clusterstarted