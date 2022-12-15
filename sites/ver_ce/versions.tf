terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.16"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.34.0"
    }

    ct = {
      source  = "poseidon/ct"
      version = ">= 0.11.0"
    }

    local = ">= 2.2.3"
    null  = ">= 3.1.1"
  }
}
