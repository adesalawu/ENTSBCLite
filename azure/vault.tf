# data "azurerm_windows_function_app" "default_c" {
#   resource_group_name = azurerm_resource_group.app-service-resource-group_c.name
#   name                = var.func_app_name
# }

# resource "azurerm_key_vault" "fun_app_c" {
#   tenant_id                = data.azurerm_client_config.current_c.tenant_id
#   tags                     = merge(var.tags, {})
#   sku_name                 = var.kv_sku
#   resource_group_name      = azurerm_resource_group.app-service-resource-group_c.name
#   purge_protection_enabled = false
#   name                     = var.kv_name
#   location                 = "France Central"

#   access_policy {
#     tenant_id = data.azurerm_client_config.current_c.tenant_id
#     object_id = data.azurerm_client_config.current_c.object_id
#     key_permissions = [
#       "Get",
#       "Create",
#       "List",
#     ]
#     secret_permissions = [
#       "Set",
#       "Get",
#       "Delete",
#       "Purge",
#       "Recover",
#       "List",
#     ]
#     storage_permissions = [
#       "Get",
#       "List",
#     ]
#   }
#   access_policy {
#     tenant_id = data.azurerm_client_config.current_c.tenant_id
#     object_id = var.user_object_id
#     key_permissions = [
#       "Get",
#       "Create",
#       "List",
#     ]
#     secret_permissions = [
#       "Set",
#       "Get",
#       "Delete",
#       "Purge",
#       "Recover",
#       "List",
#     ]
#     storage_permissions = [
#       "Get",
#       "List",
#       "Delete",
#       "Purge",
#     ]
#   }
# }

# resource "azurerm_key_vault_secret" "func_app_password_c" {
#   value        = "random_passowrd.func_app_password_c.result"
#   tags         = merge(var.tags, {})
#   name         = "func-app-password"
#   key_vault_id = azurerm_key_vault.fun_app_c.id
# }

