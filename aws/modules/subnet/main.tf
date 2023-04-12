resource "aws_subnet" "sbc_subnet" {
  vpc_id     = aws_vpc.sbc_vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "Ribbon SBC SWe Subnet"
  }
}

resource "aws_subnet" "sbc_subnet2" {
  vpc_id     = aws_vpc.sbc_vpc.id
  cidr_block = var.public_subnet2_cidr

  tags = {
    Name = "Ribbon SBC SWe Subnet"
  }
}

resource "aws_subnet" "sbc_mgt_subnet" {
  vpc_id     = aws_vpc.sbc_vpc.id
  cidr_block = var.mgt_subnet2_cidr

  tags = {
    Name = "Ribbon SBC SWe Subnet"
  }
}


resource "aws_subnet" "sbc_ha_subnet" {
  vpc_id     = aws_vpc.sbc_vpc.id
  cidr_block = var.sbc_ha_subnet

  tags = {
    Name = "Ribbon SBC SWe Subnet"
  }
}


resource "aws_subnet" "sbc_access_subnet" {
  vpc_id     = aws_vpc.sbc_vpc.id
  cidr_block = var.sbc_access_subnet

  tags = {
    Name = "Ribbon SBC SWe Subnet"
  }
}


resource "aws_subnet" "sbc_core_subnet" {
  vpc_id     = aws_vpc.sbc_vpc.id
  cidr_block = var.core_subnet_cidr

  tags = {
    Name = "Ribbon SBC SWe Subnet"
  }
}