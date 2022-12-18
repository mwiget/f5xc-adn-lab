module "aws_us_east_2" {
  count           = 1
  source          = "./aws"
  vpc_name        = format("%s-us-east-2", var.project_prefix)
  project_prefix  = var.project_prefix
  vpc_cidr        = "172.16.32.0/22"
  aws_region      = "us-east-2"
  owner_tag       = var.owner_tag
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "172.16.32.0/24" },
    { availability_zone = "b", cidr_block = "172.16.33.0/24" },
    { availability_zone = "c", cidr_block = "172.16.34.0/24" }
  ]
  providers       = {
    aws           = aws.us-east-2
  }
}

module "aws_us_west_2" {
  count           = 1
  source          = "./aws"
  vpc_name        = format("%s-us-west-2", var.project_prefix)
  project_prefix  = var.project_prefix
  vpc_cidr        = "172.16.32.0/22"
  aws_region      = "us-west-2"
  owner_tag       = var.owner_tag
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "172.16.32.0/24" },
    { availability_zone = "b", cidr_block = "172.16.33.0/24" },
    { availability_zone = "c", cidr_block = "172.16.34.0/24" },
    { availability_zone = "d", cidr_block = "172.16.35.0/24" }
  ]
  providers       = {
    aws           = aws.us-west-2
  }
}

module "aws_eu_north_1" {
  count           = 1
  source          = "./aws"
  vpc_name        = format("%s-eu-north-1", var.project_prefix)
  project_prefix  = var.project_prefix
  vpc_cidr        = "172.16.16.0/22"
  aws_region      = "eu-north-1"
  owner_tag       = var.owner_tag
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "172.16.16.0/24" },
    { availability_zone = "b", cidr_block = "172.16.17.0/24" }
  ]
  providers       = {
    aws           = aws.eu-north-1
  }
}

module "aws_eu_west_1" {
  count           = 1
  source          = "./aws"
  vpc_name        = format("%s-eu-west-1", var.project_prefix)
  project_prefix  = var.project_prefix
  vpc_cidr        = "172.16.20.0/22"
  aws_region      = "eu-west-1"
  owner_tag       = var.owner_tag
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "172.16.20.0/24" }
  ]
  providers       = {
    aws           = aws.eu-west-1
  }
}

module "aks" {
  count           = 0
  source          = "./aks"
  project_prefix  = var.project_prefix
  aks_region      = "westus2"
  aks_num_nodes   = 3
  owner_tag       = var.owner_tag
  providers       = {
    azurerm       = azurerm.azurerm
  }
}
