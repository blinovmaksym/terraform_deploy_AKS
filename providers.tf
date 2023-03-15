provider "azurerm" {
  features {}
 
}
terraform {
  

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.47.0"
      clienr_id="cfb628af-80db-4f46-adb9-690c7bebf8fb"
      client_secret="j1Y8Q~Q4EzoMBxA6QORZaLSoSRTceThAUXJlpcFj"

    }
    
  }
    backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate12334"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    
  }
}