resource "azurerm_linux_virtual_machine" "virtual_machine" {

    for_each = var.vms

    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    size = each.value.size
    network_interface_ids = each.value.network_interface_ids

    zone = each.value.zone
    license_type = each.value.license_type
    disable_password_authentication = each.value.disable_password_authentication
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password

    os_disk {

        name = each.value.os_disk.name
        caching = each.value.os_disk.caching
        storage_account_type = each.value.os_disk.storage_account_type
        disk_encryption_set_id = each.value.os_disk.disk_encryption_set_id
        disk_size_gb = each.value.os_disk.disk_size_gb

    }

    source_image_reference {

               publisher = each.value.source_image_reference.publisher
               offer = each.value.source_image_reference.offer
               sku = each.value.source_image_reference.sku
               version = each.value.source_image_reference.version
            }


    allow_extension_operations = each.value.allow_extension_operations
    bypass_platform_safety_checks_on_user_schedule_enabled = each.value.bypass_platform_safety_checks_on_user_schedule_enabled
    capacity_reservation_group_id = each.value.capacity_reservation_group_id
    dedicated_host_id = each.value.dedicated_host_id
    disk_controller_type = each.value.disk_controller_type
    edge_zone = each.value.edge_zone
    encryption_at_host_enabled = each.value.encryption_at_host_enabled
    eviction_policy = each.value.eviction_policy
    extensions_time_budget = each.value.extensions_time_budget
    priority =  each.value.priority
    provision_vm_agent =  each.value.provision_vm_agent
    proximity_placement_group_id =  each.value.proximity_placement_group_id
    secure_boot_enabled =  each.value.secure_boot_enabled
    source_image_id =  each.value.source_image_id

    # admin_ssh_key {
                
    #            public_key = each.value.admin_ssh_key.public_key
    #            username = each.value.admin_ssh_key.username
    #         }

    # plan {

    #         name = each.value.plan.name
    #         product = each.value.plan.product
    #         publisher = each.value.plan.publisher

    #     }


    dynamic "admin_ssh_key" {
        
        for_each = each.value.admin_ssh_key != null ? [each.value.admin_ssh_key] : []
        content {
            public_key = admin_ssh_key.value.public_key
            username   = admin_ssh_key.value.username
        }
    }

    # Conditionally include plan block
    dynamic "plan" {
        
        for_each = each.value.plan != null ? [each.value.plan] : []
        content {
            name      = plan.value.name
            product   = plan.value.product
            publisher = plan.value.publisher
        }
    }

     tags = {

        owner = each.value.owner
        co_owner = each.value.co_owner
        environment = each.value.environment
    }

}
