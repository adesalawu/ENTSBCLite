resource "aws_vpc" "sbc_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Ribbon SBC SWe VPC"
  }
}
