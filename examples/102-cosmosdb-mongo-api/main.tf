# Azure provider version 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.84"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource group 
resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

module "azure_cosmos_db" {
  source               = "Azure/cosmosdb/azurerm"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  cosmos_account_name  = var.cosmos_account_name
  cosmos_api           = var.cosmos_api
  mongo_dbs            = var.mongo_dbs
  mongo_db_collections = var.mongo_db_collections
  depends_on = [
    azurerm_resource_group.this
  ]
}