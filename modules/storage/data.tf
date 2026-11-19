data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}


# generate a random string (consisting of four characters)
resource "random_string" "random" {
  length  = 4
  upper   = false
  special = false
}

# Moved from storage.tf
# Get Private DNS Zone for the Storage Private Endpoints
data "azurerm_private_dns_zone" "pe-filedns-zone" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.hub_dns_zone_rg
  provider            = azurerm.hub

}
/*
## Check Azure role assigment (powershell)
data "external" "check_assignment_sa_smb" {
  program = [
    "powershell",
    "-File",
    "./script/check_role_assignment.ps1",
    azurerm_storage_account.storage.id,
    data.azurerm_role_definition.storage_role.name,
    data.azuread_group.adds_group.object_id
  ]
}
*/
## https://docs.microsoft.com/azure/role-based-access-control/built-in-roles
data "azurerm_role_definition" "storage_role" {
  name = "Storage File Data SMB Share Contributor"
}

data "azurerm_role_definition" "kv_role" {
  name = "Key Vault Administrator"
}


# # Data source to get the existing virtual network
# data "azurerm_virtual_network" "vnet_migration" {
#   name                = "vnet-avd-migration-euw-001"
#   resource_group_name = "rg-avd-migration-euw-network"
# }

# # Data source to get all subnets in the virtual network
# data "azurerm_subnets" "all_subnets" {
#   virtual_network_name = data.azurerm_virtual_network.vnet_migration.name
#   resource_group_name  = data.azurerm_virtual_network.vnet_migration.resource_group_name
# }
