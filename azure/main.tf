resource "azurerm_resource_group" "app-service-resource-group_c" {
  tags     = merge(var.tags)
  name     = var.rg_name
  location = "France Central"
}

