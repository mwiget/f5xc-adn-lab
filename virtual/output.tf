output "virtual-site" {
  value = module.virtual_site
}

output "namespace_dev" {
  value = module.namespace_dev
}

output "namespace_pre" {
  value = module.namespace_pre
}

output "namespace_prod" {
  value = module.namespace_prod
}

output "site-token" {
  value = resource.volterra_token.token
}

