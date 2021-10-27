resource "azurerm_network_security_group" "pri_sg" {
  name                = "pri_sg"
  location            = azurerm_resource_group.hem_RG.location
  resource_group_name = azurerm_resource_group.hem_RG.name

  security_rule {
    name                       = "ssl"
    priority                   = 100 
    direction                  = "Inbound" # Inbound , Outbound
    access                     = "Allow" # Allow , Deny
    protocol                   = "Tcp"
    source_port_range          = "*" # 나가는 포트
    destination_port_range     = "22" # 받는 포트
    source_address_prefix      = "10.100.0.0/16"  # 나가는 주소 192.168.0.1/24
    destination_address_prefix = "*"  # 받는 주소
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.hem-pri1.id
  network_security_group_id = azurerm_network_security_group.pri_sg.id # sg 적용 할 subnet
}