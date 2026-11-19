
variable "subnet_range" {
  type        = list(string)
  description = "Address range for session host subnet"
}

variable "prefix" {
  type        = string
  description = "Prefix of the name under 5 characters"
  validation {
    condition     = length(var.prefix) < 5 && lower(var.prefix) == var.prefix
    error_message = "The prefix value must be lowercase and < 4 chars."
  }
}

variable "fw_policy" {
  type        = string
  description = "Name of the firewall policy"
}

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

variable "priority" {
  type        = number
  description = "Priority voor deze Rule Collection Group"
}

variable "fw_resource_group" {
  type        = string
  description = "the firewall resource group"
}
