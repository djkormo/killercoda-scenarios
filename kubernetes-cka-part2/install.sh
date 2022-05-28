#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
#launch.sh
echo "done" >> /opt/.clusterstarted
date >> /opt/.clusterstarted

free_mem()
{
    awk '/MemFree/{print $2}' /proc/meminfo
}

free_time()
{
    uptime -p 
}

source ~/.bashrc


echo "done" >> /opt/.nodeupgraded
date >> /opt/.nodeupgraded

(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)


export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


## Installing metrics server 
# Documented here 
# https://thospfuller.com/2020/11/29/easy-kubernetes-metrics-server-install-in-minikube-in-five-steps/

#kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl apply -f https://gist.githubusercontent.com/thospfuller/d0d918e0b9fdb719a34d3d355b0886bb/raw/63fefb2d1cf31563db04c60f036d6661b5ec5ff2/components.yaml

