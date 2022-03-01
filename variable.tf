variable "resource_group_name" {
  description = "Resource group name to allocate VM"
  type        = string
}

variable "subnet_id" {
  description = "Subnet id to which VM would be attached to"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "module" {
  description = "Project module name"
  type        = string
}

variable "slot" {
  description = "Project slot name. Available values: shared, blue, green"
  type        = string
}

variable "vm_size" {
  description = ""
  type        = string
  default     = "Standard_B2s"
}

variable "vm_image" {
  description = "Image which vm should be allocated from"
  type = object({
    offer     = string
    publisher = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }
}

variable "username" {
  description = "Admin username for VM"
  type        = string
  default     = "shelob"
}

variable "password" {
  description = "Admin password for VM"
  type        = string
  default     = ""
}

variable "custom_tags" {
  description = "Custom tags to add"
  type        = map(string)
  default     = {}
}
