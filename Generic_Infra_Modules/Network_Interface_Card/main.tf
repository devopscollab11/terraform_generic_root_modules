resource "azurerm_network_interface" "nic" {

    for_each = var.nics

    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name

    auxiliary_mode = each.value.auxiliary_mode
    auxiliary_sku = each.value.auxiliary_sku
    dns_servers = each.value.dns_servers
    edge_zone = each.value.edge_zone
    ip_forwarding_enabled = each.value.ip_forwarding_enabled
    accelerated_networking_enabled = each.value.accelerated_networking_enabled


    ip_configuration {
        
    name                          = each.value.ip_configuration.name
    subnet_id                     = each.value.ip_configuration.subnet_id

    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
    private_ip_address_version    = each.value.ip_configuration.private_ip_address_version
    public_ip_address_id          = each.value.ip_configuration.public_ip_address_id
    
    gateway_load_balancer_frontend_ip_configuration_id = each.value.ip_configuration.gateway_load_balancer_frontend_ip_configuration_id
    primary                       = each.value.ip_configuration.primary
  }

    # dynamic "ip_configuration"  {

    #     for_each = each.value.ip_configuration

    #     content {

    #     name = ip_configuration.value.name
    #     subnet_id = ip_configuration.value.namesubnet_id
    #     private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
    #     private_ip_address_version = ip_configuration.value.private_ip_address_version
    #     public_ip_address_id = ip_configuration.value.public_ip_address_id
    #     gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id
    #     primary = ip_configuration.value.primary

    #     }
    # }
    
     tags = {

        owner = each.value.owner
        co_owner = each.value.co_owner
        environment = each.value.environment
    }
    
    
}