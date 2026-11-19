#-------------------------------------------------------------------------------------------------------------------------------------
# This section contains all RBAC roles for Azure Virtual Desktop deployment
#-------------------------------------------------------------------------------------------------------------------------------------

resource "time_sleep" "wait" {
  create_duration = "300s"
}

# Assign Storage File RBAC role to AD group
/*
resource "azurerm_role_assignment" "fs_share_rbac" {
  for_each = {
    for share, config in var.share_permissions :
    share => config
  }

  scope                = "${azurerm_storage_account.storage.id}/fileServices/default/shares/${each.key}"
  role_definition_name = each.value.role
  principal_id         = element(each.value.principal_ids, 0)

  depends_on = [azurerm_storage_share.FSShare]
}
*/
