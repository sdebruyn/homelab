resource "azurerm_storage_blob" "sensors" {
  name                   = "sensors.tar.gz"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.python.name
  type                   = "Block"
  source                 = "${path.module}/../python/dist/sensors-0.1.tar.gz"
}