resource "azurerm_subnet" "hem-pub" {
  count = "${length(var.pub_sub)}"
  name                 = "pub_${count.index}" # ex) pub_0
  resource_group_name  = azurerm_resource_group.hem-rg.name
  virtual_network_name = azurerm_virtual_network.hem-vnet.name
  address_prefixes     = ["${var.pub_sub[count.index]}"]
}# subnet pub
