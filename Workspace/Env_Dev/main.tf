# module "RG" {

#   source = "../../Generic_Infra_Modules/Resource_Group"
#   RGs = var.RGs

# }


module "RG" {

  source   = "../../Generic_Infra_Modules/Resource_Group"
  for_each = var.RGs

  rg_name  = each.value.rg_name
  location = each.value.location
  tags     = each.value.tags

}

module "stg" {

  depends_on = [module.RG]
  source     = "../../Generic_Infra_Modules/Storage_Account"
  stgs       = var.stgs
}

module "vnets" {

  depends_on = [module.RG]
  source     = "../../Generic_Infra_Modules/Virtual_Network"
  vnets      = var.vnets

}

module "subnets" {

  depends_on = [module.RG, module.vnets]
  source     = "../../Generic_Infra_Modules/Subnet"
  subnets    = var.subnets
}

module "public_ip" {

  depends_on = [module.RG]
  source     = "../../Generic_Infra_Modules/Public_IP"
  pips       = var.pips

}

locals {
  bastions = {
    for key, value in var.bastions : key => merge(value, {

      ip_configuration = {

        name                 = value.ip_configuration.name
        subnet_id            = data.azurerm_subnet.subnet_id[value.ip_configuration.subnet_key].id
        public_ip_address_id = data.azurerm_public_ip.public_ip_id[value.ip_configuration.public_key].id
      }
    })
  }
}

module "bastion" {

  depends_on = [module.RG, module.public_ip]
  source     = "../../Generic_Infra_Modules/Azure_Bastion"

  for_each = local.bastions
  bastions = {
    (each.key) = each.value
  }
}

/*
locals {
  nics = {
    for key, value in var.nics : key => merge(value, {
      ip_configuration = {
        for config_key, config_value in value.ip_configuration : config_key => merge(config_value, {
          subnet_id                     = data.azurerm_subnet.subnet1.id
          public_ip_address_id          = data.azurerm_public_ip.public_ip1.id
        })
      }
    })
  }
}

 This local block will be used when dynamic block will be used in place of current logic in nic's main.tf
*/

locals {

  nics = {
    for key, value in var.nics : key => merge(value, {

      ip_configuration = {

        name                 = value.ip_configuration.name
        subnet_id            = data.azurerm_subnet.subnet_id[value.ip_configuration.subnet_key].id
        public_ip_address_id = data.azurerm_public_ip.public_ip_id[value.ip_configuration.public_key].id

      }
    })
  }
}


module "network_interface_card" {

  depends_on = [module.subnets, module.public_ip]

  source   = "../../Generic_Infra_Modules/Network_Interface_Card"
  for_each = local.nics

  nics = {
    (each.key) = each.value
  }
}


module "virtual_machine" {

  depends_on = [module.network_interface_card, module.public_ip]
  source     = "../../Generic_Infra_Modules/Linux_Virtual_Machine"
  for_each   = var.vms

  vms = {
    (each.key) = merge(each.value, {
      network_interface_ids = [data.azurerm_network_interface.nic_data[each.value.nic_key].id]
    })
  }
}



/*
locals {
  vms = {
    for key, value in var.vms : key => merge(value, {
      admin_ssh_key = value.admin_ssh_key != null ? value.admin_ssh_key : {
        public_key = null
        username   = null
      }
      plan = value.plan != null ? value.plan : {
        name      = null
        product   = null
        publisher = null
      }
    })
  }
}

module "virtual_machine" {
  source   = "../../Generic_Infra_Modules/Linux_Virtual_Machine"  # Adjust path as needed
  for_each = local.vms

  vms = each.value
}



#  Use this when you don't want to use dynamic block in child's main.tf of vm see there basically providing null values
#  to admin_ssh_key, plan optional blocks from here through local block instead of dynamic_block in child main.tf

*/


module "key_vault" {  

  depends_on = [module.RG, module.public_ip]
  source     = "../../Generic_Infra_Modules/Key_Vault"
  key_vault  = local.key_vault

}

locals {
  key_vault = {
    for key, value in var.key_vault : key => merge(value, {
      access_policy = value.access_policy != null ? value.access_policy : {
        tenant_id               = value.tenant_id  # Use the vault's tenant_id as fallback
        object_id               = null  # Requires a valid object ID, set via tfvars or data
        application_id          = null
        certificate_permissions = []
        key_permissions         = []
        secret_permissions      = []
        storage_permissions     = []
      }
      network_acls = value.network_acls != null ? value.network_acls : {
        bypass         = "AzureServices"
        default_action = "Deny"
        ip_rules       = []
        virtual_network_subnet_ids = null  # Set to null or provide subnet IDs if needed
      }
    })
  }
}



