#!/bin/bash
terraform output -json | jq -r '.[].value[].instance | { name: .tags.Name, public_ip: .public_ip, private_ip: .private_ip, public_dns: .public_dns, private_dns: .private_dns, id: .id, instance_type: .instance_type  }' | jq -n '.instance |= [inputs]' 
