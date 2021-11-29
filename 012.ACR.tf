resource "azurerm_container_registry" "acr" {
  name                = "hemgistry"
  resource_group_name = azurerm_resource_group.hem-rg.name
  location            = azurerm_resource_group.hem-rg.location
  sku                 = "Basic"
  admin_enabled       = true
}
# az aks update -n terraform-aks -g hem-resources --attach-acr hemgistry
resource "azurerm_role_assignment" "ra5" {
    scope                = azurerm_container_registry.acr.id
    role_definition_name = "AcrPull"
    principal_id         = var.aks_service_principal_object_id
}