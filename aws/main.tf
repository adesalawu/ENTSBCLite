
provider "aws" {
  region = "us-west-2"
}


module "vpc" {
  source = "../modules/vpc"

  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.public_subnet_cidr
  vpc_tags = {
    Name = "Ribbon SBC SWe VPC"
  }
  subnet_tags = {
    Name = "Ribbon SBC SWe Subnet"
  }
}


module "subnet" {
  source = "../modules/subnet"
  
  subnet_cidr = var.public_subnet_cidr
  subnet_tags = {
    Name = "ribbon-sbc-subnet"
  }
  
  vpc_id = module.vpc.vpc_id
}

module "security_group" {
  source = "../modules/security_group"

  name_prefix             = var.security_group_name_prefix
  description             = var.security_group_description
  vpc_id                  = module.vpc.vpc_id
  tcp_ports               = var.tcp_ports
  udp_ports               = var.udp_ports
  egress_cidr_block       = var.egress_cidr_block
  microsoft_teams_sip_ips = var.microsoft_teams_sip_ips
}

module "instance" {
  source = "../modules/instance"

  instance_name      = var.sbc_instance_name
  instance_type      = var.swe_instance_type
  ami_id             = data.aws_ami.swe.id
  subnet_id          = module.vpc.subnet_id
  security_group_ids = [module.security_group.id]
  private_ip         = var.private_subnet_cidr
  instance_tags = {
    Name = var.sbc_instance_name
  }
}