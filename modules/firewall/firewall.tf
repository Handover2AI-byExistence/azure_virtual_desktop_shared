#-------------------------------------------------------------------------------------------------------------------------------------
# The following section Create Network rule collection
#-------------------------------------------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------------------------------
# The following section Create Application rule collection
#-------------------------------------------------------------------------------------------------------------------------------------

resource "azurerm_firewall_policy_rule_collection_group" "avd-general-app-rules" {
  provider           = azurerm.hub
  name               = "AVD-Rule-Group-${upper(var.prefix)}"
  firewall_policy_id = data.azurerm_firewall_policy.existing_policy.id
  priority           = var.priority #1150 # Must be unique within the policy

  application_rule_collection {
    name     = "Allow-AVD-Generic-Traffic"
    priority = var.priority + 1 #1151
    action   = "Allow"

    # Rule 1: Allow access to Microsoft services
    rule {
      name             = "allow-wvd-microsoft-port-443"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "login.microsoftonline.com",
        "*.wvd.microsoft.com",
        "catalogartifact.azureedge.net",
        "*.prod.warm.ingest.monitor.core.windows.net",
        "gcs.prod.monitoring.core.windows.net",
        "mrsglobalsteus2prod.blob.core.windows.net",
        "wvdportalstorageblob.blob.core.windows.net",
        "aka.ms",
        "portal.azure.com",
        "*.portal.azure.com",
        "portal.azure.net",
        "*.portal.azure.net",
        "*.data.microsoft.com",
        "management.azure.com",
        "*.mspim.azure.com",
        "*.file.core.windows.net",
        "account.activedirectory.windowsazure.com",
        "mysignins.microsoft.com",
        "myaccess.microsoft.com",
        "myapplications.microsoft.com",
        "*.servicebus.windows.net",
        "go.microsoft.com",
        "learn.microsoft.com",
        "privacy.microsoft.com",
        "*.cdn.office.net",
        "graph.microsoft.com",
        "windows.cloud.microsoft",
        "windows365.microsoft.com",
        "ecs.office.com",
        "*.events.data.microsoft.com",
        "*.blob.core.windows.net",
        "myaccount.microsoft.com"
      ]

      protocols {
        port = "443"
        type = "Https"
      }
    }

    # Rule 2: Allow access to Microsoft services
    rule {
      name             = "allow-wvd-microsoft-port-80"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "169.254.169.254",
        "168.63.129.16",
        "oneocsp.microsoft.com",
        "www.microsoft.com"
      ]

      protocols {
        port = "80"
        type = "Http"
      }
    }

    # Rule 3: Allow access to Windows core
    rule {
      name             = "allow-wvd-core-windows-port-1688"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "azkms.core.windows.net"
      ]

      protocols {
        port = "1688"
        type = "Http"
      }

    }

    # Rule 4: Allow access to Microsoft services
    rule {
      name             = "allow-wvd-microsoft-port-445"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "*.file.core.windows.net"
      ]

      protocols {
        port = "445"
        type = "Http"
      }
    }

    # Rule 5: Allow access to Microsoft Defender
    rule {
      name             = "allow-wvd-microsoft-defender-port-443"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "*.dm.microsoft.com",
        "*.securitycenter.windows.com",
        "*.wdatp.com"
      ]

      protocols {
        port = "443"
        type = "Https"
      }
    }

    # Rule 6: Allow access to Microsoft Update for business
    rule {
      name             = "allow-wvd-microsoft-update-port-443"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "*.windowsupdate.com",
        "*.dl.delivery.mp.microsoft.com",
        "*.prod.do.dsp.mp.microsoft.com",
        "*.delivery.mp.microsoft.com",
        "*.update.microsoft.com",
        "tsfe.trafficshaping.dsp.mp.microsoft.com",
        "adl.windows.com"
      ]

      protocols {
        port = "443"
        type = "Https"
      }
    }
  }


  # Rule 2: Allow access to VodafoneZiggo services
  application_rule_collection {
    name     = "Allow-AVD-VZ-URL"
    priority = var.priority + 5 #1153
    action   = "Allow"

    rule {
      name             = "allow-vz-app-url"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "corp-sts.vodafoneziggo.com",
        "coco.vodafoneziggo.com"
      ]

      protocols {
        port = "443"
        type = "Https"
      }
    }
  }


  # Rule 3: Allow access to AWS services
  application_rule_collection {
    name     = "Allow-AVD-AWS-URL"
    priority = var.priority + 4 #1155
    action   = "Allow"

    rule {
      name             = "allow-aws-app-url"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "ec2messages.eu-central-1.amazonaws.com",
        "ssm.eu-central-1.amazonaws.com",
        "ssmmessages.eu-central-1.amazonaws.com",
        "vzlz.awsapps.com",
        "identitycenter.amazonaws.com",
        "*.eu-central-1.amazonaws.com",
        "*.signin.aws.amazon.com"
      ]

      protocols {
        port = "443"
        type = "Https"
      }
    }
  }


  # Rule 3: Allow access to Microsoft Intune services 
  application_rule_collection {
    name     = "Allow-Microsoft-Intune-URL"
    priority = var.priority + 2 #1157
    action   = "Allow"


    rule {
      name             = "allow-microsoft-intune-url"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "*.manage.microsoft.com",
        "manage.microsoft.com",
        "EnterpriseEnrollment.manage.microsoft.com",
        "*.do.dsp.mp.microsoft.com",
        "*.dl.delivery.mp.microsoft.com",
        "swda01-mscdn.manage.microsoft.com",
        "swda02-mscdn.manage.microsoft.com",
        "swdb01-mscdn.manage.microsoft.com",
        "swdb02-mscdn.manage.microsoft.com",
        "swdc01-mscdn.manage.microsoft.com",
        "swdc02-mscdn.manage.microsoft.com",
        "swdd01-mscdn.manage.microsoft.com",
        "swdd02-mscdn.manage.microsoft.com",
        "swdin01-mscdn.manage.microsoft.com",
        "swdin02-mscdn.manage.microsoft.com",
        "account.live.com",
        "login.live.com",
        "config.edge.skype.com",
        "ecs.office.com",
        "fd.api.orgmsg.microsoft.com",
        "ris.prod.api.personalization.ideas.microsoft.com",
        "login.microsoftonline.com",
        "graph.windows.net",
        "enterpriseregistration.windows.net",
        "certauth.enterpriseregistration.windows.net",
        "*.officeconfig.msocdn.com",
        "config.office.com",
        "go.microsoft.com"
      ]

      protocols {
        port = "443"
        type = "Https"
      }
    }

    # Rule 3: Allow access to Microsoft Intune services port 80
    rule {
      name             = "allow-microsoft-intune-url-port-80"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "*.manage.microsoft.com",
        "manage.microsoft.com",
        "EnterpriseEnrollment.manage.microsoft.com",
        "*.do.dsp.mp.microsoft.com",
        "*.dl.delivery.mp.microsoft.com",
        "swda01-mscdn.manage.microsoft.com",
        "swda02-mscdn.manage.microsoft.com",
        "swdb01-mscdn.manage.microsoft.com",
        "swdb02-mscdn.manage.microsoft.com",
        "swdc01-mscdn.manage.microsoft.com",
        "swdc02-mscdn.manage.microsoft.com",
        "swdd01-mscdn.manage.microsoft.com",
        "swdd02-mscdn.manage.microsoft.com",
        "swdin01-mscdn.manage.microsoft.com",
        "swdin02-mscdn.manage.microsoft.com",
        "account.live.com",
        "login.live.com",
        "config.edge.skype.com",
        "ecs.office.com",
        "fd.api.orgmsg.microsoft.com",
        "ris.prod.api.personalization.ideas.microsoft.com",
        "login.microsoftonline.com",
        "graph.windows.net",
        "enterpriseregistration.windows.net",
        "certauth.enterpriseregistration.windows.net",
        "ctldl.windowsupdate.com",
        "crl.microsoft.com",
        "www.microsoft.com",
        "support.microsoft.com"
      ]

      protocols {
        port = "80"
        type = "Http"
      }
    }
  }

  # Rule 4: Allow access to Azure portal URLs 
  application_rule_collection {
    name     = "Allow-Microsoft-AzurePortal-URL"
    priority = var.priority + 3 #1158
    action   = "Allow"

    # Azure portal authentication
    rule {
      name             = "allow-microsoft-Portal-url"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "login.microsoft.com",
        "*.aadcdn.msftauth.net",
        "*.aadcdn.msftauthimages.net",
        "*.aadcdn.msauthimages.net",
        "*.logincdn.msftauth.net",
        "login.live.com",
        "*.msauth.net",
        "*.aadcdn.microsoftonline-p.com",
        "*.microsoftonline-p.com",
        "login.windows.net",
        "*.security.microsoft.com"
      ]

      protocols {
        port = "443"
        type = "Https"
      }
    }

    # Azure portal framework
    rule {
      name             = "allow-microsoft-Portal-Framework"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "*.portal.azure.com",
        "*.hosting.portal.azure.net",
        "*.reactblade.portal.azure.net",
        "management.azure.com",
        "*.ext.azure.com",
        "*.graph.windows.net",
        "*.graph.microsoft.com",
        "hosting.partners.azure.net"
      ]

      protocols {
        port = "443"
        type = "Https"
      }
    }

    # Account data
    rule {
      name             = "allow-microsoft-Account-Data"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "*.account.microsoft.com",
        "*.bmx.azure.com",
        "*.subscriptionrp.trafficmanager.net",
        "*.signup.azure.com"
      ]

      protocols {
        port = "443"
        type = "Https"
      }
    }

    # General Azure services and documentation
    rule {
      name             = "allow-microsoft-Gen-Services"
      source_addresses = var.subnet_range #["100.65.12.0/24", "100.65.14.0/24"]

      destination_fqdns = [
        "aka.ms",
        "*.asazure.windows.net",
        "*.azconfig.io",
        "*.aad.azure.com",
        "*.aadconnecthealth.azure.com",
        "ad.azure.com",
        "adf.azure.com",
        "api.aadrm.com",
        "api.loganalytics.io",
        "api.azrbac.mspim.azure.com",
        "*.applicationinsights.azure.com",
        "appmanagement.activedirectory.microsoft.com",
        "appservice.azure.com",
        "*.arc.azure.net",
        "asazure.windows.net",
        "bastion.azure.com",
        "batch.azure.com",
        "elm.iga.azure.com",
        "eventhubs.azure.net",
        "functions.azure.com",
        "identitygovernance.azure.com",
        "iga.azure.com",
        "informationprotection.azure.com",
        "logic.azure.com",
        "*.monitor.azure.com",
        "*.msidentity.com",
        "mspim.azure.com",
        "network.azure.com",
        "purview.azure.com",
        "search.azure.com",
        "servicebus.azure.net",
        "servicebus.windows.net",
        "shell.azure.com",
        "azure.status.microsoft",
        "storage.azure.com",
        "storage.azure.net",
        "vault.azure.net",
        "ux.console.azure.com",
        "*.smartscreen-prod.microsoft.com",
        "*.smartscreen.microsoft.com",
        "*.checkappexec.microsoft.com",
        "*.urs.microsoft.com",
        "definitionupdates.microsoft.com",
        "*.download.windowsupdate.com",
        "*.download.microsoft.com",
        "go.microsoft.com",
        "*.wns.windows.com",
        "*.azureedge.net",
        "*.wd.microsoft.com",

      ]

      protocols {
        port = "443"
        type = "Https"
      }
    }

  }
  lifecycle {
    ignore_changes = [
      priority,
      application_rule_collection #application_rule_collection[0].priority # nested rule collection priority
    ]
  }
}


#-------------------------------------------------------------------------------------------------------------------------------------
# The following section Create NAT rule collection
#-------------------------------------------------------------------------------------------------------------------------------------

