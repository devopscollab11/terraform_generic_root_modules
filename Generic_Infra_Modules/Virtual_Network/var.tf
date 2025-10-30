
variable "vnets" {
    type = map(object(
        {
            name = string
            location = string
            rg_name = string
            address_space = optional(list(string
            ), [])
            edge_zone = optional(string, null)
            flow_timeout_in_minutes = optional(number, 5)
            private_endpoint_vnet_policies = optional(string, "Disabled")

            owner=optional(string)
            co_owner=optional(string)
            buisness_unit=optional(string)

        }
    ))
}