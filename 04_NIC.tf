#   resource "azurerm_public_ip" "pub-ip" {
#     count = "${length(var.pub_sub)}"
#     name                = "pub-ip-${count.index}"
#     resource_group_name = azurerm_resource_group.hem-rg.name
#     location            = azurerm_resource_group.hem-rg.location
#     allocation_method   = "Static"
#   }# public ip create

# resource "azurerm_network_interface" "hem-NI" {
#   count = "${length(var.pub_sub)}"
#   name                = "hem-nic-${count.index}"
#   location            = azurerm_resource_group.hem-rg.location
#   resource_group_name = azurerm_resource_group.hem-rg.name

#   ip_configuration {
#     name                          = "pub-ip-${count.index}"
#     subnet_id                     = azurerm_subnet.hem-pub[count.index].id # subnet select
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id = azurerm_public_ip.pub-ip[count.index].id
#     #public ip insert
#   }
# }#network interface
