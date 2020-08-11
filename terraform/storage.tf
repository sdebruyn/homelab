resource "azurerm_storage_account" "sa" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = local.region
  name                     = "sa${local.name}"
  resource_group_name      = azurerm_resource_group.rg.name
  tags                     = local.tags
}

resource "azurerm_storage_container" "python" {
  name                 = "python"
  storage_account_name = azurerm_storage_account.sa.name
}