variable "pips" {
    type = map(object(
        {
            name = string
            resource_group_name = string
            location = string
            allocation_method = string
            zones = list(string)
            ddos_protection_mode = string
            domain_name_label = string
            domain_name_label_scope = string
            edge_zone = string
            idle_timeout_in_minutes = number
            ip_version = string
            sku = string
            public_ip_prefix_id = string
            sku_tier = string
            ip_tags = map(string)

            owner = string
            co_owner = string
            environment =string
        }
    ))
}
