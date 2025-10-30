resource "azurerm_bastion_host" "bastion" {

    for_each = var.bastions 

    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    copy_paste_enabled = each.value.copy_paste_enabled
    file_copy_enabled = each.value.file_copy_enabled
    kerberos_enabled = each.value.kerberos_enabled
    sku = each.value.sku
    scale_units = each.value.scale_units
    tunneling_enabled = each.value.tunneling_enabled
    virtual_network_id = each.value.virtual_network_id
    zones = each.value.zones

    ip_configuration {

    name                 = each.value.ip_configuration.name
    subnet_id            = each.value.ip_configuration.subnet_id
    public_ip_address_id = each.value.ip_configuration.public_ip_address_id

  }

    tags = {

        owner = each.value.owner
        co_owner = each.value.co_owner
        environment = each.value.environment
    }
    
}