variable "project_prefix" {
  type        = string
}

variable "owner_tag" {
  type        = string
}

variable "vpc_name" {
  type        = string
}

variable "aws_region" {
  type        = string
}

variable "vpc_cidr" {
  type        = string
}

variable "vpc_subnets" {
  type = list(object({
    availability_zone       = string
    cidr_block              = string
  }))
}
