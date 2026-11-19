
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
# The following locals choice csv file based on Tag
#---------------------------------------------------------------------------
locals {
  csv_files = {
    "validate" = "./vars/avd_vars.csv" #"${path.module}/vars/avd_vars.csv"
    "staging"  = "./vars/avd_vars.csv"
    "main"     = "./vars/avd_vars_prd.csv"
  }
}
