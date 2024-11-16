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

