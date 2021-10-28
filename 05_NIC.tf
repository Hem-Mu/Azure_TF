resource "azurerm_public_ip" "pub-ip" {
  name                = "pub-ip"
  resource_group_name = azurerm_resource_group.hem-rg.name
  location            = azurerm_resource_group.hem-rg.location
  allocation_method   = "Static"
}#public ip create

resource "azurerm_network_interface" "hem-NI" {
  name                = "hem-nic"
  location            = azurerm_resource_group.hem-rg.location
  resource_group_name = azurerm_resource_group.hem-rg.name

  ip_configuration {
    name                          = "pub-ip"
    subnet_id                     = azurerm_subnet.hem-pub1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pub-ip.id
    #public ip push
  }
}#network interface
