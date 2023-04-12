resource "aws_vpc" "sbc_vpc" {
  cidr_block = var.VPCCIDR.id

  tags = {
    Name = "Ribbon SBC SWe VPC"
  }
}

