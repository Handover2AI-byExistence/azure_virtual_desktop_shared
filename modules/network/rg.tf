resource "azurerm_resource_group" "net" {
  name     = "rg-shs-${var.prefix}-${var.location_short}-${var.rg_network}"
  location = var.Location
}
