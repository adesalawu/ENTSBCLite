output "azurerm_resource_group_name" {
  value = azurerm_resource_group.SBC-rg.name
}

output "azuread_group_name" {
  value = azuread_group.SBC-rg.display_name
}