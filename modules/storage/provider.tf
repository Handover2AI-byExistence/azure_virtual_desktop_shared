terraform {
  # In modules we should only specify the min version
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      configuration_aliases = [
        azurerm, # default
        azurerm.hub,
        azurerm.management,
        azurerm.identity,
        azurerm.spoke,
        azurerm.avdshared
      ]
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
}
