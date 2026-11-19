resource "azurerm_network_security_group" "res-0" {
  location            = azurerm_resource_group.net.location
  name                = "nsg-${var.prefix}-${var.location_short}-001"
  resource_group_name = azurerm_resource_group.net.name
  tags                = local.tags

  
  security_rule {
    access                     = "Allow"
    destination_address_prefix = "VirtualNetwork"
    destination_port_range     = "443"
    direction                  = "Inbound"
    name                       = "Allow-PE-subnet"
    priority                   = 110
    protocol                   = "Tcp"
    source_address_prefix      = "VirtualNetwork"
    source_port_range          = "*"
  }
}  
