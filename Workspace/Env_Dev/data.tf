# data "azurerm_subnet" "subnet1" {

#   depends_on           = [module.subnets, module.vnets]
#   name                 = "AzureBastionSubnet"
#   virtual_network_name = "vnet1"
#   resource_group_name  = "resource-group-1"

# }

# data "azurerm_public_ip" "public_ip1" {

#   depends_on          = [module.public_ip]
#   name                = "public_ip_1"
#   resource_group_name = "resource-group-1"
# }

data "azurerm_subnet" "subnet_id" {

  depends_on = [module.subnets, module.vnets]
  for_each = var.subnets

  name = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name

}

data "azurerm_public_ip" "public_ip_id" {

  depends_on = [module.public_ip]

  for_each = var.pips
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_network_interface" "nic_data" {

  depends_on          = [module.network_interface_card, module.public_ip]

  for_each = var.nics
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}