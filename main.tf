
# Creates the Azure Virtual Desktop Spoke Network resources
module "network" {

  source = "./modules/network"

  providers = {
    azurerm            = azurerm
    azurerm.hub        = azurerm.hub
    azurerm.management = azurerm.management
    azurerm.identity   = azurerm.identity
    azurerm.spoke      = azurerm.spoke
    azurerm.avdshared  = azurerm.avdshared
  }

  Location            = var.location
  location_short      = var.location_short
  rg_network          = var.rg_network
  vnet                = var.vnet
  snet                = var.snet
  pesnet              = var.pesnet
  vnet_range          = var.vnet_range
  nsg                 = "${var.nsg}-${var.prefix}-${var.location_short}"
  prefix              = var.prefix
  rt                  = "${var.rt}-${var.prefix}-${var.location_short}"
  hub_connectivity_rg = var.hub_connectivity_rg
  hub_vnet            = var.hub_vnet
  subnet_range        = var.subnet_range
  pesubnet_range      = var.pesubnet_range
  next_hop_ip         = var.next_hop_ip

  hub_subscription_id = var.hub_subscription_id

  avdshared_subscription_id  = var.avdshared_subscription_id
  management_subscription_id = var.management_subscription_id

  depends_on = []

}


# Creates the Azure Virtual Desktop Spoke Network resources
module "storage" {

  source = "./modules/storage"

  providers = {
    azurerm            = azurerm
    azurerm.hub        = azurerm.hub
    azurerm.management = azurerm.management
    azurerm.identity   = azurerm.identity
    azurerm.spoke      = azurerm.spoke
    azurerm.avdshared  = azurerm.avdshared
  }

  Location          = var.location
  location_short    = var.location_short
  prefix            = var.prefix
  quota_fs          = var.quota_fs
  quota_fs_partners = var.quota_fs_partners
  share_permissions = var.share_permissions
  rg_stor           = var.rg_stor

  virtual_network_id = module.network.vnet_id
  subnet_id          = module.network.subnet_subnet_id
  pesubnet_id        = module.network.pesubnet_id
  hub_dns_zone_rg    = var.hub_dns_zone_rg
  dns_servers        = var.dns_servers


  allow_list_ip = var.allow_list_ip
  white_list_ip = var.white_list_ip

  hub_subscription_id = var.hub_subscription_id

  avdshared_subscription_id  = var.avdshared_subscription_id
  management_subscription_id = var.management_subscription_id

  depends_on = []

}
