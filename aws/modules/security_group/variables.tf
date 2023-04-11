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
    "13.107.64.0/18",
    "52.112.0.0/14",
    "52.120.0.0/14",
    "52.232.0.0/14",
    "52.238.0.0/14",
    "52.114.148.0/22",
    "52.114.152.0/22",
    "52.114.156.0/22",
    "52.114.160.0/22",
    "52.114.164.0/22",
    "52.114.168.0/22",
    "52.114.172.0/22",
    "52.114.176.0/22",
    "52.114.180.0/22",
    "52.114.184.0/22"
  ]
}
