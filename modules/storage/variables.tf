#-------------------------------------------------------------------------------------------------------------------------------------
# This section contains all variables for Azure Virtual Desktop deployment
#-------------------------------------------------------------------------------------------------------------------------------------

variable "Location" {
  description = "Location of the resource group."
}

variable "location_short" {
  description = "Location of the resource group."
}

variable "hub_dns_zone_rg" {
  description = "The resource group for the hub DNS zone"
}

variable "virtual_network_id" {
  type        = string
  description = "Name of avd vnet"
}

variable "rg_stor" {
  type        = string
  description = "Name of the Resource group in which to deploy storage"
}

variable "subnet_id" {
  type        = string
  description = "Name of subnet"
}

variable "pesubnet_id" {
  type        = string
  description = "Name of subnet"
}

variable "dns_servers" {
  type        = list(string)
  description = "Custom DNS configuration"
}

variable "prefix" {
  type        = string
  description = "Prefix of the name under 5 characters"
  validation {
    condition     = length(var.prefix) < 5 && lower(var.prefix) == var.prefix
    error_message = "The prefix value must be lowercase and < 4 chars."
  }
}

# Create a storage allow list of IP Addresses
variable "allow_list_ip" {
  type        = list(string)
  description = "List of allowed IP Addresses"
}

variable "hub_subscription_id" {
  type        = string
  description = "Hub Subscription id"
}

variable "avdshared_subscription_id" {
  type        = string
  description = "Spoke Subscription id"
}

variable "management_subscription_id" {
  type        = string
  description = "Management Subscription id"
}

variable "quota_fs" {
  description = "Quota for FSlogix pool"
  type        = string
}

variable "quota_fs_partners" {
  description = "Quota for FSlogix pool"
  type        = string
}

/*
variable "log_analytics_name" {
  type        = string
  description = "the log analytics name"
}

variable "log_analytics_resource_group" {
  type        = string
  description = "the log analytics resource group"
}
*/

variable "white_list_ip" {
  type        = list(string)
  description = "List of whitelisted IP Addresses"
}
/*
variable "principal_id" {
  type        = string
  description = "the id off the avd group for smb access"
}
*/
variable "tags" {
  type        = map(string)
  description = "Specify tags to add to \"core\" resources."
  default = {
    #Application     = "Bastion"
    Confidentiality = "C3"
    CreatedBy       = "william.kox@vodafoneziggo.com"
    CreatedWith     = "Terraform"
    #Environment     = "DEV"
    ManagedBy = "oit-oase@vodafoneziggo.com"
    #Project         = "Privileged Access Management (PAM)"
    TaggingVersion = "V2.4"
  }
}

variable "share_permissions" {
  type = map(object({
    principal_ids = list(string)
    role          = string
  }))
}
