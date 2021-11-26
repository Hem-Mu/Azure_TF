resource "azurerm_public_ip" "agw-ip" {
    name                         = "AGW-ip"
    location                     = azurerm_resource_group.hem-rg.location
    resource_group_name          = azurerm_resource_group.hem-rg.name
    allocation_method            = "Static"
    sku                          = "Standard"
} # AGW IP

resource "azurerm_application_gateway" "agw" {
    name                = "AGW"
    resource_group_name = azurerm_resource_group.hem-rg.name
    location            = azurerm_resource_group.hem-rg.location

    sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
    }

    gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.agw-sub.id # frontend subnet
    }

    frontend_port {
    name = "httpPort"
    port = 80
    }

    frontend_port {
    name = "httpsPort"
    port = 443
    }

    frontend_ip_configuration {
    name                 = "front_ip"
    public_ip_address_id = azurerm_public_ip.agw-ip.id # frontend ip
    }

    backend_address_pool {
    name = "backend_pool"
    }

    backend_http_settings {
    name                  = "http_setting"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
    } # Http

    http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = "front_ip"
    frontend_port_name             = "httpPort"
    protocol                       = "Http"
    } # Http
    
    request_routing_rule {
    name                       = "http_routing_rule"
    rule_type                  = "Basic"
    http_listener_name         = "listener"
    backend_address_pool_name  = "backend_pool"
    backend_http_settings_name = "http_setting"
    } # Http

    ssl_certificate{
        name = "hamcert"
        data = filebase64("./certificate.pfx")
        password = "it1"
    } # ssl add
    depends_on = [azurerm_public_ip.agw-ip]
}