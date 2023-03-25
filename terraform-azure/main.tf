resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = var.cluster_name



  default_node_pool {│ Error: Reference to undeclared resource
│ 
│   on main.tf line 28, in resource "local_file" "kubeconfig":
│   28:   content  = azurerm_kubernetes_cluster.aks-rg.kube_config_raw
│ 
│ A managed resource "azurerm_kubernetes_cluster" "aks-rg" has not been
│ declared in the root module.
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }
    
  identity {
    type = "SystemAssigned"
  }
}
resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig"
  content  = azurerm_kubernetes_cluster.aks.kube_config_raw
}
