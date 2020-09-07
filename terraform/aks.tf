resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks${local.name}"
  location            = local.region
  tags                = local.tags
  resource_group_name = azurerm_resource_group.rg.name
  node_resource_group = "rgaks${local.name}"
  dns_prefix          = local.name

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_D3_v2"
    node_count = 2
    tags       = local.tags
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id
    }

    kube_dashboard {
      enabled = true
    }
  }

  lifecycle {
    ignore_changes = [addon_profile.0.oms_agent.0.log_analytics_workspace_id]
  }
}

resource "azurerm_log_analytics_solution" "k8s" {
  solution_name         = "ContainerInsights"
  location              = local.region
  resource_group_name   = azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.la.id
  workspace_name        = azurerm_log_analytics_workspace.la.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

provider "kubernetes" {
  load_config_file       = false
  host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
  username               = azurerm_kubernetes_cluster.aks.kube_config.0.username
  password               = azurerm_kubernetes_cluster.aks.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
    username               = azurerm_kubernetes_cluster.aks.kube_config.0.username
    password               = azurerm_kubernetes_cluster.aks.kube_config.0.password
    client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
    load_config_file       = false
  }
}