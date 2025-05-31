
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


resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.resource_group_name}-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.net1.id, azurerm_network_interface.net2.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "ribboncommunications"
    offer     = "ribbon_sbc_swe-lite_vm"
    sku       = "ribbon_sbc_swe-lite_vm_release"
    version   = "11.00.358"
  }

  storage_os_disk {
    name              = "sbc-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "SBC-SWeLite"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}

resource "azurerm_communication_service" "acs" {
  name                = var.resource_group_name
  resource_group_name = azurerm_resource_group.rg.name
  data_location       = var.data_location
}


resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_group_name}-vnet"
  address_space       = [var.cidr]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.example.id
  }

}

resource "azurerm_network_interface" "net1" {
  name                = "${var.resource_group_name}-nic1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.resource_group_name}-config1"
    subnet_id                     = azurerm_subnet.nic1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "net2" {
  name                = "${var.resource_group_name}-nic2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.resource_group_name}-config2"
    subnet_id                     = azurerm_subnet.nic2.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_subnet" "nic1" {
  name                 = "${var.resource_group_name}-subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.nic1_cidr]
}

resource "azurerm_subnet" "nic2" {
  name                 = "${var.resource_group_name}-subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.nic2_cidr]
}



resource "azurerm_network_security_group" "sg" {
  name                = "${var.resource_group_name}-sg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "sbc-smi" {
  name                        = "Signaling & Media Interface"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["${[var.tcp_ports, var.udp_ports]}"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.sg.name
}


resource "azurerm_network_security_rule" "Management-Subnet" {
  name                        = "Management-Subnet"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.sg.name
}


resource "azurerm_subnet_network_security_group_association" "sga" {
  subnet_id                 = [azurerm_subnet.nic1.id, azurerm_subnet.nic2.id]
  network_security_group_id = azurerm_network_security_group.sg.id
}


resource "azurerm_public_ip" "pub_ip" {
  name                = "${var.resource_group_name}-pub-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}


resource "azurerm_dns_a_record" "dns_a_record" {
  zone_name           = azurerm_dns_zone.dns_zone.name
  ttl                 = 300
  resource_group_name = azurerm_resource_group.rg.name
  name                = "sbc-record"
  records             = ["10.0.180.17"]
}

resource "azurerm_dns_zone" "dns_zone" {
  name                = "app-service.example.com"
  resource_group_name = azurerm_resource_group.rg.name
}


resource "azurerm_storage_account" "storage_account" {
  name                     = "Managed Disk"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_account" "storage_account_2" {
  name                     = "Diagnostic"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
