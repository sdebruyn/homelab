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

resource "azurerm_storage_container" "scripts" {
  name                 = "scripts"
  storage_account_name = azurerm_storage_account.sa.name
}

data "azurerm_storage_account_blob_container_sas" "python_sas" {
  depends_on = [
  azurerm_storage_container.python]
  connection_string = azurerm_storage_account.sa.primary_blob_connection_string
  container_name    = azurerm_storage_container.python.name
  expiry            = timeadd(timestamp(), "87600h")
  start             = timestamp()
  permissions {
    add    = false
    create = false
    delete = false
    list   = false
    read   = true
    write  = false
  }
}