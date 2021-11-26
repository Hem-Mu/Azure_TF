resource "azurerm_network_security_group" "jen-sg" {
  name                = "jen-sg"
  location            = azurerm_resource_group.hem-rg.location
  resource_group_name = azurerm_resource_group.hem-rg.name

  security_rule {
    name                       = "jenkins"
    priority                   = 100 
    direction                  = "Inbound" # Inbound , Outbound
    access                     = "Allow" # Allow , Deny
    protocol                   = "Tcp"
    source_port_range          = "*" # 나가는 포트
    destination_port_range     = "8080" # 받는 포트
    source_address_prefix      = "*"  # 나가는 주소 192.168.0.1/24
    destination_address_prefix = "*"  # 받는 주소
  }
  security_rule {
    name                       = "ssh"
    priority                   = 110 
    direction                  = "Inbound" # Inbound , Outbound
    access                     = "Allow" # Allow , Deny
    protocol                   = "Tcp"
    source_port_range          = "*" # 나가는 포트
    destination_port_range     = "22" # 받는 포트
    source_address_prefix      = "*"  # 나가는 주소 192.168.0.1/24
    destination_address_prefix = "*"  # 받는 주소
  }
} # varialbe 작업 해야 함

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.jen-sub.id
  network_security_group_id = azurerm_network_security_group.jen-sg.id # sg 적용 할 subnet
}