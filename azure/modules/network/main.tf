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

resource "azurerm_network_security_rule" "sbc_rule" {
  name                        = "allow-sbc-traffic"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["5060", "5061", "5080", "5081"]
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

