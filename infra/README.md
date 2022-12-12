```
terraform output -json | jq -r '.aws_east.value[].vpc.id,.aws_west.value[].vpc.id'

vpc-065aaa32aa46be061
vpc-0f3552215955e2ee3
```

```
terraform output -json | jq -r '.aws_east.value[].aws_subnet[],.aws_west.value[].aws_subnet[] | "\(.tags_all.Name) = \(.id)"'

 mwadn-aws-east-a = subnet-08ab5c282b1b85bc5
 mwadn-aws-east-b = subnet-0bef50ad6587740e5
 mwadn-aws-east-c = subnet-05a2cffe6871919d4
 mwadn-aws-west-a = subnet-02494d46289352a3c
 mwadn-aws-west-b = subnet-05316ea33057604a1
 mwadn-aws-west-c = subnet-017cf638c44ffc717
```

```
terraform output -json | jq -r .aks1.value.kube_config > kubeconfig
terraform output -json | jq -r .aks.value[].kube_config > kubeconfig
kubectl --kubeconfig kubeconfig get nodes -o wide

NAME                              STATUS   ROLES   AGE     VERSION    INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
aks-default-90981337-vmss000000   Ready    agent   7m22s   v1.23.12   10.224.0.4    <none>        Ubuntu 18.04.6 LTS   5.4.0-1094-azure   containerd://1.6.4+azure-4
aks-default-90981337-vmss000001   Ready    agent   7m38s   v1.23.12   10.224.0.5    <none>        Ubuntu 18.04.6 LTS   5.4.0-1094-azure   containerd://1.6.4+azure-4
aks-default-90981337-vmss000002   Ready    agent   7m39s   v1.23.12   10.224.0.6    <none>        Ubuntu 18.04.6 LTS   5.4.0-1094-azure   containerd://1.6.4+azure-4
```
