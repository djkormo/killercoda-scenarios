#!/usr/bin/env bash

[ -d ~/.kube/config ] && echo "done"
kubectl get nodes | grep 1.22 | grep Ready | wc -l | grep 2 && echo "done"