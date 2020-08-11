terraform {
  backend "azurerm" {
    resource_group_name  = "rgtfstates"
    storage_account_name = "tfstatessdb"
    container_name       = "homelab"
    key                  = "homelab.tfstate"
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