resource "azurerm_storage_blob" "download_install_python" {
  name                   = "download_install_python.sh"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.scripts.name
  type                   = "Block"
  source_content = templatefile("${path.module}/../scripts/download_install_python.sh", {
    download_url = "${azurerm_storage_blob.sensors.url}${data.azurerm_storage_account_blob_container_sas.python_sas}"
  })
}