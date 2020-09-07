resource "random_password" "sp" {
  length  = 32
  special = true
  upper   = true
  lower   = true
  number  = true
}

resource "azuread_application" "app" {
  name = "tf-sp-${local.name}"
  required_resource_access {
    resource_app_id = "e406a681-f3d4-42a8-90b6-c2b029497af1"
    resource_access {
      id   = "03e0da56-190b-40ad-a80c-ea378c433f7f"
      type = "Scope"
    }
  }
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"
    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }
  }
}

resource "azuread_service_principal" "sp" {
  application_id = azuread_application.app.application_id
}

resource "time_rotating" "sp" {
  rotation_months = 1
}

resource "azuread_service_principal_password" "sp" {
  service_principal_id = azuread_service_principal.sp.id
  value                = random_password.sp.result
  end_date             = time_rotating.sp.rotation_rfc3339
}