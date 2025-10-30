variable "vms" {

    type = map(object(
        {
            name = string        
            resource_group_name = string
            location = string
            size = string
            network_interface_ids = list(string)

            zone = string
            license_type = string
            disable_password_authentication = bool
            admin_username = string
            admin_password = string


             os_disk = object({
                
                name = string
                caching = string
                storage_account_type = string

                disk_encryption_set_id = string
                disk_size_gb = string

            })

            source_image_reference = object({

               publisher = string
               offer = string
               sku = string
               version = string 
            })

            allow_extension_operations = bool
            bypass_platform_safety_checks_on_user_schedule_enabled = bool
            capacity_reservation_group_id = string
            dedicated_host_id = string
            disk_controller_type = string
            edge_zone = string
            encryption_at_host_enabled = bool
            eviction_policy = string
            extensions_time_budget = string
            priority = string
            provision_vm_agent = bool
            proximity_placement_group_id = string
            secure_boot_enabled = bool
            source_image_id = string


            admin_ssh_key = object({
                
               public_key = string
               username = string
            })

            plan = object({

              name = string
              product = string
              publisher = string

            })

            owner = optional(string)
            co_owner = optional(string)
            environment = optional(string)
             
       }
    ))
}