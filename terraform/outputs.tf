output "python_storage_connection_string" {
  value     = azurerm_storage_account.sa.primary_connection_string
  sensitive = true
}

output "python_storage_container_name" {
  value = azurerm_storage_container.python.name
}

output "deployment_secret" {
  value     = data.azurerm_key_vault_secret.deployment_secret.value
  sensitive = true
}