variable "stgs" {
    type = map(object(
        {
            name = string
            location = string
            rg_name = string
            account_replication_type = string
            account_tier  = string
            access_tier=optional(string, "")
            edge_zone=optional(string, null)
            https_traffic_only_enabled=optional(bool, true)
            min_tls_version=optional(string, "")
            shared_access_key_enabled=optional(bool, true)
            public_network_access_enabled=optional(bool, true)
            is_hns_enabled=optional(bool, true)
            allowed_copy_scope=optional(string, "AAD")
            dns_endpoint_type=optional(string, "")

            owner=optional(string)
            co_owner=optional(string)
            business_unit=optional(string)
            
            # network_rules=string
            # last_access_time_enabled=string
        }
    ))
}