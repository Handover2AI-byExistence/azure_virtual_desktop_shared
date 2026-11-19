#-------------------------------------------------------------------------------------------------------------------------------------
# This fetches all data needed for deploy firewall rules
#-------------------------------------------------------------------------------------------------------------------------------------

# Fetch data from an existing Azure Firewall
data "azurerm_firewall_policy" "existing_policy" {
  provider            = azurerm.hub
  name                = var.fw_policy         #"mg-vz-fw-hub-westeurope-policy"
  resource_group_name = var.fw_resource_group #"mg-vz-connectivity"
}
