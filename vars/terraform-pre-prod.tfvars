# Enterprise Landingzone subscriptions details
# subscription_id_management   = "1a6f7fd7-dffd-4a8d-880f-d9e02b41944f"
# subscription_id_connectivity = "367051a0-6b53-4078-b10b-ea2ff4ffb3b4"
# subscription_id_identity     = "ea8d3037-7c00-4e57-829a-083560edc5ba"

location       = "westeurope" # change to your Azure region
location_short = "euw"        # azure location short
prefix         = "str"        # change to your prefix 4 characters (letters and numbers only)

vnet_range     = ["100.64.65.0/25"]  # change to your cidr for the shs spoke vnet to be created
subnet_range   = ["100.64.65.0/26"]  # change to your cidr for the shs spoke subnet to be created
pesubnet_range = ["100.64.65.64/26"] # change to your cider for shs spoke private endpoint subnet to be created

dns_servers = ["100.64.72.4", "100.64.72.5"] # optional if you want to use your own DNS servers
next_hop_ip = "100.64.69.132"                # next hop ip address for route table


allow_list_ip = []          #["62.163.191.72", "62.140.135.24"] # optional for access to browswer resources with private endpoint you can add your IP address to allowlist
white_list_ip = ["0.0.0.0"] # optional for access to browswer resources with private endpoint you can add your IP address to allowlist

hub_vnet            = "mg-vz-pp-hub-westeurope" # hub connectivity vnet name 
hub_connectivity_rg = "mg-vz-pp-connectivity"   # hub connectivity subscription network resource group
hub_dns_zone_rg     = "rg-dns-pp-euw-001"       # private DNS zones resource group name

#fw_policy = "mg-vz-pp-fw-hub-westeurope-policy" # firewall policy for shs assumes that firewall is already deployed in hub subscription

spoke_subscription_id      = "e7282bb5-6e6d-4fc3-b618-d4070a7610ed" # subscription where shs resources will be deployed
hub_subscription_id        = "367051a0-6b53-4078-b10b-ea2ff4ffb3b4" # subscription where hub resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)
identity_subscription_id   = "ea8d3037-7c00-4e57-829a-083560edc5ba" # subscription where identity resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)
avdshared_subscription_id  = "e7282bb5-6e6d-4fc3-b618-d4070a7610ed" # optional subscription where shared resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)
management_subscription_id = "1a6f7fd7-dffd-4a8d-880f-d9e02b41944f" # subscription where management resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)

quota_fs          = "1000" # qouta for the file share
quota_fs_partners = "1000" # qouta for the file share
principal_id      = "b4848961-ab8d-42fb-a263-8df428f7fbc4"
tenant_id         = "1ca6144a-2bee-43e3-98a5-2a1e5791818e"

# Network Objects
rt     = "route-shs"  #route-shs-<azure region>-<prefix>-<nnn> Route Table
nsg    = "nsg-shs"    #nsg-shs-<azure region>-<prefix>-<nnn> Network Security Group
vnet   = "vnet-shs"   #vnet-shs-<azure region>-<prefix>-<nnn> Virtual Network
snet   = "snet-shs"   #snet-shs-<azure region>-<prefix>-<nnn> Subnet
pesnet = "pesnet-shs" #snet-shs-<azure region>-<prefix>-<nnn> Private Endpoint Subnet

# Resource Groups
rg_shared_name = "shared-resources" #rg-avd-<azure Region>-<prefix>-shared-resources
rg_network     = "network"          #rg-avd-<azure Region>-<prefix>-network
rg_stor        = "storage"          #rg-avd-<azure Region>-<prefix>-storage

#needed 
virtual_network_id = ""
subnet_id          = ""
pesubnet_id        = ""

share_permissions = {
  "COPS-Billing" = {
    principal_ids = ["cc3124a6-22f5-462d-8a61-94c7e717bd28"] #["APP-VZ-AVD-SHARE-W-COPS-Billing"]
    role          = "Storage File Data SMB Share Contributor"
  }
  "COPS-CIM" = {
    principal_ids = ["5025e75f-ffdb-4826-9c1c-aae9dcacb704"] #["APP-VZ-AVD-SHARE-W-COPS-CIM"]
    role          = "Storage File Data SMB Share Reader"
  }
  "COPS-CMO-B2B" = {
    principal_ids = ["811b65b4-1a8d-448b-80fe-e00673df8e66"] #["APP-VZ-AVD-SHARE-W-COPS-CMO-B2B"]
    role          = "Storage File Data SMB Share Contributor"
  }
  "COPS-CMO-B2C" = {
    principal_ids = ["cc502c7a-2cee-455a-9060-b612db31d79b"] #["APP-VZ-AVD-SHARE-W-COPS-CMO-B2C"]
    role          = "Storage File Data SMB Share Contributor"
  }
  "COPS-CS-B2B" = {
    principal_ids = ["5a3eb183-a017-4e0c-9faf-bc9fbe5a3d37"] #["APP-VZ-AVD-SHARE-W-COPS-CS-B2B"]
    role          = "Storage File Data SMB Share Contributor"
  }
  "COPS-CS-B2B-SOHO" = {
    principal_ids = ["cd78c59d-94ad-43ee-b8d3-820f1e4004d8"] #["APP-VZ-AVD-SHARE-W-COPS-CS-B2B-SOHO"]
    role          = "Storage File Data SMB Share Contributor"
  }
  "COPS-I&M-OF" = {
    principal_ids = ["de0552a2-ebac-4edb-8a5a-594aafe7c840"] #["APP-VZ-AVD-SHARE-W-COPS-I&M-OF"]
    role          = "Storage File Data SMB Share Contributor"
  }
  "COPS-Q&P" = {
    principal_ids = ["94239e8c-1926-4564-a3db-020204a959d8"] #["APP-VZ-AVD-SHARE-W-COPS-Q&P"]
    role          = "Storage File Data SMB Share Contributor"
  }
}

