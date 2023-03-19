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
    backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate16766"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    client_id       = "value"
    client_secret   = "value"
    tenant_id       = "value"
    subscription_id = "value"
  }
}




