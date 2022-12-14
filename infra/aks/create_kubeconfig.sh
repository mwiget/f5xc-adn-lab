#!/bin/bash
export KUBECONFIG=kubeconfig
az aks get-credentials --overwrite-existing --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)
kubectl get nodes -o wide
