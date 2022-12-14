variable "project_prefix" {
  type        = string
  default     = "f5xc"
}

variable "owner_tag" {
  type        = string
  default     = "m.wiget@f5.com"
}

variable "aws_access_key" {
  type        = string
  description = "AWS access key used to create infrastructure"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key used to create AWS infrastructure"
}

variable "ssh_public_key" {
  type        = string
}
