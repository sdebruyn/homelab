resource "azurerm_resource_group" "aks" {
  location = local.region
  name     = "rgaks${local.name}"
  tags     = local.tags
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks${local.name}"
  location            = local.region
  tags                = local.tags
  resource_group_name = azurerm_resource_group.rg.name
  node_resource_group = azurerm_resource_group.aks.name
  dns_prefix          = local.name

  service_principal {
    client_id     = azuread_application.app.application_id
    client_secret = random_password.sp.result
  }

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_D3_v2"
    node_count = 2
  }
}