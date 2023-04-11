resource "aws_security_group" "ribbon_sbc" {
  name_prefix = var.security_group_name_prefix
  description = var.security_group_description
  vpc_id      = aws_vpc.sbc_vpc.id

  dynamic "ingress" {
    for_each = var.tcp_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.microsoft_teams_sip_ips
    }
  }

  dynamic "ingress" {
    for_each = var.udp_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "udp"
      cidr_blocks = var.microsoft_teams_sip_ips
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_cidr_block]
  }
}

