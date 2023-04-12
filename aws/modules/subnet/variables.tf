variable "VPCCIDR" {
  description = "The CIDR block for the VPC CIDR block for new VPC"
  type        = string
  default     = "10.0.0.0/16" 
}


variable "HFEPublicCIDR1" {
  description = "The CIDR block for the CIDR for public subnet for SBC"
  type        = string
  default     = "10.0.1.0/24" 
}


variable "HFEPublicCIDR2" {
  description = "The CIDR block for the CIDR for public subnet for SBC"
  type        = string
  default     = "10.0.2.0/24" 
}

variable "ManagementSubnetCIDR" {
  description = "The CIDR block for the Management subnet"
  type        = string
  default     = "10.0.3.0/24" 
}

variable "SBCHASubnetCIDR" {
  description = "The CIDR block for the SBC high-availability subnet."
  type        = string
  default     = "10.0.3.0/24" 
}

variable "SBCAccessVoipCIDR" {
  description = "The CIDR block for the SBC external VoIP (public facing)subnet."
  type        = string
  default     = "10.0.4.0/24" 
}

variable "SBCCoreVoipCIDR" {
  description = "The CIDR block for the  SBC internal VoIP (private) subnet"
  type        = string
  default     = "10.0.5.0/24" 
}
