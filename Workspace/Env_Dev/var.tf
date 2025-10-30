# variable "RGs" {

#   type = map(object({
#     rg_name   = string
#     location  = string
#     owner     = optional(string, "")
#     co_owner  = optional(string, "")
#   }))
# }

variable "RGs" {

  type = map(object(
    {
      rg_name  = string
      location = string
      tags     = optional(map(string), {})

    }
  ))
}


variable "stgs" {

  type = map(object(
    {
      name                          = string
      location                      = string
      rg_name                       = string
      account_replication_type      = string
      account_tier                  = string
      access_tier                   = optional(string, "")
      edge_zone                     = optional(string, null)
      https_traffic_only_enabled    = optional(bool, true)
      min_tls_version               = optional(string, "")
      shared_access_key_enabled     = optional(bool, true)
      public_network_access_enabled = optional(bool, true)
      is_hns_enabled                = optional(bool, true)
      allowed_copy_scope            = optional(string, "AAD")
      dns_endpoint_type             = optional(string, "")

      owner         = optional(string)
      co_owner      = optional(string)
      business_unit = optional(string)

      # network_rules=string
      # last_access_time_enabled=string
    }
  ))
}


variable "vnets" {

  type = map(object(
    {
      name                           = string
      location                       = string
      rg_name                        = string
      address_space                  = optional(list(string), [])
      edge_zone                      = optional(string, null)
      flow_timeout_in_minutes        = optional(number, 5)
      private_endpoint_vnet_policies = optional(string, "Disabled")

      owner         = optional(string)
      co_owner      = optional(string)
      buisness_unit = optional(string)

    }
  ))
}

variable "subnets" {
  type = map(object(
    {
      subnet_name                                   = string
      virtual_network_name                          = string
      resource_group_name                           = string
      address_prefixes                              = optional(list(string))
      default_outbound_access_enabled               = optional(bool)
      private_endpoint_network_policies             = optional(string)
      private_link_service_network_policies_enabled = optional(bool)
      sharing_scope                                 = optional(string)
      service_endpoints                             = optional(list(string))
      service_endpoint_policy_ids                   = optional(list(string))
    }
  ))
}

variable "pips" {
  type = map(object(
    {
      name                = string
      resource_group_name = string
      location            = string
      allocation_method   = string

      zones                   = optional(list(string))
      ddos_protection_mode    = optional(string)
      domain_name_label       = optional(string)
      domain_name_label_scope = optional(string)
      edge_zone               = optional(string)
      idle_timeout_in_minutes = optional(number)
      ip_version              = optional(string)
      sku                     = optional(string)
      public_ip_prefix_id     = optional(string)
      sku_tier                = optional(string)
      ip_tags                 = optional(map(string))

      owner       = optional(string)
      co_owner    = optional(string)
      environment = optional(string)

    }
  ))
}

variable "bastions" {
  type = map(object(
    {
      name                = string
      resource_group_name = string
      location            = string
      copy_paste_enabled  = optional(bool)
      file_copy_enabled   = optional(bool)
      kerberos_enabled    = optional(bool)
      sku                 = optional(string)
      scale_units         = optional(number)
      tunneling_enabled   = optional(bool)
      virtual_network_id  = optional(string)
      zones               = optional(list(string))

      ip_configuration = optional(object(

        {
          name                 = string
          subnet_id            = string
          public_ip_address_id = string
          subnet_key           = optional(string)
          public_key           = optional(string)

        }
      ))

      owner       = optional(string)
      co_owner    = optional(string)
      environment = optional(string)
    }
  ))
}

variable "nics" {

  type = map(object(
    {
      name                = string
      location            = string
      resource_group_name = string

      ip_configuration = object(

        {
          name      = string
          subnet_id = optional(string)

          private_ip_address_allocation = optional(string)
          private_ip_address_version    = optional(string)
          public_ip_address_id          = optional(string)
          subnet_key                    = optional(string)
          public_key                    = optional(string)

          gateway_load_balancer_frontend_ip_configuration_id = optional(string)
          primary                                            = optional(bool)

          # load_balancer_backend_address_pools_ids          = optional(list(string))
          # load_balancer_inbound_nat_rules_ids              = optional(list(string))
        }
      )

      auxiliary_mode                 = optional(string)
      auxiliary_sku                  = optional(string)
      dns_servers                    = optional(list(string))
      edge_zone                      = optional(string)
      ip_forwarding_enabled          = optional(bool)
      accelerated_networking_enabled = optional(bool)

      owner       = optional(string)
      co_owner    = optional(string)
      environment = optional(string)
    }
  ))
}



variable "vms" {

  type = map(object(
    {
      name                  = string
      resource_group_name   = string
      location              = string
      size                  = string
      network_interface_ids = list(string)
      nic_key               = optional(string)

      zone                            = optional(string)
      license_type                    = optional(string)
      disable_password_authentication = optional(bool)
      admin_username                  = optional(string)
      admin_password                  = optional(string)


      os_disk = object({

        caching              = string
        storage_account_type = string

        name                   = optional(string)
        disk_encryption_set_id = optional(string)
        disk_size_gb           = optional(string)

      })

      source_image_reference = optional(object({

        publisher = string
        offer     = string
        sku       = string
        version   = string
      }))

      allow_extension_operations                             = optional(bool)
      bypass_platform_safety_checks_on_user_schedule_enabled = optional(bool)
      capacity_reservation_group_id                          = optional(string)
      dedicated_host_id                                      = optional(string)
      disk_controller_type                                   = optional(string)
      edge_zone                                              = optional(string)
      encryption_at_host_enabled                             = optional(bool)
      eviction_policy                                        = optional(string)
      extensions_time_budget                                 = optional(string)
      priority                                               = optional(string)
      provision_vm_agent                                     = optional(bool)
      proximity_placement_group_id                           = optional(string)
      secure_boot_enabled                                    = optional(bool)
      source_image_id                                        = optional(string)


      admin_ssh_key = optional(object(
        {

          public_key = string
          username   = string
        }

      ))

      plan = optional(object({

        name      = string
        product   = string
        publisher = string

      }))

      owner       = optional(string)
      co_owner    = optional(string)
      environment = optional(string)

    }
  ))
}



variable "key_vault" {

  type = map(object(
    {
      name                = string
      location            = string
      resource_group_name = string
      sku_name            = string
      tenant_id           = string

      enabled_for_deployment          = optional(bool)
      enabled_for_disk_encryption     = optional(bool)
      enabled_for_template_deployment = optional(bool)
      rbac_authorization_enabled      = optional(bool)
      purge_protection_enabled        = optional(bool)
      public_network_access_enabled   = optional(bool)
      soft_delete_retention_days      = optional(number)

      access_policy = optional(object({

        tenant_id = optional(string)
        object_id = optional(string)

        application_id          = optional(string)
        certificate_permissions = optional(list(string))
        key_permissions         = optional(list(string))
        secret_permissions      = optional(list(string))
        storage_permissions     = optional(list(string))

        }), 
      )

      network_acls = optional(object({

        bypass         = string
        default_action = string

        ip_rules                   = optional(list(string))
        virtual_network_subnet_ids = optional(set(string))

        })
      )

      owner       = optional(string)
      co_owner    = optional(string)
      environment = optional(string)

    }
  ))
}