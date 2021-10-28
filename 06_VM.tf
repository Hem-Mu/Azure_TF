# resource "azurerm_linux_virtual_machine" "vm" {
#   name                = "tf-test"
#   resource_group_name = azurerm_resource_group.hem-rg.name
#   location            = azurerm_resource_group.hem-rg.location
#   size                = "Standard_D2s_v3"
#   admin_username      = "azureuser"
#   network_interface_ids = [
#     azurerm_network_interface.hem-NI.id,
#   ]

#   admin_ssh_key {
#     username   = "azureuser"
#     public_key = file("../../.ssh/id_rsa.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "StandardSSD_LRS"
#     /*
#       Standard_LRS = HDD
#       StandardSSD_LRS = SSD
#       Premium_LRS = SSDv2
#     */
#   }

#   source_image_reference {
#     publisher = "OpenLogic"
#     offer     = "CentOS"
#     sku       = "7_9"
#     version   = "latest"
#   }
# }
# /*
#   https://docs.microsoft.com/ko-kr/azure/virtual-machines/linux/cli-ps-findimage --> publisher, offer
#   az vm image list --offer <OS name> --all --output table // CLI --> image sku search
# */
