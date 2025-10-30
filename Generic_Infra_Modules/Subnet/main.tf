resource "azurerm_subnet" "subnet" {

    for_each = var.subnets

    name = each.value.subnet_name
    virtual_network_name = each.value.virtual_network_name
    resource_group_name = each.value.resource_group_name

    address_prefixes = each.value.address_prefixes
    default_outbound_access_enabled = each.value.default_outbound_access_enabled
    private_endpoint_network_policies = each.value.private_endpoint_network_policies
    
    private_link_service_network_policies_enabled  = each.value.private_link_service_network_policies_enabled
    sharing_scope = each.value.sharing_scope 
    service_endpoints = each.value.service_endpoints
    service_endpoint_policy_ids = each.value.service_endpoint_policy_ids
  
}