resource "azurerm_databricks_workspace" "dbks" {
  location                    = local.region
  name                        = "dbks${local.name}"
  resource_group_name         = azurerm_resource_group.rg.name
  sku                         = "Standard"
  managed_resource_group_name = "rgdbks${local.name}"
  tags                        = local.tags
}