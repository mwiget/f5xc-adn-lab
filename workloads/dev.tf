module "wl-dev-us-east-2" {
  source            = "./instance"
  for_each          = {for subnet in local.subnets_us_east_2.subnets:  subnet.subnet_name => subnet}
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  instance_type     = "t3.nano"
  custom_vip_cidr   = "10.10.10.0/24"
  ssh_public_key    = var.ssh_public_key
  service           = "workload-dev"
  consul_hostname   = "consul.dev"
  consul_vip        = "10.10.10.10"
  owner_tag         = "m.wiget@f5.com"
  providers         = {
    aws             = aws.us-east-2
  }
}

module "wl-dev-us-west-2" {
  source            = "./instance"
  for_each          = {for subnet in local.subnets_us_west_2.subnets:  subnet.subnet_name => subnet}
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  instance_type     = "t3.nano"
  custom_vip_cidr   = "10.10.10.0/24"
  ssh_public_key    = var.ssh_public_key
  service           = "workload-dev"
  consul_hostname   = "consul.dev"
  consul_vip        = "10.10.10.10"
  owner_tag         = "m.wiget@f5.com"
  providers         = {
    aws             = aws.us-west-2
  }
}

module "wl-dev-eu-north-1" {
  source            = "./instance"
  for_each          = {for subnet in local.subnets_eu_north_1.subnets:  subnet.subnet_name => subnet}
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  instance_type     = "t3.nano"
  custom_vip_cidr   = "10.10.10.0/24"
  ssh_public_key    = var.ssh_public_key
  service           = "workload-dev"
  consul_hostname   = "consul.dev"
  consul_vip        = "10.10.10.10"
  owner_tag         = "m.wiget@f5.com"
  providers         = {
    aws             = aws.eu-north-1
  }
}

module "wl-dev-eu-west-1" {
  source            = "./instance"
  for_each          = {for subnet in local.subnets_eu_west_1.subnets:  subnet.subnet_name => subnet}
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  instance_type     = "t3.nano"
  custom_vip_cidr   = "10.10.10.0/24"
  ssh_public_key    = var.ssh_public_key
  service           = "workload-dev"
  consul_hostname   = "consul.dev"
  consul_vip        = "10.10.10.10"
  owner_tag         = "m.wiget@f5.com"
  providers         = {
    aws             = aws.eu-west-1
  }
}

output "wl-dev-us-east-2" {
  value = module.wl-dev-us-east-2
}
output "wl-dev-us-west-2" {
  value = module.wl-dev-us-west-2
}
output "wl-dev-eu-north-1" {
  value = module.wl-dev-eu-north-1
}
output "wl-dev-eu-west-1" {
  value = module.wl-dev-eu-west-1
}
