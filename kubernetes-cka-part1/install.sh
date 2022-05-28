#!/bin/bash
echo off
apt-get update && apt-get install kubeadm=1.23.1-00 kubelet=1.23.1-00 -y && systemctl restart kubelet  >> /var/log/install
systemctl restart kubelet >> /var/log/install

ssh root@[[host2]] "apt-get update && apt-get install kubeadm=1.23.1-00 kubelet=1.23.1-00 -y && systemctl restart kubelet"  >> /var/log/install

# Start Kubernetes
echo "Starting cluster"

source ~/.bashrc

echo "done" >> /opt/.clusterstarted