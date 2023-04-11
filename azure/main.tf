terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.10.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "SBCSWELite" {
  name     = "${var.name}-rg"
  location = "West Europe"
}

resource "azurerm_communication_service" "SBCSWELite-acs" {
  name                = "${var.name}-acs"
  resource_group_name = azurerm_resource_group.SBCSWELite.name
  data_location       = "United States"
}

resource "azurerm_virtual_network" "SBCSWELite" {
  name                = "${var.name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.SBCSWELite.location
  resource_group_name = azurerm_resource_group.SBCSWELite.name
}

resource "azurerm_subnet" "internal1" {
  name                 = "${var.name}-internal1"
  resource_group_name  = azurerm_resource_group.SBCSWELite.name
  virtual_network_name = azurerm_virtual_network.SBCSWELite.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "internal2" {
  name                 = "${var.name}-internal2"
  resource_group_name  = azurerm_resource_group.SBCSWELite.name
  virtual_network_name = azurerm_virtual_network.SBCSWELite.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_interface" "SBCSWELite1" {
  name                = "${var.name}-nic1"
  location            = azurerm_resource_group.SBCSWELite.location
  resource_group_name = azurerm_resource_group.SBCSWELite.name

  ip_configuration {
    name                          = "${var.name}-LAN1"
    subnet_id                     = azurerm_subnet.internal1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "SBCSWELite2" {
  name                = "${var.prefix}-nic2"
  location            = azurerm_resource_group.SBCSWELite.location
  resource_group_name = azurerm_resource_group.SBCSWELite.name

  ip_configuration {
    name                          = "${var.name}-LAN2"
    subnet_id                     = azurerm_subnet.internal2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "SBCSWELite-sg" {
  name                = "${var.name}-sg"
  location            = azurerm_resource_group.SBCSWELite.location
  resource_group_name = azurerm_resource_group.SBCSWELite.name
}

resource "azurerm_network_security_rule" "webapp" {
  name                        = "WebApp-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.SBCSWELite.name
  network_security_group_name = azurerm_network_security_group.SBCSWELite-sg.name
}

resource "azurerm_subnet_network_security_group_association" "SBCSWELite-sga" {
  subnet_id                 = azurerm_subnet.internal2.id
  network_security_group_id = azurerm_network_security_group.SBCSWELite-sg.id
}

resource "azurerm_public_ip" "SBCSWELite-ipub" {
  name                = "${var.name}-ipub"
  resource_group_name = azurerm_resource_group.SBCSWELite.name
  location            = azurerm_resource_group.SBCSWELite.location
  allocation_method   = "Static"

}


resource "azurerm_virtual_machine" "SBCSWELite" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.SBCSWELite.location
  resource_group_name   = azurerm_resource_group.SBCSWELite.name
  network_interface_ids = [azurerm_network_interface.SBCSWELite1.id, azurerm_network_interface.SBCSWELite2.id]
  vm_size               = "Standard_B1ms"

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "ribboncommunications"
    offer     = "ribbon_sbc_swe-lite_vm"
    sku       = "ribbon_sbc_swe-lite_vm_release"
    version   = "11.00.358"
  }
  storage_os_disk {
    name              = "sbc-entdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  os_profile {
    computer_name  = "SBCSWELite"
    admin_username = "Administrator"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}