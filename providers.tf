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
    client_id       = "cfb628af-80db-4f46-adb9-690c7bebf8fb"
    client_secret   = "j1Y8Q~Q4EzoMBxA6QORZaLSoSRTceThAUXJlpcFj"
    tenant_id       = "b5c47142-c960-43f4-b337-211e1c4a1bb7"
    subscription_id = "fd8b1619-2a10-415d-b7db-a87dfb217eb2"
    
  }
}