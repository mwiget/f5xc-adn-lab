module "namespace_dev" {
  source              = "./modules/f5xc/namespace"
  f5xc_namespace_name = format("%s-dev", var.project_prefix)
}

module "namespace_pre" {
  source              = "./modules/f5xc/namespace"
  f5xc_namespace_name = format("%s-pre", var.project_prefix)
}

module "namespace_prod" {
  source              = "./modules/f5xc/namespace"
  f5xc_namespace_name = format("%s-prod", var.project_prefix)
}

module "virtual_site_dev" {
  source                                = "./modules/f5xc/site/virtual"
  #f5xc_namespace                        = module.namespace_dev.namespace["name"]
  f5xc_namespace                        = "shared"
  f5xc_virtual_site_name                = format("%s-dev", var.project_prefix)
  f5xc_virtual_site_type                = "CUSTOMER_EDGE"
  f5xc_virtual_site_selector_expression = [ format("%s-dev", var.project_prefix) ]
}

module "virtual_site_pre" {
  source                                = "./modules/f5xc/site/virtual"
  f5xc_namespace                        = "shared"
  f5xc_virtual_site_name                = format("%s-pre", var.project_prefix)
  f5xc_virtual_site_type                = "CUSTOMER_EDGE"
  f5xc_virtual_site_selector_expression = [ format("%s-pre", var.project_prefix) ]
}

module "virtual_site_prod" {
  source                                = "./modules/f5xc/site/virtual"
  f5xc_namespace                        = "shared"
  f5xc_virtual_site_name                = format("%s-prod", var.project_prefix)
  f5xc_virtual_site_type                = "CUSTOMER_EDGE"
  f5xc_virtual_site_selector_expression = [ format("%s-dev", var.project_prefix) ]
}

module "virtual_site" {
  source                                = "./modules/f5xc/site/virtual"
  f5xc_namespace                        = "shared"
  f5xc_virtual_site_name                = format("%s-all", var.project_prefix)
  f5xc_virtual_site_type                = "CUSTOMER_EDGE"
  f5xc_virtual_site_selector_expression = [ format("%s", var.project_prefix) ]
}

module "smg" {
  source                           = "./modules/f5xc/site-mesh-group"
  f5xc_tenant                      = var.f5xc_tenant
  f5xc_namespace                   = "system"
  f5xc_virtual_site_name           = module.virtual_site.virtual-site["name"]
  f5xc_site_mesh_group_name        = format("%s-smg", var.project_prefix)
  f5xc_site_2_site_connection_type = "full_mesh"
}

resource "volterra_token" "token" {
  name      = format("%s-k0s-token", var.project_prefix)
  namespace = "system"
}

module "vk8s_dev" {
  source                    = "./modules/f5xc/v8ks"
  f5xc_tenant               = var.f5xc_tenant
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
  f5xc_vk8s_name            = format("%s-vk8s-dev", var.project_prefix)
  f5xc_vk8s_namespace       = module.namespace_dev.namespace["name"]
  f5xc_vsite_refs_namespace = "shared"
  f5xc_virtual_site_refs    = [module.virtual_site_dev.virtual-site["name"]]
}

module "vk8s_pre" {
  source                    = "./modules/f5xc/v8ks"
  f5xc_tenant               = var.f5xc_tenant
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
  f5xc_vk8s_name            = format("%s-vk8s-pre", var.project_prefix)
  f5xc_vk8s_namespace       = module.namespace_pre.namespace["name"]
  f5xc_vsite_refs_namespace = "shared"
  f5xc_virtual_site_refs    = [module.virtual_site_pre.virtual-site["name"]]
}

module "vk8s_prod" {
  source                    = "./modules/f5xc/v8ks"
  f5xc_tenant               = var.f5xc_tenant
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
  f5xc_vk8s_name            = format("%s-vk8s-prod", var.project_prefix)
  f5xc_namespace            = module.namespace_prod.namespace["name"]
  f5xc_vk8s_namespace       = module.namespace_prod.namespace["name"]
  f5xc_vsite_refs_namespace = "shared"
  f5xc_virtual_site_refs    = [module.virtual_site_prod.virtual-site["name"]]
}

module "kubeconfig_dev" {
  source                    = "./vk8s_kubeconfig"
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
  f5xc_vk8s_namespace       = module.namespace_dev.namespace["name"]
  f5xc_vk8s_name            = module.vk8s_dev.vk8s["name"]
  filename                  = "kubeconfig-dev.yaml"
}

module "kubeconfig_pre" {
  source                    = "./vk8s_kubeconfig"
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
  f5xc_vk8s_namespace       = module.namespace_pre.namespace["name"]
  f5xc_vk8s_name            = module.vk8s_pre.vk8s["name"]
  filename                  = "kubeconfig-pre.yaml"
}

module "kubeconfig_prod" {
  source                    = "./vk8s_kubeconfig"
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
  f5xc_vk8s_namespace       = module.namespace_prod.namespace["name"]
  f5xc_vk8s_name            = module.vk8s_prod.vk8s["name"]
  filename                  = "kubeconfig-prod.yaml"
}

#module "credential_dev" {
#  source                    = "./modules/f5xc/api-credential"
#  f5xc_tenant               = var.f5xc_tenant
#  f5xc_api_url              = var.f5xc_api_url
#  f5xc_api_token            = var.f5xc_api_token
#  f5xc_namespace            = module.namespace_dev.namespace["name"]
#  f5xc_virtual_k8s_name     = module.vk8s_dev.vk8s["name"]
#  f5xc_api_credential_type  = "KUBE_CONFIG"
#  f5xc_api_credentials_name = format("%s-vk8s-credential-dev", var.project_prefix)
#}

#module "credential_pre" {
#  source                    = "./modules/f5xc/api-credential"
#  f5xc_tenant               = var.f5xc_tenant
#  f5xc_api_url              = var.f5xc_api_url
#  f5xc_api_token            = var.f5xc_api_token
#  f5xc_namespace            = module.namespace_pre.namespace["name"]
#  f5xc_virtual_k8s_name     = module.vk8s_pre.vk8s["name"]
#  f5xc_api_credential_type  = "KUBE_CONFIG"
#  f5xc_api_credentials_name = format("%s-vk8s-credential-pre", var.project_prefix)
#}

#module "credential_prod" {
#  source                    = "./modules/f5xc/api-credential"
#  f5xc_tenant               = var.f5xc_tenant
#  f5xc_api_url              = var.f5xc_api_url
#  f5xc_api_token            = var.f5xc_api_token
#  f5xc_namespace            = module.namespace_prod.namespace["name"]
#  f5xc_virtual_k8s_name     = module.vk8s_prod.vk8s["name"]
#  f5xc_api_credential_type  = "KUBE_CONFIG"
#  f5xc_api_credentials_name = format("%s-vk8s-credential-prod", var.project_prefix)
#}

#resource "local_file" "kubeconfig_dev" {
#  content  = module.credential_dev.api_credential["k8s_conf"]
#  filename = format("./%s", "kubeconfig_dev.yaml")
#}

#resource "local_file" "kubeconfig_pre" {
#  content  = module.credential_pre.api_credential["k8s_conf"]
#  filename = format("./%s", "kubeconfig_pre.yaml")
#}

#resource "local_file" "kubeconfig_prod" {
#  content  = module.credential_prod.api_credential["k8s_conf"]
#  filename = format("./%s", "kubeconfig_prod.yaml")
#}

