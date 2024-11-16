
variable "SBCSWE_HFE_SUBNET" {
  description = "The CIDR block for the  SBC internal VoIP (private) subnet"
  type        = list
  default     = [aws_subnet.SBCSWE_HFE_MGMT.id, aws_subnet.SBCSWE_HFE_Pub.id,
                aws_subnet.SBCSWE_HFE_PKT1.id, aws_subnet.SBCSWE_HFE_PKT0.id]
} 

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

variable "security_group_name_prefix" {
  description = "Prefix for the name of the security group"
  default     = "ribbon-sbc-sg"
}

variable "security_group_description" {
  description = "Description for the security group"
  default     = "Security group for Ribbon SBC"
}

variable "tcp_ports" {
  description = "List of TCP ports to allow"
  default     = [5060, 5062, 5080, 5081, 5090, 5091]
}

variable "udp_ports" {
  description = "List of UDP ports to allow"
  default     = [3478, 3479, 3480, 3481, 3489, 50000, 50020, 50040, 50060, 50080]
}

variable "egress_cidr_block" {
  description = "CIDR block to allow egress traffic to"
  default     = "0.0.0.0/0"
}

variable "microsoft_teams_sip_ips" {
  type = list(string)
  default = [
    "13.107.64.0/18", "52.112.0.0/14", "52.120.0.0/14", "52.232.0.0/14",
    "52.238.0.0/14", "52.114.148.0/22", "52.114.152.0/22", "52.114.156.0/22",
    "52.114.160.0/22", "52.114.164.0/22", "52.114.168.0/22", "52.114.172.0/22",
    "52.114.176.0/22", "52.114.180.0/22", "52.114.184.0/22"
  ]
}


variable "SBCAvailabilityZone" {
  description = "The CIDR block for the Availability Zone for SBC."
  type        = string
  default     = "US-East-2"
}

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



variable "key_name" {
  description = "Key Name"
  type        = string
  default     = "45678765"
}
