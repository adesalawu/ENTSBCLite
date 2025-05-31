variable "project_name" {
  description = "Project name for the infrastructure"
  type        = string
}

variable "aws_region" {
  description = "Global Region"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  sensitive   = true
}

variable "availability_zone" {
  type        = list(string)
  description = "Availability Zone"
}


variable "SBCAvailabilityZone" {
  description = "The CIDR block for the Availability Zone for SBC."
  type        = string
}

variable "sbc_infra" {
  description = "The CIDR block for the VPC CIDR block for new VPC"
  type        = string
  default     = "10.0.0.0/16"
}


variable "sbc_MGMT_subnet" {
  description = "The CIDR block for the CIDR for public subnet for SBC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "sbc_pub_subnet" {
  description = "The CIDR block for the CIDR for public subnet for SBC"
  type        = string
  default     = "10.0.2.0/24"
}

variable "sbc_PKT0_subnet" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "sbc_PKT1_subnet" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "sbc_HA_subnet" {
  description = "The CIDR block for the SBC high-availability subnet."
  type        = string
  default     = "10.0.3.0/24"
}

variable "wan_global" {
  description = "Global CIDR block for the VPC"
  type        = list(string)
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
  default     = [1024 - 65535]
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
  default     = [1024 - 65535]
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

variable "key_name" {
  description = "Key Name"
  type        = string
  default     = "45678765"
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


variable "SBCCLIPassword" {
  description = "The AMI ID for the Ribbon SBC SWe"
  type        = string
  default     = "input"
}


variable "aws_access_key" {
  description = "The AWS access key for API operations."
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "The AWS secret key for API operations."
  type        = string
  sensitive   = true
}

variable "public_key_path" {
  description = "The public key path for SSH access."
  type        = string
}

variable "username" {
  description = "The username for the EC2 instance"
  type        = string
}
