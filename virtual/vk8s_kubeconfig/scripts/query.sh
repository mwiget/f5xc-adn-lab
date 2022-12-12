#!/usr/bin/env bash

url=$1
token=$2
namespace=$3
vk8s_name=$4
filename=$5

RAW=$(cat <<EOF
{"name":"$vk8s_name","namespaces":"$namespace","expiration_days":97,"spec":{"type":"KUBE_CONFIG","users":[],"password":null,"virtual_k8s_name":"$vk8s_name","virtual_k8s_namespace":"$namespace"}}
EOF
)

curl --silent --location --request POST "$url/web/namespaces/$namespace/api_credentials" \
  --header "Authorization: APIToken $token" \
  --data-raw "$RAW" | jq -r .data | base64 --decode > $filename
