#!/bin/bash
for env in dev pre prod; do
  export KUBECONFIG=../virtual/kubeconfig-$env.yaml
  kubectl apply -f consul-$env.yaml
  kubectl get services -o wide
  kubectl get pods -o wide
done
exit
