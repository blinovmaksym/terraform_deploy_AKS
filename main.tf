provider "azurerm" {
  features {}
 
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.47.0"
    }
  }
}


resource "azurerm_resource_group" "aks-rg" {
  name     = "aks_tf_test"
  location = "EastUS2"
}
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "devops-test-aks"
  kubernetes_version  = "1.24.9"
  location            = "EastUS2"
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = "devops-test-aks"

  default_node_pool {
    name                = "system"
    node_count          = 2
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  
}

