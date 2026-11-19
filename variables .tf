variable "location" {
  description = "Location of the resource group."
}

variable "location_short" {
  description = "Location of the resource group."
}

variable "rg_stor" {
  type        = string
  description = "Name of the Resource group in which to deploy storage"
}

variable "rg_network" {
  type        = string
  description = "Name of the Resource group in which to deploy network resources"
}

variable "vnet" {
  type        = string
  description = "Name of avd vnet"
}

variable "snet" {
  type        = string
  description = "Name of subnet"
}

variable "pesnet" {
  type        = string
  description = "Name of subnet"
}

variable "virtual_network_id" {
  type        = string
  description = "Name of avd vnet"
}

variable "subnet_id" {
  type        = string
  description = "Name of subnet"
}

variable "pesubnet_id" {
  type        = string
  description = "Name of subnet"
}

variable "nsg" {
  type        = string
  description = "Name of the nsg"
}

variable "rt" {
  type        = string
  description = "Name of the route table"
}

variable "rg_shared_name" {
  type        = string
  description = "Name of the Resource group in which to deploy shared resources"
}

variable "hub_vnet" {
  type        = string
  description = "Name of domain controller vnet"
}

variable "dns_servers" {
  type        = list(string)
  description = "Custom DNS configuration"
}

variable "vnet_range" {
  type        = list(string)
  description = "Address range for deployment VNet"
}
variable "subnet_range" {
  type        = list(string)
  description = "Address range for session host subnet"
}

variable "pesubnet_range" {
  type        = list(string)
  description = "Address range for private endpoints subnet"
}

variable "hub_connectivity_rg" {
  type        = string
  description = "The resource group for hub connectivity resources"
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

variable "spoke_subscription_id" {
  type        = string
  description = "Spoke Subscription id"
}

variable "identity_subscription_id" {
  type        = string
  description = "identity Subscription id"
}

variable "avdshared_subscription_id" {
  type        = string
  description = "Spoke Subscription id"
}

variable "management_subscription_id" {
  type        = string
  description = "Management Subscription id"
}

variable "hub_dns_zone_rg" {
  description = "The resource group for the hub DNS zone"
}

# variables for firewall policy 
variable "next_hop_ip" {
  type        = string
  description = "Next hop IP address"
}

## New
variable "quota_fs" {
  description = "Quota for FSlogix pool"
  type        = string
}

variable "quota_fs_partners" {
  description = "Quota for FSlogix pool"
  type        = string
}

variable "principal_id" {
  type        = string
  description = "the id off the avd group for smb access"
}

variable "white_list_ip" {
  type        = list(string)
  description = "List of whitelisted IP Addresses"
}
variable "tags" {
  type        = map(string)
  description = "Specify tags to add to \"core\" resources."
  default = {
    Application     = "AVD"
    Confidentiality = "C2"
    CreatedBy       = "william.kox@vodafoneziggo.com"
    CreatedWith     = "Terraform"
    #Environment     = "DEV"
    ManagedBy      = "oit-oase@vodafoneziggo.com"
    Project        = "OneCitrix/AVD"
    TaggingVersion = "V2.4"
  }
}

variable "share_permissions" {
  type = map(object({
    principal_ids = list(string)
    role          = string
  }))
}

variable "tenant_id" {
  type        = string
  description = "Tenant id"
}
