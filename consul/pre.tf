resource "volterra_healthcheck" "consul_hc_pre" {
  name      = format("%s-consul-hc", var.project_prefix)
  namespace = format("%s-pre", var.project_prefix)

  http_health_check {
    use_origin_server_name = true
    path                   = "/ui/assets/favicon.ico"
  }
  healthy_threshold   = 1
  interval            = 15
  timeout             = 1
  unhealthy_threshold = 2
}

resource "volterra_origin_pool" "consul_pre" {
  name                   = "consul-pre"
  namespace              = format("%s-pre", var.project_prefix)
  endpoint_selection     = "DISTRIBUTED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 8500
  no_tls                 = true

  origin_servers {
    k8s_service {
      service_name = "consul.mwadn-pre"
      site_locator {
        virtual_site {
          namespace = "shared"
          name      = "mwadn-pre"
        }
      }
      vk8s_networks = true
    }
  }

  healthcheck {
    name = volterra_healthcheck.consul_hc_pre.name
  }
}

resource "volterra_http_loadbalancer" "consul_pre" {
  name                            = "consul-pre"
  namespace                       = format("%s-pre", var.project_prefix)
  no_challenge                    = true
  domains                         = [ "consul-pre.mwlabs.net", "consul.pre" ]

  disable_rate_limit              = true
  service_policies_from_namespace = true
  disable_waf                     = true
  source_ip_stickiness            = true

  advertise_custom {
        advertise_where {
      port = 8500
      site {
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
        ip = "10.10.10.10"
        network = "SITE_NETWORK_OUTSIDE"
        site {
          name      = "mwadn-us-east-2-a"
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
          name      = "mwadn-us-east-2-b"
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
          name      = "mwadn-us-east-2-c"
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
          name      = "mwadn-us-east-2-d"
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
          name      = "mwadn-us-west-2-a"
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
          name      = "mwadn-us-west-2-b"
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
          name      = "mwadn-us-west-2-c"
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
          name      = "mwadn-eu-north-1-a"
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
          name      = "mwadn-eu-north-1-b"
          namespace = "system"
        }
      }
    }
  }

  default_route_pools {
    pool {
      name = volterra_origin_pool.consul_pre.name
    }
    weight = 1
    priority = 1
  }

  http {
    dns_volterra_managed = false
    port = 8500
  }

  depends_on = [ volterra_origin_pool.consul_pre ]
}

resource "volterra_discovery" "consul_pre" {
  name      = "mwadn-pre"
  namespace = "system"
  no_cluster_id = true
  discovery_consul {
    access_info {
      connection_info {
        api_server = "http://consul-pre.mwlabs.net:8500"
      }

    }
    publish_info {
      disable = true
    }
  }
  where {
    virtual_site {
      network_type = "SITE_NETWORK_OUTSIDE"
      ref {
        name = "mwadn-pre"
        namespace = "shared"
      }
    }
  }
}

output "http_loadbalancer_pre" {
  value = resource.volterra_http_loadbalancer.consul_pre
}
output "origin_pool_pre" {
  value = resource.volterra_origin_pool.consul_pre
}
output "health_check_pre" {
  value = resource.volterra_healthcheck.consul_hc_pre
}

