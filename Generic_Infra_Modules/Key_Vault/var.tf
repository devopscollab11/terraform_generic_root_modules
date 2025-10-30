variable "key_vault" {

    type = map(object(
        {
            name = string
            location = string
            resource_group_name = string
            sku_name = string
            tenant_id = string

            enabled_for_deployment = bool
            enabled_for_disk_encryption = bool
            enabled_for_template_deployment = bool
            rbac_authorization_enabled = bool
            purge_protection_enabled = bool
            public_network_access_enabled = bool
            soft_delete_retention_days = number

            access_policy = optional(object({

               tenant_id = string
               object_id =  optional(string)
               
               application_id = optional(string)
               certificate_permissions = optional(list(string))
               key_permissions = optional(list(string))
               secret_permissions = optional(list(string))
               storage_permissions = optional(list(string))

            })
            )

            network_acls = optional(object({

               bypass = string
               default_action = string

               ip_rules = optional(list(string))
               virtual_network_subnet_ids = optional(set(string))
            })
            )

            owner = string
            co_owner = string
            environment = string

        }
    ))
}