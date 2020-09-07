resource "azurerm_log_analytics_workspace" "la" {
  tags                = local.tags
  location            = local.region
  resource_group_name = azurerm_resource_group.rg.name
  name                = "la${local.name}"
  sku                 = "PerGB2018"
}