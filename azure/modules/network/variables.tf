# Variables
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "Projectname"
}

variable "data_location" {
  description = "Infrastructure data location"
  type        = string
  default     = "United States"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "East-US"
}

variable "SBC_OEM" {
  description = "Ribbon SBC SWe"
  type        = string
  default     = ""
}

variable "egress_cidr_block" {
  description = "CIDR block to allow egress traffic"
  type        = string
  default     = "0.0.0.0/0"
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "nic1_cidr" {
  description = "CIDR for public subnet NIC 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "nic2_cidr" {
  description = "CIDR for public subnet NIC 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "management_subnet_cidr" {
  description = "CIDR block for the Management subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = "sbc-sg"
}

variable "tcp_ports" {
  description = "List of allowed TCP ports"
  type        = list(number)
  default     = [80, 443, 5060, 5062, 5080, 5081, 5090, 5091]
}

variable "udp_ports" {
  description = "List of allowed UDP ports"
  type        = list(number)
  default     = [16384-21384]
}

variable "microsoft_teams_sip_ips" {
  description = "List of Microsoft Teams SIP IP ranges"
  type        = list(string)
  default = [
    "13.107.64.0/18", "52.112.0.0/14", "52.120.0.0/14",
    "52.232.0.0/14", "52.238.0.0/14", "52.114.148.0/22",
    "52.114.152.0/22", "52.114.156.0/22", "52.114.160.0/22",
    "52.114.164.0/22", "52.114.168.0/22", "52.114.172.0/22",
    "52.114.176.0/22", "52.114.180.0/22", "52.114.184.0/22"
  ]
}
