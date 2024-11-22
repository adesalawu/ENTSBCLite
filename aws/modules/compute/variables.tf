

variable "SBCInstanceType" {
  description = "The instance type for the Ribbon SBC SWe"
  type        = string
  default     = "m5.xlarge"
}

variable "SBCAMIID" {
  description = "The AMI ID for the Ribbon SBC SWe"
  type        = string
  default     = "ami-0123456789abcdef"
}

variable "FreePbxInstanceType" {
  description = "The AMI ID for the Ribbon SBC SWe"
  type        = string
  default     = "m5.xlarge"
}

variable "SBCCLIPassword" {
  description = "The AMI ID for the Ribbon SBC SWe"
  type        = string
  default     = "input"
}