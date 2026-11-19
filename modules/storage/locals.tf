#-------------------------------------------------------------------------------------------------------------------------------------
# This section contains all locals for Azure Virtual Desktop deployment
#-------------------------------------------------------------------------------------------------------------------------------------

locals {

  storage_name          = lower(replace("stshs${var.prefix}${random_string.random.id}", "-", ""))
  storage_name_partners = lower(replace("stshs${var.prefix}partner${random_string.random.id}", "-", ""))
  storage_name_state    = lower(replace("sastate${var.prefix}${random_string.random.id}", "-", ""))
  allow_list_ip         = var.allow_list_ip
  white_list_ip         = var.white_list_ip

  tags = {
    tags        = var.tags
    environment = var.prefix
  }
}


#---------------------------------------------------------------------------
# The following locals convert tags to UPPER or lower
#---------------------------------------------------------------------------
# Convert tags to lower case
locals {
  lower_case_tags = { for k, v in var.tags : k => lower(v) }
}

locals {
  upper_case_tags = { for k, v in var.tags : k => upper(v) }
}




#---------------------------------------------------------------------------
# The following locals are the files shares for cops and billing
#---------------------------------------------------------------------------
locals {
  storage_shares = [
    "cops-billing",
    "cops-cim",
    "cops-cmo-b2b",
    "cops-cmo-b2c",
    "cops-cs-b2b",
    "cops-cs-b2b-soho",
    "cops-im-of",
    "cops-qp"
  ]
}

locals {
  storage_shares_partners = [
    "amd-share",
    "enn-share",
    "g2k-share",
    "hpe-share",
    "ibm-share",
    "ors-share",
    "pam-share"
  ]
}

locals {
  storage_share_groups_partners = {
    amd-share = "00d919ce-43ee-4290-94e1-cc57f24fe43c"
    enn-share = "82ca7a54-2d21-4a0b-b4f9-a51e9927ab2d"
    g2k-share = "9ad9248b-3b84-4293-8f5b-2e0cb6aec675"
    hpe-share = "250dcadf-92da-48f1-9f7a-36b377fe6143"
    ibm-share = "22042920-45c6-493a-aee9-800dc183a5c5"
    ors-share = "f2a79b05-6541-4b5e-a816-9a90fd74e3db"
    pam-share = "c3a2caf3-1470-4779-a356-b42b73f5fbf9"
  }
}

# "APP-VZ-AVD-SHARE-W-AMD-SHARED",
# "APP-VZ-AVD-SHARE-W-ENN-SHARED",
# "APP-VZ-AVD-SHARE-W-G2K-SHARED",
# "APP-VZ-AVD-SHARE-W-HPE-SHARED",
# "APP-VZ-AVD-SHARE-W-IBM-SHARED",
# "APP-VZ-AVD-SHARE-W-ORS-SHARED"
