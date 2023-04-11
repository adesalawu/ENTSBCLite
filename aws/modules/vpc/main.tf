resource "aws_vpc" "sbc_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Ribbon SBC SWe VPC"
  }
}
resource "aws_subnet" "sbc_subnet" {
  vpc_id     = aws_vpc.sbc_vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "Ribbon SBC SWe Subnet"
  }
}