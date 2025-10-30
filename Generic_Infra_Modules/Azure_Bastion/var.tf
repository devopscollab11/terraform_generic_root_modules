variable "bastions"  {
    type = map(object(
        {
            name = string
            resource_group_name = string
            location = string
            copy_paste_enabled = optional(bool)
            file_copy_enabled = optional(bool)
            kerberos_enabled = optional(bool)
            sku = optional(string)
            scale_units = optional(number)
            tunneling_enabled = optional(bool)
            virtual_network_id = optional(string)
            zones = optional(list(string))

            ip_configuration = object(
                {
                    name = string
                    subnet_id = string
                    public_ip_address_id = string
                }
            )
            
            owner = optional(string)
            co_owner = optional(string)
            environment = optional(string)
        }
    ))
}