resource "volterra_healthcheck" "consul_http_hc" {
  name      = "consul-http-dev"
  namespace = format("%s-dev", var.project_prefix)

  http_health_check {
    use_origin_server_name = true
    path                   = "/ui/assets/favicon.ico"
  }
  healthy_threshold   = 1
  interval            = 15
  timeout             = 1
  unhealthy_threshold = 2
}

resource "volterra_origin_pool" "consul_dev" {
  name                   = "consul-http-dev"
  namespace              = format("%s-dev", var.project_prefix)
  endpoint_selection     = "DISTRIBUTED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 8500
  no_tls                 = true

  origin_servers {
    k8s_service {
      service_name = "consul-http.mwadn-dev"
      site_locator {
        virtual_site {
          namespace = "shared"
          name      = "mwadn-dev"
        }
      }
    }
  }

  healthcheck {
    name = volterra_healthcheck.consul_http_hc.name
  }
}

resource "volterra_http_loadbalancer" "consul_dev" {
  name                            = "consul-http-dev"
  namespace                       = format("%s-dev", var.project_prefix)
  no_challenge                    = true
  domains                         = [ "consul-dev.mwlabs.net" ]

  disable_rate_limit              = true
  service_policies_from_namespace = true
  disable_waf                     = true

  advertise_custom {
    advertise_where {
      port = 8500
      site {
        ip = "10.10.10.10"
        network = "SITE_NETWORK_INSIDE"
        site {
          name      = "marcel-zg01"
          namespace = "system"
        }
      }
    }
    advertise_where {
      port = 8500
      site {
        ip = "10.10.10.10"
        network = "SITE_NETWORK_OUTSIDE"
        site {
          name      = "marcel-colo"
          namespace = "system"
        }
      }
    }
    advertise_where {
      port = 8500
      site {
        network = "SITE_NETWORK_INSIDE"
        site {
          name      = "marcel-zg01"
          namespace = "system"
        }
      }
    }
  }

  default_route_pools {
    pool {
      name = volterra_origin_pool.consul_dev.name
    }
    weight = 1
    priority = 1
  }

  http {
    dns_volterra_managed = false
    port = 8500
  }

  depends_on = [ volterra_origin_pool.consul_dev ]
}

output "http_loadbalancer" {
  value = resource.volterra_http_loadbalancer.consul_dev
}
output "origin_pool" {
  value = resource.volterra_origin_pool.consul_dev
}
output "health_check" {
  value = resource.volterra_healthcheck.consul_http_hc
}
