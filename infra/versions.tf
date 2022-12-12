terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.34.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.35.0"
    }
  }
}
