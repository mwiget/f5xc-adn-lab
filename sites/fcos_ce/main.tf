resource "aws_instance" "ce" {
  ami                         = data.aws_ami.latest-fcos.id
  instance_type               = var.instance_type
  user_data                   = data.ct_config.ce.rendered
  vpc_security_group_ids      = [
    var.security_group_id,
  ]
  subnet_id                   = var.subnet_id
  source_dest_check           = false
  associate_public_ip_address = true

  root_block_device {
    volume_size = 40
  }
  
  tags = {
    Name    = format("%s-ce", var.subnet_name)
    Type    = "ce"
    Creator = var.owner_tag
  }
}

resource "aws_route" "custom_vip_route" {
  route_table_id         = data.aws_route_table.rt.id
  destination_cidr_block = var.custom_vip_cidr
  network_interface_id   = aws_instance.ce.primary_network_interface_id
}

module "site_wait_for_online" {
  depends_on     = [volterra_registration_approval.ce]
  source         = "../modules/f5xc/status/site"
  f5xc_namespace = "system"
  f5xc_api_token = var.f5xc_api_token
  f5xc_api_url   = var.f5xc_api_url
  f5xc_site_name = var.site_name
  f5xc_tenant    = var.f5xc_tenant
}

resource "volterra_registration_approval" "ce" {
  depends_on    = [resource.aws_instance.ce]
  cluster_name  = var.site_name
  hostname      = "vp-manager-0"
  cluster_size  = 1
  retry = 25
  wait_time = 30
}

resource "volterra_site_state" "decommission_when_delete" {
  name       = var.site_name
  when       = "delete"
  state      = "DECOMMISSIONING"
  wait_time  = 60
  retry      = 5
  depends_on = [volterra_registration_approval.ce]
} 
