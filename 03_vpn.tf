resource "azurerm_virtual_network" "hem-vpn" {
  name                = "hem-network"
  resource_group_name = azurerm_resource_group.hem_RG.name
  location            = azurerm_resource_group.hem_RG.location
  address_space       = ["10.0.0.0/16"]
}#vpn