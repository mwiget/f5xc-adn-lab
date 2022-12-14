#!/bin/bash
#
# generate json list of aws subnets with vpc and subnet id, e.g.
# 
# {
#   "subnet_name": "mwadn-aws-east-a",
#   "subnet_id": "subnet-0ad32eb051ddaaa02",
#   "vpc_id": "vpc-0a8f27564c6ac8eac",
#   "az_id": "use2-az1"
# }
# {
#   "subnet_name": "mwadn-aws-east-b",
#   "subnet_id": "subnet-062ab7275bff76248",
#   "vpc_id": "vpc-0a8f27564c6ac8eac",
#   "az_id": "use2-az2"
# }
# . . . 
terraform output -json | jq -r '.aws_east.value[].aws_subnet[],.aws_west.value[].aws_subnet[] | { subnet_name: .tags_all.Name, subnet_id: .id, vpc_id:.vpc_id, az_id: .availability_zone_id, security_group_id: .tags_all.security_group_id}' | jq -n '.subnets |= [inputs]'
