  resource "azurerm_public_ip" "jen-ip" {
    name                = "jen-ip"
    resource_group_name = azurerm_resource_group.hem-rg.name
    location            = azurerm_resource_group.hem-rg.location
    allocation_method   = "Static"
  }# public ip create

resource "azurerm_network_interface" "hem-NI" {
  name                = "jen-nic"
  location            = azurerm_resource_group.hem-rg.location
  resource_group_name = azurerm_resource_group.hem-rg.name

  ip_configuration {
    name                          = "jen-ip"
    subnet_id                     = azurerm_subnet.jen-sub.id # subnet select
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.jen-ip.id
    #public ip insert
  }
  depends_on = [azurerm_public_ip.jen-ip]
}#network interface
