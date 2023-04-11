variable "swe_instance_type" {
  description = "The instance type for the Ribbon SBC SWe"
  type        = string
  default     = "t3.large" # Modify this value to match your requirements
}

variable "swe_ami_id" {
  description = "The AMI ID for the Ribbon SBC SWe"
  type        = string
  default     = "ami-0123456789abcdef" # Modify this value to match the SWe AMI ID
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16" # Modify this value to match your VPC CIDR block
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24" # Modify this value to match your public subnet CIDR block
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24" # Modify this value to match your private subnet CIDR block
}