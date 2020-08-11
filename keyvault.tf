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