resource "azurerm_resource_group" "main" {
  name     = "rg-uvu-it3200-${var.student_name}"
  location = var.location
}

resource "azurerm_storage_account" "main" {
  name                = "stuvuit3200${var.student_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  # Security settings
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
}

# The container the application is allowed to use
resource "azurerm_storage_container" "reports" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}

# A second container with no access for the app, used for the negative test
resource "azurerm_storage_container" "restricted" {
  name                  = var.restricted_container_name
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}
