resource "azurerm_resource_group" "default" {
  name     = "${var.project_prefix}-rg"
  location = var.aks_region

  tags = {
    environment = var.project_prefix
    Creator = var.owner_tag
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.project_prefix}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${var.project_prefix}-aks"

  default_node_pool {
    name            = "default"
    node_count      = var.aks_num_nodes
    vm_size         = "Standard_D3_v2"  # 4 vcpu, 14 GB
    os_disk_size_gb = 30
    enable_node_public_ip = false
  }

  identity {
    type = "SystemAssigned"
  }

  #role_based_access_control {
  #  enabled = true
  #}

  tags = {
    environment = var.project_prefix
    Creator = var.owner_tag
  }
}
