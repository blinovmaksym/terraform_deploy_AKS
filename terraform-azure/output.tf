output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}

output "resource_group_name" {
  value = azurerm_resource_group.aks-rg.name
}
output "lb_id" {
  value = azurerm_lb.aks-lb.id
}

output "public_ip_id" {
  value = azurerm_public_ip.aks-pip.id
}