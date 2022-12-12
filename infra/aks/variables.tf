variable "project_prefix" {
  type        = string
}

variable "owner_tag" {
  type        = string
}

variable "aks_region" {}

variable "aks_num_nodes" {
  description = "Azure Kubernetes node_count"
}
