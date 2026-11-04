output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "reports_container" {
  value = azurerm_storage_container.reports.name
}

output "restricted_container" {
  value = azurerm_storage_container.restricted.name
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "client_id" {
  description = "Application (client) ID of the service principal."
  value       = var.create_service_principal ? azuread_application.app[0].client_id : null
}

output "service_principal_object_id" {
  value = var.create_service_principal ? azuread_service_principal.app[0].object_id : null
}

# Sensitive: do not print this in screenshots or commit it.
output "client_secret" {
  value     = var.create_service_principal ? azuread_application_password.app[0].value : null
  sensitive = true
}
