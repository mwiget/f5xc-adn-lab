variable "subnet_name" {
  type  = string
}
variable "site_name" {
  type  = string
}
variable "subnet_id" {
  type  = string
}
variable "ssh_public_key" {
  type  = string
}
variable "site_token" {
  type  = string
}
variable "vpc_id" {
  type  = string
}
variable "availability_zone" {
  type        = string
}
variable "instance_type" {
  type  = string
  default = "t3.xlarge"
}
variable "owner_tag" {
  type        = string
  default     = "m.wiget@f5.com"
}

variable "custom_vip_cidr" {
  type        = string
}
variable "security_group_id" {
  type        = string
}
variable "site_label_1" {
  type        = string
}

variable "site_label_2" {
  type        = string
  default     = ""
}

variable "f5xc_api_url" {       
  type = string
}

variable "f5xc_api_cert" {
  type = string
  default = ""
}

variable "f5xc_api_p12_file" {
  type = string
  default = ""
}

variable "f5xc_api_key" {
  type = string
  default = ""
}

variable "f5xc_api_ca_cert" {
  type = string
  default = ""
}

variable "f5xc_api_token" {
  type = string
  default = ""
}

variable "f5xc_tenant" {
  type = string
  default = ""
}

