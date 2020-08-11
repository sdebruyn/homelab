resource "azurerm_eventhub_namespace" "ehns" {
  location            = local.region
  name                = "ehns${local.name}"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  capacity            = 1
  tags                = local.tags
}

resource "azurerm_eventhub" "hub" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "eh${local.name}"
  namespace_name      = azurerm_eventhub_namespace.ehns.name
  message_retention   = 7
  partition_count     = 2
}