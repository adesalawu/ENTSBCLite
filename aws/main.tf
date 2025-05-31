# ✅ Virtual Private Cloud (VPC): The foundation of AWS network architecture is the VPC. It's a logically isolated section of the AWS cloud where you can launch resources in a virtual network that you define. VPC enables you to control IP address ranges, subnets, route tables, security groups, and network gateways.

resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "DC-${var.project_name}-VPC"
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = var.project_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
  content              = tls_private_key.ssh_key.private_key_pem
  filename             = "./${var.project_name}_private_key.pem"
  directory_permission = "0600"
  file_permission      = "0600"
}


resource "local_file" "public_key" {
  content              = tls_private_key.ssh_key.public_key_openssh
  filename             = "./${var.project_name}_public_key.pub"
  directory_permission = "0600"
  file_permission      = "0600"
  depends_on           = [local_file.private_key]
}


resource "aws_instance" "main" {
  ami                         = var.SBCAMIID
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.deployer.key_name
  subnet_id                   = aws_subnet.Infra-Public-Net.id
  availability_zone           = var.availability_zone[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.WebServer-SG.id]
  # user_data = file("./aws-user-data.sh")

  depends_on = [
    aws_security_group.WebServer-SG,
    aws_internet_gateway.igw
  ]

  root_block_device {
    encrypted   = true
    volume_size = 30
    volume_type = "gp3"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = var.username
    private_key = tls_private_key.ssh_key.private_key_pem
    timeout     = "4m"
  }

  tags = {
    "name" = "DC-${var.project_name}"
  }
}

# ✅ Subnets: Within a VPC, you create subnets to segment the IP address range. Subnets can be public (accessible from the Internet) or private (not accessible from the Internet). They help organize and control network traffic flow.

resource "aws_subnet" "SBC_MGMT" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.sbc_MGMT_subnet
  availability_zone       = var.SBCAvailabilityZone
  map_public_ip_on_launch = true
  tags = {
    "name" = "DC-${var.project_name}"
  }
}

resource "aws_subnet" "SBC_HFE_PUB" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.sbc_pub_subnet
  availability_zone       = var.SBCAvailabilityZone
  map_public_ip_on_launch = true
  tags = {
    "name" = "DC-${var.project_name}"
  }
}

resource "aws_subnet" "SBC_HFE_PKT0" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.sbc_PKT0_subnet
  availability_zone = var.SBCAvailabilityZone
  tags = {
    "name" = "DC-${var.project_name}-SBCSWE_HFE_PKT0"
  }
}

resource "aws_subnet" "SBC_HFE_PKT1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.sbc_PKT1_subnet
  availability_zone = var.SBCAvailabilityZone
  tags = {
    "name" = "DC-${var.project_name}-SBCSWE_HFE_PKT1"
  }
}


resource "aws_subnet" "SBC_HFE_HA" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.sbc_HA_subnet
  availability_zone = var.SBCAvailabilityZone
  tags = {
    "name" = "DC-${var.project_name}-SBCSWE_HFE_HA"
  }
}

# ✅ Route Tables: Route tables define how traffic is routed between subnets and to external networks. They determine the paths that network traffic takes within the VPC.

resource "aws_route_table_association" "SBC_HFE_RTA" {
  subnet_id      = aws_subnet.SBC_HFE_PUB.id
  route_table_id = aws_route_table.SBC_HFE_RT.id
}

resource "aws_route_table" "SBC_HFE_RT" {
  vpc_id = aws_vpc.main_vpc.id


  route {
    cidr_block     = [var.wan_global]
    nat_gateway_id = aws_nat_gateway.SBC_HFE_NAT.id
  }

  tags = {
    "name" = "DC-${var.project_name}-SBC_HFE_RTA"
  }
}



# ✅ Internet Gateway: The Internet Gateway enables communication between instances in your VPC and the public internet. It's required for resources in public subnets to access the internet.

resource "aws_internet_gateway" "SBC_HFE_GW" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    "name" = "DC-${var.project_name}-SBC_HFE_GW"
  }
}

resource "aws_nat_gateway" "SBC_HFE_NAT" {
  allocation_id = aws_eip.SBC_HFE_NAT_EIP.id
  subnet_id     = aws_subnet.SBC_HFE_PUB.id

  tags = {
    "name" = "DC-${var.project_name}-SBC_HFE_NAT"
  }
}



# ✅ Elastic Load Balancing (ELB): ELB distributes incoming application traffic across multiple instances for better availability and fault tolerance.

resource "aws_eip" "SBC_HFE_NAT_EIP" {
  domain   = "vpc"
  instance = aws_instance.main.id
  tags = {
    "name" = "DC-${var.project_name}-SBC_HFE_NAT_EIP"
  }
}

resource "aws_eip_association" "eip_association" {
  allocation_id = aws_eip.SBC_HFE_NAT_EIP.id
  instance_id   = aws_instance.main.id
}

resource "aws_eip_domain_name" "eip-domain" {
  allocation_id = aws_eip.SBC_HFE_NAT_EIP.id
  domain_name   = aws_route53_record.www.fqdn
}


# ✅ Security Groups: Security groups act as virtual firewalls for instances. They control inbound and outbound traffic based on rules you define. Each instance can be associated with one or more security groups.

resource "aws_security_group" "SBC_HFE_MGMT_SG" {
  name_prefix = "SBC_HFE_MGMT"
  description = "Security Group SBC_HFE_MGMT"
  vpc_id      = aws_vpc.main_vpc.id

  dynamic "ingress" {
    for_each = var.MGMT_tcp_ports
    content {
      from_port   = var.MGMT_tcp_ports
      to_port     = var.MGMT_tcp_ports
      protocol    = "tcp"
      cidr_blocks = var.wan_global
    }
  }

  dynamic "ingress" {
    for_each = var.MGMT_udp_ports
    content {
      from_port   = var.MGMT_udp_ports
      to_port     = var.MGMT_udp_ports
      protocol    = "udp"
      cidr_blocks = var.wan_global
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.wan_global
  }
}

resource "aws_security_group" "SBC_HFE_PKT_SG" {
  name_prefix = "SBC_HFE_PKT"
  description = "Security Group SBC_HFE_PKT"
  vpc_id      = aws_vpc.main_vpc.id

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
    for_each = var.PKT_udp_ports
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
    cidr_blocks = var.microsoft_teams_sip_ips
  }
}

resource "aws_security_group" "SBC_HFE_HA_SG" {
  name_prefix = "SBC_HFE_HA"
  description = "Security Group SBC_HFE_HA"
  vpc_id      = aws_vpc.main_vpc.id

  dynamic "ingress" {
    for_each = var.HA_tcp_ports
    content {
      from_port   = var.HA_tcp_ports
      to_port     = var.HA_tcp_ports
      protocol    = "tcp"
      cidr_blocks = var.wan_global
    }
  }

  dynamic "ingress" {
    for_each = var.HA_udp_ports
    content {
      from_port   = var.HA_tcp_ports
      to_port     = var.HA_tcp_ports
      protocol    = "udp"
      cidr_blocks = var.wan_global
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.wan_global
  }
}





# ✅ VPC Peering: VPC peering allows you to connect multiple VPCs together, enabling direct communication between them. Peered VPCs can route traffic between them as if they were part of the same network.

# (VPC Peering configuration would go here) 

# ✅ Transit Gateway: The Transit Gateway simplifies network architecture by allowing centralized connectivity for multiple VPCs and on-premises networks. It reduces the complexity of managing point-to-point connections.

# (Transit Gateway configuration would go here)

# ✅ AWS PrivateLink: As discussed earlier, AWS PrivateLink provides private connectivity between VPCs, supported AWS services, and your on-premises networks without exposing traffic to the public internet.

# (AWS PrivateLink configuration would go here)



