resource "azurerm_key_vault"  "key_vault" {

    for_each = var.key_vault

    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    sku_name = each.value.sku_name
    tenant_id = each.value.tenant_id

    enabled_for_deployment = each.value.enabled_for_deployment
    enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
    enabled_for_template_deployment = each.value.enabled_for_template_deployment
    rbac_authorization_enabled = each.value.rbac_authorization_enabled
    purge_protection_enabled = each.value.purge_protection_enabled 
    public_network_access_enabled = each.value.public_network_access_enabled
    soft_delete_retention_days = each.value.soft_delete_retention_days

    # access_policy {

    #     tenant_id = each.value.access_policy.tenant_id
    #     object_id = each.value.access_policy.object_id
    #     application_id = each.value.access_policy.application_id
    #     certificate_permissions = each.value.access_policy.certificate_permissions
    #     key_permissions = each.value.access_policy.key_permissions
    #     secret_permissions = each.value.access_policy.secret_permissions
    #     storage_permissions = each.value.access_policy.storage_permissions

    # }

    dynamic "access_policy" {

    for_each = (each.value.access_policy != null && try(each.value.access_policy.object_id, null) != null) ? [each.value.access_policy] : []


    content {

        tenant_id = access_policy.value.tenant_id
        object_id = access_policy.value.object_id
        key_permissions = access_policy.value.key_permissions
        secret_permissions = access_policy.value.secret_permissions

     }
}

    network_acls {

        bypass = each.value.network_acls.bypass
        default_action = each.value.network_acls.default_action
        ip_rules = each.value.network_acls.ip_rules
        virtual_network_subnet_ids = each.value.network_acls.virtual_network_subnet_ids
    }

    tags = {

        owner = each.value.owner
        co_owner = each.value.co_owner
        environment = each.value.environment
    }
}