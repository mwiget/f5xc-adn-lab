resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name    = var.vpc_name
    Creator = var.owner_tag
  }
}

resource "aws_subnet" "subnet" {
  for_each                = {for k, v in var.vpc_subnets :  k => v}
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = false
  availability_zone       = format("%s%s", var.aws_region, each.value.availability_zone)
  tags                    = {
    Name    = format("%s-%s", var.vpc_name, each.value.availability_zone)
    Creator = var.owner_tag
    security_group_id = resource.aws_security_group.allow_traffic.id
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.vpc_name
    Creator = var.owner_tag
  }
}

resource "aws_route_table" "rt" {
  for_each    = {for k, v in var.vpc_subnets :  k => v}
  vpc_id      = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = format("%s-%s", var.vpc_name, each.value.availability_zone)
    Creator = var.owner_tag
  } 
} 

resource "aws_route_table_association" "rta" {
  for_each                = {for k, v in var.vpc_subnets :  k => v}
  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.rt[each.key].id
} 

resource "aws_security_group" "allow_traffic" {
  name        = "${var.vpc_name}-allow-traffic"
  description = "allow ssh and smg traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["172.16.0.0/16"]
  }

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = "4500"
    to_port     = "4500"
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = var.vpc_name
    Creator = var.owner_tag
  }
} 

output "vpc" {
  value = resource.aws_vpc.vpc
}
output "internet_gateway" {
  value = resource.aws_internet_gateway.gateway
}
output "route_table" {
  value = resource.aws_route_table.rt
}
output "security_group" {
  value = resource.aws_security_group.allow_traffic
}
