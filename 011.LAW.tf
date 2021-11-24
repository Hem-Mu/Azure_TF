resource "azurerm_log_analytics_workspace" "law" {
  name                = "HemlogWorkspace"
  location            = azurerm_resource_group.hem-rg.location
  resource_group_name = azurerm_resource_group.hem-rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}