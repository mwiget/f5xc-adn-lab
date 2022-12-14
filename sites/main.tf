module "ce" {
  source            = "./instance"
  for_each          = {for subnet in local.subnets_us_east_2.subnets:  subnet.subnet_name => subnet}
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  site_token        = volterra_token.token.id
  site_label        = format("%s-dev: member", var.project_prefix)
  custom_vip_cidr   = "10.10.10.10/32"
  bastion_cidr      = "168.119.109.115/32"
  ssh_public_key    = var.ssh_public_key
  f5xc_api_token    = var.f5xc_api_token
  f5xc_api_url      = var.f5xc_api_url
  f5xc_tenant       = var.f5xc_tenant
  providers         = {
    aws             = aws.us-east-2
  }
}

resource "volterra_token" "token" {
  name      = format("%s-token", var.project_prefix)
  namespace = "system"
}
