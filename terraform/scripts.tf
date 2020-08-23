resource "azurerm_storage_blob" "download_install_python" {
  name                   = "download_install_python.sh"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.scripts.name
  type                   = "Block"
  source_content = templatefile("${path.module}/../scripts/download_install_python.sh", {
    download_url = "${azurerm_storage_blob.sensors.url}${data.azurerm_storage_account_blob_container_sas.python_sas.sas}"
  })

  provisioner "local-exec" {
    command = "curl -X POST -sl \"https://${local.server}/homelab-trigger-deployment\" -H \"Content-Type: application/json\" -d '{\"secret\": \"${data.azurerm_key_vault_secret.deployment_secret.value}\"'"
  }
}

data "azurerm_storage_account_blob_container_sas" "script_sas" {
  connection_string = azurerm_storage_account.sa.primary_blob_connection_string
  container_name    = azurerm_storage_container.scripts.name
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