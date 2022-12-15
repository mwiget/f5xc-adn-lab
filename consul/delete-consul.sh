#!/bin/bash
export KUBECONFIG=ves_system_marcel-colo_kubeconfig_global.yaml
kubectl delete -f consul-dev.yaml -n mwadn
kubectl delete -f consul-pre.yaml -n mwadn
kubectl delete -f consul-prod.yaml -n mwadn
kubectl delete ns mwadn
