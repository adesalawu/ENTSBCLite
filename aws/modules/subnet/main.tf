resource "aws_subnet" "sbc_subnet" {
  vpc_id     = var.VPCCIDR.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "Ribbon SBC-SWe"
  }
}

resource "aws_subnet" "sbc_subnet2" {
  vpc_id     = var.VPCCIDR.id
  cidr_block = var.public_subnet2_cidr

  tags = {
    Name = "Ribbon SBC-SWe"
  }
}

resource "aws_subnet" "sbc_mgt_subnet" {
  vpc_id     = var.VPCCIDR.id
  cidr_block = var.mgt_subnet2_cidr

  tags = {
    Name = "Ribbon SBC-SWe"
  }
}

resource "aws_subnet" "sbc_ha_subnet" {
  vpc_id     = var.VPCCIDR.id
  cidr_block = var.sbc_ha_subnet

  tags = {
    Name = "Ribbon SBC-SWe"
  }
}


resource "aws_subnet" "sbc_access_subnet" {
  vpc_id     = var.VPCCIDR.id
  cidr_block = var.sbc_access_subnet

  tags = {
    Name = "Ribbon SBC-SWe"
  }
}


resource "aws_subnet" "sbc_core_subnet" {
  vpc_id     = var.VPCCIDR.id
  cidr_block = var.core_subnet_cidr

  tags = {
    Name = "Ribbon SBC-SWe"
  }
}