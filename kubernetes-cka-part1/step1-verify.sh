#!/usr/bin/env bash
  kubectl get nodes | grep 1.23 | grep Ready | wc -l | grep 2 \
    && kubectl get pod alone-pod web-server -n alone | grep Running |wc -l | grep 2 \
    && echo "done"