#!/usr/bin/env bash

echo "test"

apt-get update && apt-get install kubeadm=1.23.1-00 kubelet=1.23.1-00 -y --allow-downgrades
systemctl restart kubelet
kubeadm reset 
rm ~/.kube/config

ssh root@[[host2]] "apt-get update && apt-get install kubeadm=1.23.1-00 kubelet=1.23.1-00 -y  --allow-downgrades && systemctl restart kubelet"  >> /var/log/install
