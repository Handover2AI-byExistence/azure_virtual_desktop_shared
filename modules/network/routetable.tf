resource "azurerm_route_table" "udr" {
  name                          = "rt-${var.prefix}-${var.location_short}-001"
  location                      = azurerm_resource_group.net.location
  resource_group_name           = "rg-shs-${var.prefix}-${var.location_short}-${var.rg_network}"
  bgp_route_propagation_enabled = true

  tags = local.tags

  route {
    name                   = "InternetForceTunneling"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.next_hop_ip
  }

  #tags = local.tags

}
resource "azurerm_subnet_route_table_association" "udrasso" {
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = azurerm_route_table.udr.id
}

