resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks1"
  location            = azurerm_resource_group.hem-rg.location
  resource_group_name = azurerm_resource_group.hem-rg.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "defaultnode"
    node_count = 2 # node 갯수
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}