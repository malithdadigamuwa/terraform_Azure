terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.74.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "5025cd58-d36e-4b68-bb53-fd4da96dea5f"
  skip_provider_registration = true
}
data "azurerm_client_config" "core" {}
module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "~> 5.2"

  default_location = "West US"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = "myorg"
  root_name      = "My Organization"
}