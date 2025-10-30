resource "azurerm_virtual_network" "vnet" {

    for_each = var.vnets

    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.rg_name
    address_space = each.value.address_space
    edge_zone = each.value.edge_zone
    flow_timeout_in_minutes = each.value.flow_timeout_in_minutes 
    private_endpoint_vnet_policies = each.value.private_endpoint_vnet_policies

    tags = {
                owner = each.value.owner
                co_owner = each.value.co_owner
                buisness_unit = each.value.buisness_unit
            }
}