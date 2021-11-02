resource "azurerm_resource_group" "hem-rg" {
  name     = "Hem-resources"
  location = var.region
}# setting resource group