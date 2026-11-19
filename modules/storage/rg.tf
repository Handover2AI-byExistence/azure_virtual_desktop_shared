#-------------------------------------------------------------------------------------------------------------------------------------
# This section contains all resource groups for Azure Virtual Desktop deployment
#-------------------------------------------------------------------------------------------------------------------------------------

# Create a Resource Group for Storage 
resource "azurerm_resource_group" "rg_storage" {
  location = var.Location
  name     = "rg-shs-${var.prefix}-${var.location_short}-${var.rg_stor}"
  tags     = local.lower_case_tags
}

