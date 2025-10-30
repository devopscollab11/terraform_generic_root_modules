resource "azurerm_public_ip" "public_ip" {

    for_each = var.pips

    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    allocation_method = each.value.allocation_method
    zones = each.value.zones
    ddos_protection_mode = each.value.ddos_protection_mode
    domain_name_label = each.value.domain_name_label
    domain_name_label_scope = each.value.domain_name_label_scope
    edge_zone = each.value.edge_zone
    idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
    ip_version = each.value.ip_version
    sku = each.value.sku
    public_ip_prefix_id = each.value.public_ip_prefix_id
    sku_tier = each.value.sku_tier
    
    tags = {

        owner = each.value.owner
        co_owner = each.value.co_owner
        environment = each.value.environment
    }

}