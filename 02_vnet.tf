resource "azurerm_virtual_network" "hem-vnet" {
  name                = "hem-network"
  resource_group_name = azurerm_resource_group.hem-rg.name
  location            = azurerm_resource_group.hem-rg.location
  address_space       = ["10.0.0.0/24"]
}# setting vnet