output "vm_name" {
  value       = azurerm_virtual_machine.vm.name
  description = "Virtual machine name"
}

output "vm_id" {
  value       = azurerm_virtual_machine.vm.id
  description = "Virtual machine id"
}
