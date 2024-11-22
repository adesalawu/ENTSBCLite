
variable "SBCSWE_HFE_SUBNET" {
  description = "The CIDR block for the  SBC internal VoIP (private) subnet"
  type        = list
  default     = [aws_subnet.SBCSWE_HFE_MGMT.id, aws_subnet.SBCSWE_HFE_Pub.id,
                aws_subnet.SBCSWE_HFE_PKT1.id, aws_subnet.SBCSWE_HFE_PKT0.id]
} 

variable "SBCSWE_HFE_MGMT_subnet" {
  description = "The CIDR block for the CIDR for public subnet for SBC"
  type        = string
  default     = "10.0.1.0/24"
}


variable "SBCSWE_HFE_PKT0_subnet" {
  description = "The CIDR block for the CIDR for public subnet for SBC"
  type        = string
  default     = "10.0.2.0/24"
}

variable "SBCSWE_HFE_PKT1_subnet" {
  description = "The CIDR block for the Management subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "SBCSWE_HFE_HA_subnet" {
  description = "The CIDR block for the SBC high-availability subnet."
  type        = string
  default     = "10.0.3.0/24"
}

variable "SBCSWE_HFE_Pub_subnet" {
  description = "The CIDR block for the SBC external VoIP (public facing)subnet."
  type        = string
  default     = "10.0.4.0/24"
}


variable "MGMT_tcp_ports" {
  description = "List of TCP ports to allow"
  default     = [22, 2022, 2024, 80, 443, 444]
}

variable "MGMT_udp_ports" {
  description = "List of UDP ports to allow"
  default     = [123, 161, 162, 3054, 3055, 5093]
}

variable "HA_tcp_ports" {
  description = "List of TCP ports to allow HA Forwarding Node Security Groups"
  default     = [5060, 5061]
}

variable "HA_udp_ports" {
  description = "List of UDP ports to allow HA Forwarding Node Security Groups"
  default     = [1024-65535]
}


variable "HA_udp_ports" {
  description = "HA Forwarding Node Security Groups"
  default     = [123, 161, 162, 3054, 3055, 5093]
}

variable "PKT_tcp_ports" {
  description = "List of TCP ports to allow"
  default     = [5060, 5061]
}

variable "PKT_udp_ports" {
  description = "List of UDP ports to allow"
  default     = [1024-65535]
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




variable "key_name" {
  description = "Key Name"
  type        = string
  default     = "45678765"
}
