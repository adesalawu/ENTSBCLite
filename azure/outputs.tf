output "azurerm_resource_group_name" {
  value = azurerm_resource_group.SBC-rg.name
}

output "azuread_group_name" {
  value = azuread_group.SBC-rg.display_name
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.example.name
}

output "virtual_network_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.example.name
}

output "vm_id" {
  description = "The ID of the Virtual Machine"
  value       = azurerm_windows_virtual_machine.example.id
}

output "vm_public_ip" {
  description = "The public IP address of the Virtual Machine"
  value       = azurerm_network_interface.example.private_ip_address
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.example.name
}

output "storage_account_primary_access_key" {
  description = "The primary access key for the Storage Account"
  value       = azurerm_storage_account.example.primary_access_key
}

output "sql_server_name" {
  description = "The name of the SQL server"
  value       = azurerm_sql_server.example.name
}

output "sql_database_name" {
  description = "The name of the SQL database"
  value       = azurerm_sql_database.example.name
}


output "resource_group_name" {
    value = azurerm_resource_group.example.name
}

output "app_service_plan_id" {
    value = azurerm_app_service_plan.example.id
}

output "app_service_id" {
    value = azurerm_app_service.example.id
}

output "application_insights_id" {
    value = azurerm_application_insights.example.id
}

output "key_vault_id" {
    value = azurerm_key_vault.example.id
}

output "ad_application_id" {
    value = azurerm_ad_application.example.application_id
}

output "ad_service_principal_id" {
    value = azurerm_ad_service_principal.example.id
}