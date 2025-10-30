resource "azurerm_storage_account" "stg1" {

    for_each = var.stgs

    name = each.value.name
    location =  each.value.location
    resource_group_name = each.value.rg_name 
    account_tier = each.value.account_tier
    account_replication_type = each.value.account_replication_type
    access_tier=each.value.access_tier
    edge_zone=each.value.edge_zone
    https_traffic_only_enabled=each.value.https_traffic_only_enabled
    min_tls_version=each.value.min_tls_version
    shared_access_key_enabled=each.value.shared_access_key_enabled
    public_network_access_enabled=each.value.public_network_access_enabled
    is_hns_enabled=each.value.is_hns_enabled
    allowed_copy_scope=each.value.allowed_copy_scope
    dns_endpoint_type=each.value.dns_endpoint_type

    tags={
        
        owner=each.value.owner
        co_owner=each.value.co_owner
        business_unit=each.value.business_unit
    }
        
}