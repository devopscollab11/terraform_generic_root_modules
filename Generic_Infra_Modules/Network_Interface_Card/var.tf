variable "nics" {
    type = map(object(
        {
            name = string
            location = string
            resource_group_name = string

            ip_configuration = object(

                {
                    name = string
                  
                    subnet_id                     = optional(string)
                    private_ip_address_allocation = optional(string)

                    private_ip_address_version                         = optional(string)
                    public_ip_address_id                               = optional(string)
                    gateway_load_balancer_frontend_ip_configuration_id = optional(string)
                    primary                                            = optional(bool)

                    # load_balancer_backend_address_pools_ids          = list(string)
                    # load_balancer_inbound_nat_rules_ids              = list(string)
                }
            )

            auxiliary_mode = string
            auxiliary_sku = string
            dns_servers = list(string)
            edge_zone = string
            ip_forwarding_enabled = bool
            accelerated_networking_enabled = bool

            owner = optional(string)
            co_owner = optional(string)
            environment = optional(string)
        }
    ))
}