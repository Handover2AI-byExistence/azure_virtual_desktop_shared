locals {
  base_priority = var.priority
  rule_priorities = {
    avd_generic  = local.base_priority + 1
    avd_vz_url   = local.base_priority + 4
    avd_aws_url  = local.base_priority + 5
    avd_intune   = local.base_priority + 3
    azure_portal = local.base_priority + 2
  }
}