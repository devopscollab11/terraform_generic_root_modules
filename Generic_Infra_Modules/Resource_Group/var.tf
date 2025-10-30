variable "rg_name" {}
variable "location" {}

variable "tags" {
    
    type = map(string)
    
    default = {
        owner    = "Default_Owner"
        co_owner = "Default_Co_Owner"
    }
}

# variable "RGs" {
    
#     type = map(object({
#     rg_name   = string
#     location  = string
#     owner     = optional(string, "")
#     co_owner  = optional(string, "")
#   }))
# }