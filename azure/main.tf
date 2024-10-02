
locals {
}

resource "azurerm_dns_a_record" "dns_a_record_c" {
  zone_name           = azurerm_dns_zone.dns-zone_c.name
  ttl                 = 300
  tags                = merge(var.tags)
  resource_group_name = azurerm_resource_group.app-service-resource-group_c.name
  name                = "app-service-a-record"

  records = [
    "10.0.180.17",
  ]
}

resource "azurerm_dns_zone" "dns-zone_c" {
  tags                = merge(var.tags)
  resource_group_name = azurerm_resource_group.app-service-resource-group_c.name
  name                = "app-service.brainboard.co"
}



# resource "azurerm_resource_group" "SBCSWELite" {
#   name     = "${var.name}"
#   location = "West Europe"
# }

# resource "azurerm_communication_service" "SBCSWELite-acs" {
#   name                = "${var.name}-acs"
#   resource_group_name = azurerm_resource_group.SBCSWELite.name
#   data_location       = "United States"
# }

# resource "azurerm_virtual_network" "SBCSWELite" {
#   name                = "${var.name}-network"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.SBCSWELite.location
#   resource_group_name = azurerm_resource_group.SBCSWELite.name
# }

# resource "azurerm_subnet" "internal1" {
#   name                 = "${var.name}-internal1"
#   resource_group_name  = azurerm_resource_group.SBCSWELite.name
#   virtual_network_name = azurerm_virtual_network.SBCSWELite.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

# resource "azurerm_subnet" "internal2" {
#   name                 = "${var.name}-internal2"
#   resource_group_name  = azurerm_resource_group.SBCSWELite.name
#   virtual_network_name = azurerm_virtual_network.SBCSWELite.name
#   address_prefixes     = ["10.0.3.0/24"]
# }

# resource "azurerm_network_interface" "SBCSWELite1" {
#   name                = "${var.name}-nic1"
#   location            = azurerm_resource_group.SBCSWELite.location
#   resource_group_name = azurerm_resource_group.SBCSWELite.name

#   ip_configuration {
#     name                          = "${var.name}-LAN1"
#     subnet_id                     = azurerm_subnet.internal1.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_network_interface" "SBCSWELite2" {
#   name                = "${var.prefix}-nic2"
#   location            = azurerm_resource_group.SBCSWELite.location
#   resource_group_name = azurerm_resource_group.SBCSWELite.name

#   ip_configuration {
#     name                          = "${var.name}-LAN2"
#     subnet_id                     = azurerm_subnet.internal2.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_network_security_group" "SBCSWELite-sg" {
#   name                = "${var.name}-sg"
#   location            = azurerm_resource_group.SBCSWELite.location
#   resource_group_name = azurerm_resource_group.SBCSWELite.name
# }

# resource "azurerm_network_security_rule" "webapp" {
#   name                        = "WebApp-rule"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.SBCSWELite.name
#   network_security_group_name = azurerm_network_security_group.SBCSWELite-sg.name
# }

# resource "azurerm_subnet_network_security_group_association" "SBCSWELite-sga" {
#   subnet_id                 = azurerm_subnet.internal2.id
#   network_security_group_id = azurerm_network_security_group.SBCSWELite-sg.id
# }

# resource "azurerm_public_ip" "SBCSWELite-ipub" {
#   name                = "${var.name}-ipub"
#   resource_group_name = azurerm_resource_group.SBCSWELite.name
#   location            = azurerm_resource_group.SBCSWELite.location
#   allocation_method   = "Static"

# }


# resource "azurerm_virtual_machine" "SBCSWELite" {
#   name                  = "${var.prefix}-vm"
#   location              = azurerm_resource_group.SBCSWELite.location
#   resource_group_name   = azurerm_resource_group.SBCSWELite.name
#   network_interface_ids = [azurerm_network_interface.SBCSWELite1.id, azurerm_network_interface.SBCSWELite2.id]
#   vm_size               = "Standard_B1ms"

#   delete_data_disks_on_termination = true

#   storage_image_reference {
#     publisher = "ribboncommunications"
#     offer     = "ribbon_sbc_swe-lite_vm"
#     sku       = "ribbon_sbc_swe-lite_vm_release"
#     version   = "11.00.358"
#   }
#   storage_os_disk {
#     name              = "sbc-entdisk1"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Premium_LRS"
#   }
#   os_profile {
#     computer_name  = "SBCSWELite"
#     admin_username = "Administrator"
#     admin_password = "Password1234!"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
#   tags = {
#     environment = "staging"
#   }
# }

# resource "azurerm_app_service_plan" "azurerm_app_service_plan-62b3b490_c" {
#   tags                = merge(var.tags)
#   resource_group_name = azurerm_resource_group.app-service-resource-group_c.name
#   name                = var.app-service-plan-name
#   location            = "France Central"

#   sku {
#     tier = var.app-service-tier
#     size = var.app-service-sku-size
#   }
# }

# resource "azurerm_app_service" "app-service_c" {
#   tags                = merge(var.tags)
#   resource_group_name = azurerm_resource_group.app-service-resource-group_c.name
#   name                = var.app-service-name
#   location            = "France Central"
#   app_service_plan_id = azurerm_app_service_plan.azurerm_app_service_plan-62b3b490_c.id
# }

# resource "azurerm_sql_database" "azurerm_sql_database-5124ee2d_c" {
#   tags                = merge(var.tags)
#   server_name         = azurerm_sql_server.azurerm_sql_server-0e44baf8_c.name
#   resource_group_name = azurerm_resource_group.app-service-resource-group_c.name
#   name                = var.sql-db-name
#   location            = "France Central"
# }

# resource "azurerm_sql_server" "azurerm_sql_server-0e44baf8_c" {
#   version                      = "12.0"
#   tags                         = merge(var.tags)
#   resource_group_name          = azurerm_resource_group.app-service-resource-group_c.name
#   name                         = var.sql-server-name
#   location                     = "France Central"
#   administrator_login_password = "AVyP#KtW^#ul)6rwIgh?)>F+Cn50s"
#   administrator_login          = var.sql-server-admin-user
# }

resource "azurerm_storage_blob" "azurerm_storage_blob-943c4cb2_c" {
  type                   = "Block"
  storage_container_name = azurerm_storage_container.azurerm_storage_container-d1d44abb_c.name
  storage_account_name   = azurerm_storage_account.azurerm_storage_account-c07b98c1_c.name
  name                   = "appServiceStorgeBlob"
}

resource "azurerm_storage_container" "azurerm_storage_container-d1d44abb_c" {
  storage_account_name  = azurerm_storage_account.azurerm_storage_account-c07b98c1_c.name
  name                  = "storage-container"
  container_access_type = "private"
}

resource "azurerm_storage_account" "azurerm_storage_account-c07b98c1_c" {
  tags                     = merge(var.tags)
  resource_group_name      = azurerm_resource_group.app-service-resource-group_c.name
  name                     = "brainboardstorageaccount"
  location                 = "France Central"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# resource "azurerm_sql_database" "azurerm_sql_database-5124ee2d_c" {
#   tags                = merge(var.tags)
#   server_name         = azurerm_sql_server.azurerm_sql_server-0e44baf8_c.name
#   resource_group_name = azurerm_resource_group.app-service-resource-group_c.name
#   name                = var.sql-db-name
#   location            = "France Central"
# }

# resource "azurerm_sql_server" "azurerm_sql_server-0e44baf8_c" {
#   version                      = "12.0"
#   tags                         = merge(var.tags)
#   resource_group_name          = azurerm_resource_group.app-service-resource-group_c.name
#   name                         = var.sql-server-name
#   location                     = "France Central"
#   administrator_login_password = "AVyP#KtW^#ul)6rwIgh?)>F+Cn50s"
#   administrator_login          = var.sql-server-admin-user
# }
