resource "azurerm_resource_group" "app-service-resource-group_c" {
  tags     = merge(var.tags)
  name     = var.rg_name
  location = "France Central"
}

resource "azurerm_resource_group" "default-rg_c" {
  name     = "${var.prefix}-resources"
  location = var.location

  tags = {
    env      = "Staging"
    archUUID = "358e6e70-42f0-48d2-a0b2-0c2618bbd2c1"
  }
}

resource "azurerm_api_management" "apim_service_c" {
  sku_name            = "Developer_1"
  resource_group_name = azurerm_resource_group.default-rg_c.name
  publisher_name      = "Brainboard Publisher"
  publisher_email     = "contact@brainboard.co"
  name                = "${var.prefix}-apim-service"
  location            = var.location

  policy {
    xml_content = <<XML
    <policies>
      <inbound />
      <backend />
      <outbound />
      <on-error />
    </policies>
XML
  }

  tags = {
    Name = "Brainboard RG"
    Env  = "Development"
  }
}

resource "azurerm_api_management_api" "mapi_c" {
  revision            = "1"
  resource_group_name = azurerm_resource_group.default-rg_c.name
  path                = "Brainboard"
  name                = "${var.prefix}-api"
  display_name        = "${var.prefix}-api"
  description         = "Brainboard management API"
  api_management_name = azurerm_api_management.apim_service_c.name

  import {
    content_value  = var.open_api_spec_content_value
    content_format = var.open_api_spec_content_format
  }

  protocols = [
    "http",
    "https",
  ]
}

resource "azurerm_api_management_product" "product_c" {
  subscription_required = true
  resource_group_name   = azurerm_resource_group.default-rg_c.name
  published             = true
  product_id            = "${var.prefix}-product"
  display_name          = "${var.prefix}-product"
  description           = "Brainboard product"
  approval_required     = false
  api_management_name   = azurerm_api_management.apim_service_c.name
}

resource "azurerm_api_management_group" "group_c" {
  resource_group_name = azurerm_resource_group.default-rg_c.name
  name                = "${var.prefix}-group"
  display_name        = "${var.prefix}-group"
  description         = "Brainboard group"
  api_management_name = azurerm_api_management.apim_service_c.name
}

resource "azurerm_api_management_product_api" "product_api_c" {
  resource_group_name = azurerm_resource_group.default-rg_c.name
  product_id          = azurerm_api_management_product.product_c.product_id
  api_name            = azurerm_api_management_api.mapi_c.name
  api_management_name = azurerm_api_management.apim_service_c.name
}

resource "azurerm_api_management_product_group" "product_group_c" {
  resource_group_name = azurerm_resource_group.default-rg_c.name
  product_id          = azurerm_api_management_product.product_c.product_id
  group_name          = azurerm_api_management_group.group_c.name
  api_management_name = azurerm_api_management.apim_service_c.name
}

