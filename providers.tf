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
    storage_account_name = "tfstate12334"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key = "xu+ou9EKTUv24/lMVn3Tcq5f98isQScLqDF1/RDYhydFjT//K30NlYyINEp0M1/9OsqpzHyHB5e0+AStKHDxaA=="
  }
}