#-------------------------------------------------------------------------------------------------------------------------------------
# This section contains all network resources for Azure Virtual Desktop deployment
#-------------------------------------------------------------------------------------------------------------------------------------

resource "azurerm_virtual_network" "vnet" {
  #count               = try(length(data.azurerm_virtual_network.existing.id), 0) > 0 ? 0 : 1
  name                = "${var.vnet}-${var.prefix}-${var.location_short}-001"
  address_space       = var.vnet_range
  location            = azurerm_resource_group.net.location
  resource_group_name = azurerm_resource_group.net.name
  tags                = local.tags
  lifecycle { ignore_changes = [tags] }

  depends_on = [azurerm_resource_group.net]
}

resource "azurerm_subnet" "subnet" {
  name                              = "${var.snet}-${var.prefix}-${var.location_short}-001"
  resource_group_name               = "rg-shs-${var.prefix}-${var.location_short}-${var.rg_network}"
  virtual_network_name              = azurerm_virtual_network.vnet.name
  address_prefixes                  = var.subnet_range
  private_endpoint_network_policies = "Enabled"
  
  depends_on                        = [azurerm_resource_group.net]
}

resource "azurerm_subnet" "pesubnet" {
  name                              = "${var.pesnet}-${var.prefix}-${var.location_short}-001"
  resource_group_name               = "rg-shs-${var.prefix}-${var.location_short}-${var.rg_network}"
  virtual_network_name              = azurerm_virtual_network.vnet.name
  address_prefixes                  = var.pesubnet_range
  private_endpoint_network_policies = "Enabled"
  depends_on                        = [azurerm_resource_group.net]
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.res-0.id
  depends_on = [
    azurerm_subnet.subnet
  ]
}

resource "azurerm_virtual_hub_connection" "peer1" {
  name                      = "vhcon_${var.prefix}_shsspoke_hub"
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
  provider                  = azurerm.hub
  virtual_hub_id            = data.azurerm_virtual_hub.remote.id


  depends_on = [
    azurerm_virtual_network.vnet, azurerm_resource_group.net, azurerm_subnet.subnet
  ]

  lifecycle {
    ignore_changes = [virtual_hub_id]
  }

}

