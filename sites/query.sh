#!/bin/bash
sites=$(terraform output -json | jq -r '.[].value[].instance.public_ip')
echo $sites ...
for ip in $sites; do
  echo $ip ...
  ssh -i ~/.ves-internal/staging/id_rsa vesop@$ip sudo /opt/bin/kubectl get pods -o wide -n mwadn-dev
  echo ""
done
