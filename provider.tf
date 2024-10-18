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

    aws = {
      source  = "hashicorp/aws"
      version = "5.69.0"
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

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
