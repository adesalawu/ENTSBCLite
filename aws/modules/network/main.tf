# ✅ Virtual Private Cloud (VPC): The foundation of AWS network architecture is the VPC. It's a logically isolated section of the AWS cloud where you can launch resources in a virtual network that you define. VPC enables you to control IP address ranges, subnets, route tables, security groups, and network gateways.

resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# ✅ Subnets: Within a VPC, you create subnets to segment the IP address range. Subnets can be public (accessible from the Internet) or private (not accessible from the Internet). They help organize and control network traffic flow.

resource "aws_subnet" "SBCSWE_HFE_MGMT" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "SBCSWE_HFE_Pub" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "SBCSWE_HFE_PKT1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "SBCSWE_HFE_PKT1"
  }
}

resource "aws_subnet" "SBCSWE_HFE_PKT0" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "SBCSWE_HFE_PKT0"
  }
}

resource "aws_subnet" "SBCSWE_HFE_HA" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "SBCSWE_HFE_HA"
  }
}

# ✅ Route Tables: Route tables define how traffic is routed between subnets and to external networks. They determine the paths that network traffic takes within the VPC.

resource "aws_route_table_association" "SBCSWE_HFE_RTA" {
  subnet_id      = [var.SBCSWE_HFE_SUBNET]
  route_table_id = aws_route_table.SBCSWE_HFE_RT.id
}


resource "aws_route_table" "SBCSWE_HFE_RT" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.SBCSWE_HFE_NAT.id
  }

  tags = {
    Name = "private-route-table"
  }
}


# ✅ Security Groups: Security groups act as virtual firewalls for instances. They control inbound and outbound traffic based on rules you define. Each instance can be associated with one or more security groups.


resource "aws_security_group" "SBCSWE_HFE_MGMT_SG" {
  name_prefix = "SBCSWE_HFE_MGMT"
  description = "Security Group SBCSWE_HFE_MGMT"
  vpc_id      = var.VPCCIDR.id

  dynamic "ingress" {
    for_each = var.MGMT_tcp_ports
    content {
      from_port   = var.MGMT_tcp_ports
      to_port     = var.MGMT_tcp_ports
      protocol    = "tcp"
      cidr_blocks = var.microsoft_teams_sip_ips
    }
  }

  dynamic "ingress" {
    for_each = var.MGMT_udp_ports
    content {
      from_port   = var.MGMT_udp_ports
      to_port     = var.MGMT_udp_ports
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


resource "aws_route_table_association" "SBCSWE_HFE_RTA" {
  subnet_id      = [var.SBCSWE_HFE_SUBNET]
  route_table_id = aws_route_table.SBCSWE_HFE_RT.id
}


resource "aws_route_table" "SBCSWE_HFE_RT" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.SBCSWE_HFE_NAT.id
  }

  tags = {
    Name = "private-route-table"
  }
}


# ✅ Security Groups: Security groups act as virtual firewalls for instances. They control inbound and outbound traffic based on rules you define. Each instance can be associated with one or more security groups.


resource "aws_security_group" "SBCSWE_HFE_MGMT_SG" {
  name_prefix = "SBCSWE_HFE_MGMT"
  description = "Security Group SBCSWE_HFE_MGMT"
  vpc_id      = var.VPCCIDR.id

  dynamic "ingress" {
    for_each = var.MGMT_tcp_ports
    content {
      from_port   = var.MGMT_tcp_ports
      to_port     = var.MGMT_tcp_ports
      protocol    = "tcp"
      cidr_blocks = var.microsoft_teams_sip_ips
    }
  }

  dynamic "ingress" {
    for_each = var.MGMT_udp_ports
    content {
      from_port   = var.MGMT_udp_ports
      to_port     = var.MGMT_udp_ports
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



resource "aws_security_group" "SBCSWE_HFE_PKT_SG" {
  name_prefix = "SBCSWE_HFE_PKT"
  description = "Security Group SBCSWE_HFE_PKT"
  vpc_id      = var.VPCCIDR.id

  dynamic "ingress" {
    for_each = var.PKT_tcp_ports
    content {
      from_port   = var.PKT_tcp_ports
      to_port     = var.PKT_tcp_ports
      protocol    = "tcp"
      cidr_blocks = var.microsoft_teams_sip_ips
    }
  }

  dynamic "ingress" {
    for_each = var.PKT_tcp_ports
    content {
      from_port   = var.PKT_udp_ports
      to_port     = var.PKT_udp_ports
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


resource "aws_security_group" "SBCSWE_HFE_HA_SG" {
  name_prefix = "SBCSWE_HFE_HA"
  description = "Security Group SBCSWE_HFE_HA"
  vpc_id      = var.VPCCIDR.id

  dynamic "ingress" {
    for_each = var.HA_tcp_ports
    content {
      from_port   = var.HA_tcp_ports
      to_port     = var.HA_tcp_ports
      protocol    = "tcp"
      cidr_blocks = var.microsoft_teams_sip_ips
    }
  }

  dynamic "ingress" {
    for_each = var.HA_udp_ports
    content {
      from_port   = var.HA_tcp_ports
      to_port     = var.HA_tcp_ports
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

resource "aws_internet_gateway" "SBCSWE_HFE_GW" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-internet-gateway"
  }
}

resource "aws_nat_gateway" "SBCSWE_HFE_NAT" {
  allocation_id = aws_eip.SBCSWE_HFE_NAT_EIP.id
  subnet_id     = var.SBCSWE_HFE_SUBNET

  tags = {
    Name = "my-nat-gateway"
  }
}


# ✅ Elastic Load Balancing (ELB): ELB distributes incoming application traffic across multiple instances for better availability and fault tolerance.

resource "aws_eip" "SBCSWE_HFE_NAT_EIP" {
  vpc = true
}


# ✅ VPC Peering: VPC peering allows you to connect multiple VPCs together, enabling direct communication between them. Peered VPCs can route traffic between them as if they were part of the same network.



# ✅ Transit Gateway: The Transit Gateway simplifies network architecture by allowing centralized connectivity for multiple VPCs and on-premises networks. It reduces the complexity of managing point-to-point connections.



# ✅ AWS PrivateLink: As discussed earlier, AWS PrivateLink provides private connectivity between VPCs, supported AWS services, and your on-premises networks without exposing traffic to the public internet.

