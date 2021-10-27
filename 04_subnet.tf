resource "azurerm_subnet" "hem-pub1" {
  name                 = "pub1"
  resource_group_name  = azurerm_resource_group.hem_RG.name
  virtual_network_name = azurerm_virtual_network.hem-vpn.name
  address_prefixes     = ["10.0.0.0/24"]
}#subnet pub1
resource "azurerm_subnet" "hem-pri1" {
  name                 = "pri1"
  resource_group_name  = azurerm_resource_group.hem_RG.name
  virtual_network_name = azurerm_virtual_network.hem-vpn.name
  address_prefixes     = ["10.0.1.0/24"]
}#subnet pri1