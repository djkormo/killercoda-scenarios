#!/usr/bin/env bash

echo "test"
apt-get purge kubeadm kubectl kubelet kubernetes-cni kube* -y
apt-get update && apt-get install kubeadm=1.23.7-00 kubelet=1.23.7-00 kubectl=1.23.7-00 -y --allow-downgrades
systemctl stop kubelet
crictl rm --all
kubeadm reset --force
rm ~/.kube/config

ssh root@node01 "apt-get update && apt-get install kubeadm=1.23.7-00 kubelet=1.23.7-00 -y  --allow-downgrades && systemctl stop kubelet"  >> /var/log/install
