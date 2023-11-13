resource "azurerm_storage_container" "azurerm_storage_container-d1d44abb_c" {
  storage_account_name  = azurerm_storage_account.azurerm_storage_account-c07b98c1_c.name
  name                  = "storage-container"
  container_access_type = "private"
}

resource "azurerm_storage_blob" "azurerm_storage_blob-943c4cb2_c" {
  type                   = "Block"
  storage_container_name = azurerm_storage_container.azurerm_storage_container-d1d44abb_c.name
  storage_account_name   = azurerm_storage_account.azurerm_storage_account-c07b98c1_c.name
  name                   = "appServiceStorgeBlob"
}

resource "azurerm_storage_account" "azurerm_storage_account-c07b98c1_c" {
  tags                     = merge(var.tags)
  resource_group_name      = azurerm_resource_group.app-service-resource-group_c.name
  name                     = "brainboardstorageaccount"
  location                 = "France Central"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

