terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "debruyn"

    workspaces {
      name = "homelab"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  location = local.region
  name     = "rg${local.name}"
  tags     = local.tags
}