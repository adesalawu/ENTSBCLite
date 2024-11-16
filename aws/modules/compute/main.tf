# ✅ Virtual Private Cloud (VPC): The foundation of AWS network architecture is the VPC. It's a logically isolated section of the AWS cloud where you can launch resources in a virtual network that you define. VPC enables you to control IP address ranges, subnets, route tables, security groups, and network gateways.

resource "aws_instance" "sbc_instance" {
  ami                    = var.SBCAMIID
  instance_type          = var.SBCInstanceType
  key_name               = var.key_name
  subnet_id              = var.VPCCIDR
  vpc_security_group_ids = [aws_security_group.ribbon_sbc.id]
  private_ip             = var.HFEPublicCIDR1

  tags = {
    Name = {}
  }
}


# ✅ Subnets: Within a VPC, you create subnets to segment the IP address range. Subnets can be public (accessible from the Internet) or private (not accessible from the Internet). They help organize and control network traffic flow.



# ✅ Route Tables: Route tables define how traffic is routed between subnets and to external networks. They determine the paths that network traffic takes within the VPC.



# ✅ Security Groups: Security groups act as virtual firewalls for instances. They control inbound and outbound traffic based on rules you define. Each instance can be associated with one or more security groups.


resource "aws_security_group" "ribbon_sbc" {
  name_prefix = var.security_group_name_prefix
  description = var.security_group_description
  vpc_id      = var.VPCCIDR.id

  dynamic "ingress" {
    for_each = var.tcp_ports
    content {
      from_port   = var.tcp_ports
      to_port     = var.tcp_ports
      protocol    = "tcp"
      cidr_blocks = var.microsoft_teams_sip_ips
    }
  }

  dynamic "ingress" {
    for_each = var.udp_ports
    content {
      from_port   = var.udp_ports
      to_port     = var.udp_ports
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



# ✅ Internet Gateway: The Internet Gateway enables communication between instances in your VPC and the public internet. It's required for resources in public subnets to access the internet.



# ✅ VPC Peering: VPC peering allows you to connect multiple VPCs together, enabling direct communication between them. Peered VPCs can route traffic between them as if they were part of the same network.



# ✅ Transit Gateway: The Transit Gateway simplifies network architecture by allowing centralized connectivity for multiple VPCs and on-premises networks. It reduces the complexity of managing point-to-point connections.



# ✅ AWS PrivateLink: As discussed earlier, AWS PrivateLink provides private connectivity between VPCs, supported AWS services, and your on-premises networks without exposing traffic to the public internet.



# ✅ Elastic Load Balancing (ELB): ELB distributes incoming application traffic across multiple instances for better availability and fault tolerance.
