
location       = "westeurope" # change to your Azure region
location_short = "euw"        # azure location short
prefix         = "str"        # change to your prefix 4 characters (letters and numbers only)

vnet_range     = ["100.64.68.0/25"]  # change to your cidr for the shs spoke vnet to be created
subnet_range   = ["100.64.68.0/26"]  # change to your cidr for the shs spoke subnet to be created
pesubnet_range = ["100.64.68.64/26"] # change to your cider for shs spoke private endpoint subnet to be created

dns_servers = ["100.64.72.4", "100.64.72.5"] # optional if you want to use your own DNS servers
next_hop_ip = "100.64.69.132"                # next hop ip address for route table


allow_list_ip = ["62.163.191.72", "62.140.135.24"] # optional for access to browswer resources with private endpoint you can add your IP address to allowlist
white_list_ip = ["0.0.0.0"]                        # optional for access to browswer resources with private endpoint you can add your IP address to allowlist

hub_vnet            = "mg-vz-hub-westeurope" # hub connectivity vnet name 
hub_connectivity_rg = "mg-vz-connectivity"   # hub connectivity subscription network resource group
hub_dns_zone_rg     = "rg-private-dns-prd-euw-001"       # private DNS zones resource group name

#fw_policy = "mg-vz-pp-fw-hub-westeurope-policy" # firewall policy for shs assumes that firewall is already deployed in hub subscription

spoke_subscription_id      = "9a752b70-372f-468b-8c6e-0d4599bcc9b1" # subscription where AVD resources will be deployed
hub_subscription_id        = "c4ceb13d-843b-4a4c-a015-69b789742523" # subscription where hub resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)
identity_subscription_id   = "cf03bc5b-ab22-4a69-aa91-220b6ce705b3" # subscription where identity resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)
avdshared_subscription_id  = "9a752b70-372f-468b-8c6e-0d4599bcc9b1" # optional subscription where shared resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)
management_subscription_id = "13bd8eac-faa7-466e-b883-df2ad832b0e1" # subscription where management resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)

quota_fs     = "5000" # qouta for the file share
quota_fs_partners = "4000" # qouta for the file share
principal_id = "b4848961-ab8d-42fb-a263-8df428f7fbc4"
tenant_id    = "eaad54da-6687-41bb-9c13-71419686deaa"

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

