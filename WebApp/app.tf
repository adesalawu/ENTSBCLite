resource "azurerm_app_service_plan" "azurerm_app_service_plan-62b3b490_c" {
  tags                = merge(var.tags)
  resource_group_name = azurerm_resource_group.app-service-resource-group_c.name
  name                = var.app-service-plan-name
  location            = "France Central"

  sku {
    tier = var.app-service-tier
    size = var.app-service-sku-size
  }
}

resource "azurerm_app_service" "app-service_c" {
  tags                = merge(var.tags)
  resource_group_name = azurerm_resource_group.app-service-resource-group_c.name
  name                = var.app-service-name
  location            = "France Central"
  app_service_plan_id = azurerm_app_service_plan.azurerm_app_service_plan-62b3b490_c.id
}

