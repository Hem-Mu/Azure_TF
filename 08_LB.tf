resource "azurerm_public_ip" "lb-ip" {
  name                = "LB-ip"
  location            = "Korea Central"
  resource_group_name = azurerm_resource_group.hem-rg.name
  allocation_method   = "Static"
}# frontend ip create

resource "azurerm_lb" "lb" {
  name                = "testlb"
  location            = "Korea Central"
  resource_group_name = azurerm_resource_group.hem-rg.name
  sku                 = "Basic" # Standard , Basic(Default)
  sku_tier            = "Regional" # Regional(Basic), Global

  frontend_ip_configuration {
    name                 = "LB-front-ip"
    public_ip_address_id = azurerm_public_ip.lb-ip.id
  }
}# LB create

resource "azurerm_lb_backend_address_pool" "backend" {
    loadbalancer_id     = azurerm_lb.lb.id
    name                = "BackEndPool"
}# Backend

resource "azurerm_lb_probe" "lb-probe" {
 resource_group_name = azurerm_resource_group.hem-rg.name
 loadbalancer_id     = azurerm_lb.lb.id
 name                = "http-running-probe"
 port                = 80
}

resource "azurerm_lb_rule" "lbnatrule" {
   resource_group_name            = azurerm_resource_group.hem-rg.name
   loadbalancer_id                = azurerm_lb.lb.id
   name                           = "http"
   protocol                       = "Tcp"
   frontend_port                  = 80
   backend_port                   = 100
   backend_address_pool_id        = azurerm_lb_backend_address_pool.backend.id
   frontend_ip_configuration_name = "LB-front-ip" # azurerm_lb 의 frontend_ip_configuration name 이랑 같아야 함
   probe_id                       = azurerm_lb_probe.lb-probe.id
}