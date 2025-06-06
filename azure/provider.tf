terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.5.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "3.0.1"
    }

  }

  backend "azurerm" {
    resource_group_name  = "SBC-Paas-HA"
    storage_account_name = "PaaS-SBC-strg"
    container_name       = "PaaS-SBC"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

provider "azuread" {
  client_id     = var.azure_client_id
  client_secret = var.azure_client_secret
  tenant_id     = var.azure_tenant_id
}


