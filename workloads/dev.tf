module "wl" {
  source            = "./instance"
  for_each          = {for subnet in local.subnets_us_east_2.subnets:  subnet.subnet_name => subnet}
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  instance_type     = "t3.nano"
  custom_vip_cidr   = "10.10.10.10/32"
  bastion_cidr      = "168.119.109.115/32"
  ssh_public_key    = var.ssh_public_key
  service           = "workload"
  consul_hostname   = "consul-dev.mwlabs.net"
  consul_vip        = "10.10.10.10"
  providers         = {
    aws             = aws.us-east-2
  }
}

