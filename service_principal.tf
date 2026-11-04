# Everything in this file is switched off by default.
# Set create_service_principal = true once you have permission to register apps in Entra ID.

# The application registration (the definition of the app)
resource "azuread_application" "app" {
  count        = var.create_service_principal ? 1 : 0
  display_name = "app-uvu-it3200-${var.student_name}"
}

# The service principal (the identity the app actually signs in as)
resource "azuread_service_principal" "app" {
  count     = var.create_service_principal ? 1 : 0
  client_id = azuread_application.app[0].client_id
}

# Temporary client secret for this lab. It is stored in Terraform state, so state is never committed.
resource "azuread_application_password" "app" {
  count             = var.create_service_principal ? 1 : 0
  application_id    = azuread_application.app[0].id
  display_name      = "lab-secret"
  end_date_relative = "720h"
}

# Part 4: least privilege. Blob data role, scoped to ONE container only.
# Switched on separately (assign_blob_role) so you can test access before the permission exists.
resource "azurerm_role_assignment" "blob_contributor" {
  count                = var.create_service_principal && var.assign_blob_role ? 1 : 0
  scope                = "${azurerm_storage_account.main.id}/blobServices/default/containers/${azurerm_storage_container.reports.name}"
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.app[0].object_id
  principal_type       = "ServicePrincipal"
}
