#!/bin/bash
terraform output -json | jq -r '.aws_us_east_2.value[].aws_subnet[] | { subnet_name: .tags_all.Name, subnet_id: .id, vpc_id:.vpc_id, availability_zone: .availability_zone, security_group_id: .tags_all.security_group_id}' | jq -n '.subnets |= [inputs]' > subnets_us_east_2.json
terraform output -json | jq -r '.aws_us_west_2.value[].aws_subnet[] | { subnet_name: .tags_all.Name, subnet_id: .id, vpc_id:.vpc_id, availability_zone: .availability_zone, security_group_id: .tags_all.security_group_id}' | jq -n '.subnets |= [inputs]' > subnets_us_west_2.json
terraform output -json | jq -r '.aws_eu_north_1.value[].aws_subnet[] | { subnet_name: .tags_all.Name, subnet_id: .id, vpc_id:.vpc_id, availability_zone: .availability_zone, security_group_id: .tags_all.security_group_id}' | jq -n '.subnets |= [inputs]' > subnets_eu_north_1.json
ls -l subnets*json
echo -n "Total subnet count across regions: "
grep subnet_name subnets*json | wc -l
