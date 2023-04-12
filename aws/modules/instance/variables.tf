variable "swe_instance_type" {
  description = "The instance type for the Ribbon SBC SWe"
  type        = string
  default     = "t3.large" 
}

variable "swe_ami_id" {
  description = "The AMI ID for the Ribbon SBC SWe"
  type        = string
  default     = "ami-0123456789abcdef" 
}
