resource "azurerm_user_assigned_identity" "identity" {
    resource_group_name = azurerm_resource_group.hem-rg.name
    location            = azurerm_resource_group.hem-rg.location

    name = "identity1"
}

resource "azurerm_kubernetes_cluster" "hem-aks" {
  name                = "terraform-aks"
  location            = azurerm_resource_group.hem-rg.location
  resource_group_name = azurerm_resource_group.hem-rg.name
  dns_prefix          = "example-aks1"

  linux_profile {
        admin_username = var.ssh_name

        ssh_key {
            key_data = file(var.ssh_path)
        }
    }

  default_node_pool {
    name       = "node"
    # node_count = 2 # node 갯수
    vm_size    = "Standard_D2_v2"
    type       = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    max_count = "10" # autoscaling max nodes
    min_count = "2" # autoscaling min nodes
    vnet_subnet_id = azurerm_subnet.hem-pub[0].id # azure CNI subnet
  } # setting nodepool

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin = "azure" # CNI
    network_policy = "calico"
    service_cidr = "10.0.0.0/16"
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip = "10.0.10.0"
    }

  identity {
    type = "SystemAssigned"
  } # Cluster ID type
  
  role_based_access_control {
    enabled = true
    }

}

# resource "azurerm_public_ip" "agw-ip" {
#     name                         = "AGW-ip"
#     location                     = azurerm_resource_group.hem-rg.location
#     resource_group_name          = azurerm_resource_group.hem-rg.name
#     allocation_method            = "Static"
# } # AGW IP

# resource "azurerm_application_gateway" "agw" {
#     name                = "AGW"
#     resource_group_name = azurerm_resource_group.hem-rg.name
#     location            = azurerm_resource_group.hem-rg.location

#     sku {
#     name     = "Standard_v2"
#     tier     = "Standard_v2"
#     capacity = 2
#     }

#     gateway_ip_configuration {
#     name      = "appGatewayIpConfig"
#     subnet_id = azurerm_subnet.hem-pub[1].id
#     }

#     frontend_port {
#     name = "httpPort"
#     port = 80
#     }

#     frontend_port {
#     name = "httpsPort"
#     port = 443
#     }

#     frontend_ip_configuration {
#     name                 = "front_ip"
#     public_ip_address_id = azurerm_public_ip.agw-ip.id
#     }

#     backend_address_pool {
#     name = "backend_pool"
#     }

#     backend_http_settings {
#     name                  = "http_setting"
#     cookie_based_affinity = "Disabled"
#     port                  = 80
#     protocol              = "Http"
#     request_timeout       = 1
#     }

#     http_listener {
#     name                           = "listener"
#     frontend_ip_configuration_name = "frontend_ip_configuration"
#     frontend_port_name             = "frontend_port"
#     protocol                       = "Http"
#     }

#     request_routing_rule {
#     name                       = "request_routing_rule"
#     rule_type                  = "Basic"
#     http_listener_name         = "listener"
#     backend_address_pool_name  = "backend_address_pool"
#     backend_http_settings_name = "http_setting"
#     }

#     depends_on = [azurerm_virtual_network.hem-vnet, azurerm_public_ip.agw-ip]
# }

# resource "azurerm_role_assignment" "ra1" {
#     scope                = azurerm_subnet.hem-pub[0].id
#     role_definition_name = "Network Contributor"
#     principal_id         = var.aks_service_principal_object_id 

#     depends_on = [azurerm_virtual_network.test]
# }

# resource "azurerm_role_assignment" "ra2" {
#     scope                = azurerm_user_assigned_identity.identity.id
#     role_definition_name = "Managed Identity Operator"
#     principal_id         = var.aks_service_principal_object_id
#     depends_on           = [azurerm_user_assigned_identity.identity]
# }

# resource "azurerm_role_assignment" "ra3" {
#     scope                = azurerm_application_gateway.agw.id
#     role_definition_name = "Contributor"
#     principal_id         = azurerm_user_assigned_identity.identity.principal_id
#     depends_on           = [azurerm_user_assigned_identity.identity, azurerm_application_gateway.network]
# }

# resource "azurerm_role_assignment" "ra4" {
#     scope                = azurerm_resource_group.hem-rg.id
#     role_definition_name = "Reader"
#     principal_id         = azurerm_user_assigned_identity.identity.principal_id
#     depends_on           = [azurerm_user_assigned_identity.identity, azurerm_application_gateway.network]
# }