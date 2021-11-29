resource "azurerm_virtual_machine" "vm" {
  name                = "hemkins"
  resource_group_name = azurerm_resource_group.hem-rg.name
  location            = azurerm_resource_group.hem-rg.location
  vm_size               = "Standard_DS1_v2"
  network_interface_ids = [
    azurerm_network_interface.hem-NI.id,
  ]
#   admin_ssh_key {
#     username   = "azureuser"
#     public_key = file(var.ssh_path)
#   }
    os_profile{
        computer_name = "hemkins"
        admin_username = "hemkins"
        admin_password = "q1q1q1q1q1q!"
        custom_data = filebase64("./jenkins.sh")
    }
    storage_os_disk {
        name = "jendisk"
        caching              = "ReadWrite"
        managed_disk_type = "Standard_LRS"
        create_option = "FromImage"
        /*
        Standard_LRS = HDD
        StandardSSD_LRS = SSD
        Premium_LRS = SSDv2
        */
    }
    storage_image_reference {
        publisher = "OpenLogic"
        offer     = "CentOS"
        sku       = "7_9"
        version   = "latest"
    }
    os_profile_linux_config {
    disable_password_authentication = false
  }
  depends_on = [azurerm_network_interface.hem-NI]
}
  
/*
  https://docs.microsoft.com/ko-kr/azure/virtual-machines/linux/cli-ps-findimage --> publisher, offer
  az vm image list --offer <OS name> --all --output table // CLI --> image sku search
*/
