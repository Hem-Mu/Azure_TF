provider "azurerm" {
  features {
    }
}/*
    뒤에 붙은 수식어 따라 감
    resource_group_name = azurerm_resource_group.hem-rg.name --> name
    location            = azurerm_resource_group.hem-rg.location --> location
*/
resource "azurerm_resource_group" "hem-rg" {
  name     = "Hem-resources"
  location = var.region
}# setting resource group