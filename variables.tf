variable "aws_access_key" {
  description = "The AWS access key for API operations."
  type        = string
}

variable "aws_secret_key" {
  description = "The AWS secret key for API operations."
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "azure_subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}

variable "azure_client_id" {
  description = "The Azure client ID."
  type        = string
}

variable "azure_client_secret" {
  description = "The Azure client secret."
  type        = string
}

variable "azure_tenant_id" {
  description = "The Azure tenant ID."
  type        = string
}


variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
    default     = "example-resources"
}

variable "location" {
    description = "The location of the resources"
    type        = string
    default     = "West Europe"
}

variable "app_service_plan_name" {
    description = "The name of the App Service Plan"
    type        = string
    default     = "example-appserviceplan"
}

variable "app_service_name" {
    description = "The name of the App Service"
    type        = string
    default     = "example-appservice"
}

variable "application_insights_name" {
    description = "The name of the Application Insights"
    type        = string
    default     = "example-appinsights"
}

variable "key_vault_name" {
    description = "The name of the Key Vault"
    type        = string
    default     = "example-keyvault"
}

variable "ad_application_name" {
    description = "The name of the AD Application"
    type        = string
    default     = "example-application"
}

variable "ad_service_principal_password" {
    description = "The password for the AD Service Principal"
    type        = string
    sensitive   = true
    default     = "P@ssw0rd1234!"
}
