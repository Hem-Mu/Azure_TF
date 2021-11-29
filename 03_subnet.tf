resource "azurerm_subnet" "aks-sub" {
  name                 = "aks-sub" # ex) pub_0
  resource_group_name  = azurerm_resource_group.hem-rg.name
  virtual_network_name = azurerm_virtual_network.hem-vnet.name
  address_prefixes     = ["10.240.0.0/16"]
}# pri
resource "azurerm_subnet" "agw-sub" {
  name                 = "agw-sub" # ex) pub_0
  resource_group_name  = azurerm_resource_group.hem-rg.name
  virtual_network_name = azurerm_virtual_network.hem-vnet.name
  address_prefixes     = ["10.1.0.0/16"]
}# pub
resource "azurerm_subnet" "db-sub" {
  name                 = "db-sub" # ex) pri_0
  resource_group_name  = azurerm_resource_group.hem-rg.name
  virtual_network_name = azurerm_virtual_network.hem-vnet.name
  address_prefixes     = ["10.255.255.248/29"]
  enforce_private_link_endpoint_network_policies = true
}# pri
resource "azurerm_subnet" "jen-sub" {
  name                 = "jen-sub" # ex) pub_0
  resource_group_name  = azurerm_resource_group.hem-rg.name
  virtual_network_name = azurerm_virtual_network.hem-vnet.name
  address_prefixes     = ["10.255.255.128/29"]
}# pub