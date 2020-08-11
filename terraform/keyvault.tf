resource "azurerm_key_vault" "kv" {
  location                 = local.region
  resource_group_name      = azurerm_resource_group.rg.name
  enabled_for_deployment   = true
  purge_protection_enabled = false
  soft_delete_enabled      = false
  tags                     = local.tags
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  name                     = "kv${local.name}"
}

resource "azurerm_key_vault_access_policy" "self" {
  key_vault_id            = azurerm_key_vault.kv.id
  object_id               = data.azurerm_client_config.current.object_id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  secret_permissions      = local.kv_all_secret_permissions
  certificate_permissions = local.kv_all_cert_permissions
  key_permissions         = local.kv_all_key_permissions
  storage_permissions     = local.kv_all_storage_permissions
}

resource "azurerm_key_vault_secret" "python_sas" {
  depends_on = [
  azurerm_key_vault_access_policy.self]
  key_vault_id = azurerm_key_vault.kv.id
  name         = "python_sas"
  value        = data.azurerm_storage_account_blob_container_sas.python_sas.sas
}