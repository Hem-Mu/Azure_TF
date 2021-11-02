resource "azurerm_kubernetes_cluster" "hem-aks" {
  name                = "aks1"
  location            = azurerm_resource_group.hem-rg.location
  resource_group_name = azurerm_resource_group.hem-rg.name
  dns_prefix          = "exampleaks1"

  linux_profile {
        admin_username = "azureuser"

        ssh_key {
            key_data = file("../../.ssh/id_rsa.pub")
        }
    }

  default_node_pool {
    name       = "node"
    node_count = 2 # node 갯수
    vm_size    = "Standard_D2_v2"
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin = "azure" # CNI
    }

  identity {
    type = "SystemAssigned"
  } # 뭔지 모름
}
resource "azurerm_kubernetes_cluster_node_pool" "example" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.hem-aks.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1 #node pool의 개수
} # setting nodepool