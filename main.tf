
resource "azurerm_resource_group" "example" {
    name     = var.resource_group_name
    location = var.location
}

resource "azurerm_app_service_plan" "example" {
    name                = var.app_service_plan_name
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    sku {
        tier = "Standard"
        size = "S1"
    }
}

resource "azurerm_app_service" "example" {
    name                = var.app_service_name
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    app_service_plan_id = azurerm_app_service_plan.example.id
}

resource "azurerm_application_insights" "example" {
    name                = var.application_insights_name
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    application_type    = "web"
}

resource "azurerm_key_vault" "example" {
    name                = var.key_vault_name
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    sku_name            = "standard"
    tenant_id           = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_access_policy" "example" {
    key_vault_id = azurerm_key_vault.example.id
    tenant_id    = data.azurerm_client_config.current.tenant_id
    object_id    = azurerm_app_service.example.identity[0].principal_id

    secret_permissions = [
        "get",
        "list",
    ]
}

resource "azurerm_service_principal" "example" {
    application_id = azurerm_app_service.example.application_id
}

resource "azurerm_role_assignment" "example" {
    principal_id         = azurerm_service_principal.example.id
    role_definition_name = "Contributor"
    scope                = azurerm_resource_group.example.id
}

resource "azurerm_ad_application" "example" {
    name                       = var.ad_application_name
    homepage                   = "http://example.com"
    identifier_uris            = ["http://example.com"]
    available_to_other_tenants = true
}

resource "azurerm_ad_service_principal" "example" {
    application_id = azurerm_ad_application.example.application_id
}

resource "azurerm_ad_service_principal_password" "example" {
    service_principal_id = azurerm_ad_service_principal.example.id
    value                = var.ad_service_principal_password
    end_date             = "2099-01-01T01:02:03Z"
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