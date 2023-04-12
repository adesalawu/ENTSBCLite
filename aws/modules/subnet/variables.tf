
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16" 
}


variable "aailability_zone" {
  description = "The CIDR block for the Availability Zone"
  type        = string
  default     = "US-East-2" 
}


variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24" 
}


variable "public_subnet2_cidr" {
  description = "The CIDR block for the private subnet 2"
  type        = string
  default     = "10.0.2.0/24" 
}


variable "sbc_ha_subnet" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.3.0/24" 
}

variable "sbc_access_subnet" {
  description = "The CIDR block for the access subnet"
  type        = string
  default     = "10.0.4.0/24" 
}

variable "core_subnet_cidr" {
  description = "The CIDR block for the core subnet"
  type        = string
  default     = "10.0.5.0/24" 
}
