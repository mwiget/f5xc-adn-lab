resource "volterra_healthcheck" "workload_hc_pre" {
  name      = format("%s-workload-hc", var.project_prefix)
  namespace = format("%s-pre", var.project_prefix)

  http_health_check {
    use_origin_server_name = true
    path                   = "/"
  }
  healthy_threshold   = 1
  interval            = 15
  timeout             = 1
  unhealthy_threshold = 2
}

resource "volterra_origin_pool" "workload_pre" {
  name                   = "workload-pre"
  namespace              = format("%s-pre", var.project_prefix)
  endpoint_selection     = "DISTRIBUTED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 8080
  no_tls                 = true

  origin_servers {
    #    k8s_service {
    #  service_name = "workload-pre"
    #  site_locator {
    #    virtual_site {
    #      namespace = "shared"
    #      name      = "mwadn-pre"
    #    }
    #  }
    #}
    consul_service {
      service_name = "workload-pre"
      site_locator {
        virtual_site {
          name      = "mwadn-pre"
          namespace = "shared"
        }
      }
      outside_network = true
    }
  }

  healthcheck {
    name = volterra_healthcheck.workload_hc_pre.name
  }
}

resource "volterra_http_loadbalancer" "workload_pre" {
  name                            = "workload-pre"
  namespace                       = format("%s-pre", var.project_prefix)
  no_challenge                    = true
  domains                         = [ "workload-pre.mwadn-pre" ]

  disable_rate_limit              = true
  service_policies_from_namespace = true
  disable_waf                     = true
  source_ip_stickiness            = true

  advertise_custom {
    advertise_where {
      port = 8080
      site {
        network = "SITE_NETWORK_INSIDE"
        site {
          name      = "marcel-zg01"
          namespace = "system"
        }
      }
    }
    advertise_where {
      port = 8080
      site {
        ip = "10.10.10.10"
        network = "SITE_NETWORK_OUTSIDE"
        site {
          name      = "mwadn-us-east-2-a"
          namespace = "system"
        }
      }
    }
    advertise_where {
      port = 8080
      site {
        ip = "10.10.10.10"
        network = "SITE_NETWORK_OUTSIDE"
        site {
          name      = "mwadn-us-west-2-a"
          namespace = "system"
        }
      }
    }
    advertise_where {
      port = 8080
      site {
        ip = "10.10.10.10"
        network = "SITE_NETWORK_OUTSIDE"
        site {
          name      = "mwadn-eu-north-1-a"
          namespace = "system"
        }
      }
    }
  }

  default_route_pools {
    pool {
      name = volterra_origin_pool.workload_pre.name
    }
    weight = 1
    priority = 1
  }

  http {
    dns_volterra_managed = false
    port = 8080
  }

  depends_on = [ volterra_origin_pool.workload_pre ]
}

output "http_loadbalancer_pre" {
  value = resource.volterra_http_loadbalancer.workload_pre
}
output "origin_pool_pre" {
  value = resource.volterra_origin_pool.workload_pre
}
output "health_check_pre" {
  value = resource.volterra_healthcheck.workload_hc_pre
}

