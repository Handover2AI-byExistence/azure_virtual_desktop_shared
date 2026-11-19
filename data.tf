data "azurerm_virtual_hub" "remote_migration" {
  provider            = azurerm.hub
  name                = var.hub_vnet
  resource_group_name = var.hub_connectivity_rg
}
