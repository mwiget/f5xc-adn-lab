terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.16"
    }
    local = ">= 2.2.3"
    null  = ">= 3.1.1"
  }
}
