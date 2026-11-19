resource "azurerm_user_assigned_identity" "mi" {
  name                = "id-shs-mi-${var.prefix}"
  resource_group_name = azurerm_resource_group.rg_storage.name
  location            = azurerm_resource_group.rg_storage.location
}

## Azure Storage Accounts requires a globally unique names
## https://docs.microsoft.com/azure/storage/common/storage-account-overview
## Create a File Storage Account 
resource "azurerm_storage_account" "storage" {
  provider                   = azurerm
  name                       = local.storage_name
  resource_group_name        = azurerm_resource_group.rg_storage.name
  location                   = azurerm_resource_group.rg_storage.location
  min_tls_version            = "TLS1_2"
  account_tier               = "Premium"
  account_replication_type   = "LRS"
  account_kind               = "FileStorage"
  https_traffic_only_enabled = true
  tags                       = local.lower_case_tags

  #azure_files_authentication {
  #  directory_type = "AD"
  #}

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = all
  }
}

## Create 5 Storage Account File Shares
resource "azurerm_storage_share" "FSShare" {
  for_each = toset(local.storage_shares)

  name               = each.value
  quota              = var.quota_fs
  enabled_protocol   = "SMB"
  storage_account_id = azurerm_storage_account.storage.id

  depends_on = [azurerm_storage_account.storage]
}

#create private endpoint for storage account
resource "azurerm_private_endpoint" "afpe" {
  name                = "pe-${local.storage_name}-${var.prefix}-file"
  location            = azurerm_resource_group.rg_storage.location
  resource_group_name = azurerm_resource_group.rg_storage.name
  subnet_id           = var.pesubnet_id #data.azurerm_subnet.pesubnet.id
  tags                = local.lower_case_tags

  private_service_connection {
    name                           = "psc-file-${var.prefix}"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }
  private_dns_zone_group {
    name                 = "dns-file-${var.prefix}"
    private_dns_zone_ids = data.azurerm_private_dns_zone.pe-filedns-zone.*.id
  }

  lifecycle {
    ignore_changes = all
  }
}

# Deny Traffic from Public Networks with white list exceptions
resource "azurerm_storage_account_network_rules" "stfw" {
  storage_account_id = azurerm_storage_account.storage.id
  default_action     = "Deny"
  bypass             = ["AzureServices", "Metrics", "Logging"]
  ip_rules           = local.allow_list_ip
  depends_on         = [azurerm_private_endpoint.afpe] #azurerm_role_assignment.af_role
}

resource "azurerm_private_dns_zone_virtual_network_link" "filelink" {
  name                  = "azfilelink-${var.prefix}"
  resource_group_name   = var.hub_dns_zone_rg
  private_dns_zone_name = data.azurerm_private_dns_zone.pe-filedns-zone.name
  virtual_network_id    = var.virtual_network_id #data.azurerm_virtual_network.vnet.id
  provider              = azurerm.hub

  lifecycle { ignore_changes = all }
}

#--------------------------------------------------------------------------------------------------------
# Second storage accoutn for partner use
#--------------------------------------------------------------------------------------------------------
resource "azurerm_storage_account" "storage_partners" {
  provider                      = azurerm
  name                          = local.storage_name_partners
  resource_group_name           = azurerm_resource_group.rg_storage.name
  location                      = azurerm_resource_group.rg_storage.location
  min_tls_version               = "TLS1_2"
  account_tier                  = "Premium"
  account_replication_type      = "LRS"
  account_kind                  = "FileStorage"
  https_traffic_only_enabled    = true
  public_network_access_enabled = false
  shared_access_key_enabled     = false
  tags                          = local.lower_case_tags

  #azure_files_authentication {
  #  directory_type = "AD"
  #}

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = all
  }
}

## Create Storage Account File Shares
resource "azurerm_storage_share" "FSShare_partners" {
  for_each = toset(local.storage_shares_partners)

  name               = each.value
  quota              = var.quota_fs_partners
  enabled_protocol   = "SMB"
  storage_account_id = azurerm_storage_account.storage_partners.id

  depends_on = [azurerm_storage_account.storage_partners]
}

#create private endpoint for storage account
resource "azurerm_private_endpoint" "afpe_partners" {
  name                = "pe-${local.storage_name_partners}-${var.prefix}-file"
  location            = azurerm_resource_group.rg_storage.location
  resource_group_name = azurerm_resource_group.rg_storage.name
  subnet_id           = var.pesubnet_id #data.azurerm_subnet.pesubnet.id
  tags                = local.lower_case_tags

  private_service_connection {
    name                           = "psc-file-${var.prefix}-partners"
    private_connection_resource_id = azurerm_storage_account.storage_partners.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }
  private_dns_zone_group {
    name                 = "dns-file-${var.prefix}-partners"
    private_dns_zone_ids = data.azurerm_private_dns_zone.pe-filedns-zone.*.id
  }

  lifecycle {
    ignore_changes = all
  }
}

# Deny Traffic from Public Networks with white list exceptions
resource "azurerm_storage_account_network_rules" "stfw_partners" {
  storage_account_id = azurerm_storage_account.storage_partners.id
  default_action     = "Deny"
  bypass             = ["AzureServices", "Metrics", "Logging"]
  ip_rules           = local.allow_list_ip

  #virtual_network_subnet_ids = [data.azurerm_subnets.all_subnets.ids]

  depends_on = [azurerm_private_endpoint.afpe_partners]
}


# resource "azurerm_role_assignment" "share_rbac_partners" {
#   for_each = azurerm_storage_share.FSShare_partners

#   scope                = each.value.resource_manager_id
#   role_definition_name = "Storage File Data SMB Share Contributor"
#   principal_id         = local.storage_share_groups_partners[each.key]

#   depends_on = [azurerm_storage_share.FSShare_partners]
# }



#--------------------------------------------------------------------------------------------------------
# Enable defender for storage
#--------------------------------------------------------------------------------------------------------

resource "azurerm_security_center_storage_defender" "sec_storage_partners" {
  storage_account_id = azurerm_storage_account.storage_partners.id

  override_subscription_settings_enabled      = true # Optional
  sensitive_data_discovery_enabled            = true # Optional
  malware_scanning_on_upload_enabled          = true
  malware_scanning_on_upload_cap_gb_per_month = -1
}
