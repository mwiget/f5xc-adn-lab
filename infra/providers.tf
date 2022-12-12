provider "aws" {
  region = "us-east-2"
  alias  = "us-east-2"
}
provider "aws" {
  region = "us-west-2"
  alias  = "us-west-2"
}
provider "azurerm" {
  features {}
  alias  = "azurerm"
}
