resource "volterra_healthcheck" "workload_hc_dev" {
  name      = format("%s-workload-hc", var.project_prefix)
  namespace = format("%s-dev", var.project_prefix)

  http_health_check {
    use_origin_server_name = true
    path                   = "/"
  }
  healthy_threshold   = 1
  interval            = 15
  timeout             = 1
  unhealthy_threshold = 2
}

resource "volterra_origin_pool" "workload_dev" {
  name                   = "workload-dev"
  namespace              = format("%s-dev", var.project_prefix)
  endpoint_selection     = "DISTRIBUTED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 8080
  no_tls                 = true

  origin_servers {
    #    k8s_service {
    #  service_name = "workload-dev"
    #  site_locator {
    #    virtual_site {
    #      namespace = "shared"
    #      name      = "mwadn-dev"
    #    }
    #  }
    #}
    consul_service {
      service_name = "workload-dev"
      site_locator {
        virtual_site {
          name      = "mwadn-dev"
          namespace = "shared"
        }
      }
      outside_network = true
    }
  }
  advanced_options {
    disable_outlier_detection = false
    outlier_detection {
      base_ejection_time = 10000
      consecutive_5xx = 2
      consecutive_gateway_failure = 2
      interval = 5000
      max_ejection_percent = 100
    } 
  } 

  healthcheck {
    name = volterra_healthcheck.workload_hc_dev.name
  }
}

resource "volterra_http_loadbalancer" "workload_dev" {
  name                            = "workload-dev"
  namespace                       = format("%s-dev", var.project_prefix)
  no_challenge                    = true
  domains                         = [ "workload-dev.mwadn-dev" ]

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
          name      = "mwadn-us-east-2-b"
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
          name      = "mwadn-us-east-2-c"
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
          name      = "mwadn-us-east-2-d"
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
          name      = "mwadn-us-west-2-b"
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
          name      = "mwadn-us-west-2-c"
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
    advertise_where {
      port = 8080
      site {
        ip = "10.10.10.10"
        network = "SITE_NETWORK_OUTSIDE"
        site {
          name      = "mwadn-eu-north-1-b"
          namespace = "system"
        }
      }
    }
  }

  default_route_pools {
    pool {
      name = volterra_origin_pool.workload_dev.name
    }
    weight = 1
    priority = 1
  }

  http {
    dns_volterra_managed = false
    port = 8080
  }

  depends_on = [ volterra_origin_pool.workload_dev ]
}

output "http_loadbalancer" {
  value = resource.volterra_http_loadbalancer.workload_dev
}
output "origin_pool" {
  value = resource.volterra_origin_pool.workload_dev
}
output "health_check_dev" {
  value = resource.volterra_healthcheck.workload_hc_dev
}

