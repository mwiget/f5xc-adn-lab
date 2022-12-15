module "ce-us-east-2" {
  source            = "./ver_ce"
  #source            = "./fcos_ce"
  for_each          = {for subnet in local.subnets_us_east_2.subnets:  subnet.subnet_name => subnet}
  aws_region        = "us-east-2"
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  site_token        = volterra_token.token.id
  site_label_1      = format("%s-dev: member", var.project_prefix)
  site_label_2      = format("%s-all: member", var.project_prefix)
  site_label_3      = format("%s-pre: member", var.project_prefix)
  site_label_4      = format("%s-prod: member", var.project_prefix)
  custom_vip_cidr   = "10.10.10.10/32"
  ssh_public_key    = var.ssh_public_key
  f5xc_api_token    = var.f5xc_api_token
  f5xc_api_url      = var.f5xc_api_url
  f5xc_tenant       = var.f5xc_tenant
  providers         = {
    aws             = aws.us-east-2
  }
}

module "ce-us-west-2" {
  source            = "./ver_ce"
  for_each          = {for subnet in local.subnets_us_west_2.subnets:  subnet.subnet_name => subnet}
  aws_region        = "us-west-2"
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  site_token        = volterra_token.token.id
  site_label_1      = format("%s-dev: member", var.project_prefix)
  site_label_2      = format("%s-all: member", var.project_prefix)
  site_label_3      = format("%s-pre: member", var.project_prefix)
  site_label_4      = format("%s-prod: member", var.project_prefix)
  custom_vip_cidr   = "10.10.10.10/32"
  ssh_public_key    = var.ssh_public_key
  f5xc_api_token    = var.f5xc_api_token
  f5xc_api_url      = var.f5xc_api_url
  f5xc_tenant       = var.f5xc_tenant
  providers         = {
    aws             = aws.us-west-2
  }
}

module "ce-eu-north-1" {
  source            = "./ver_ce"
  for_each          = {for subnet in local.subnets_eu_north_1.subnets:  subnet.subnet_name => subnet}
  aws_region        = "eu-north-1"
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  site_token        = volterra_token.token.id
  site_label_1      = format("%s-dev: member", var.project_prefix)
  site_label_2      = format("%s-all: member", var.project_prefix)
  site_label_3      = format("%s-pre: member", var.project_prefix)
  site_label_4      = format("%s-prod: member", var.project_prefix)
  custom_vip_cidr   = "10.10.10.10/32"
  ssh_public_key    = var.ssh_public_key
  f5xc_api_token    = var.f5xc_api_token
  f5xc_api_url      = var.f5xc_api_url
  f5xc_tenant       = var.f5xc_tenant
  providers         = {
    aws             = aws.eu-north-1
  }
}

resource "volterra_token" "token" {
  name      = format("%s-token", var.project_prefix)
  namespace = "system"
}
