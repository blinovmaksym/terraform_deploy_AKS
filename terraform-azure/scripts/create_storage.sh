#!/bin/bash

RESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstate$RANDOM
CONTAINER_NAME=tfstate

 # Check if storage account exists
if ! az storage account show --name $STORAGE_ACCOUNT_NAME --query id --output tsv >/dev/null 2>&1; then
# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus2
# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS  --https-only true
# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME