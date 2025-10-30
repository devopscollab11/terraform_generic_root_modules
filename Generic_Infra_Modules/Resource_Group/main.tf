# resource "azurerm_resource_group" "RG" {
  
#   for_each = var.RGs

#   name     = each.value.rg_name
#   location = each.value.location

#   tags = {
#     owner    = each.value.owner
#     co_owner = each.value.co_owner
#   }
# }



resource "azurerm_resource_group" "RG" {
  
  name     = var.rg_name
  location = var.location
  tags     = var.tags
  
}