data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "random_string" "disk_naming" {
  length  = 3
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "random_string" "password" {
  length  = 17
  lower   = true
  number  = true
  upper   = true
  special = false
}

resource "azurerm_network_interface" "nic" {
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  name                = join("-", ["nic", local.name_template])
  ip_configuration {
    name                          = join("-", ["ip", local.name_template])
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }
}

resource "azurerm_virtual_machine" "vm" {
  location              = data.azurerm_resource_group.rg.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  name                  = join("-", ["vm", local.name_template])
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size
  storage_os_disk {
    create_option = "FromImage"
    name          = join("-", ["osdisk", local.name_template, random_string.disk_naming.result])
  }
  storage_image_reference {
    offer     = var.vm_image.offer
    publisher = var.vm_image.publisher
    sku       = var.vm_image.sku
    version   = var.vm_image.version
  }
  os_profile {
    admin_username = var.username
    admin_password = coalesce(var.password, random_string.password.result)
    computer_name  = local.name_template
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}