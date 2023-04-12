
resource "aws_instance" "sbc_instance" {
  ami                    = var.SBCAMIID
  instance_type          = var.SBCInstanceType
  key_name               = var.key_name
  subnet_id              = aws_subnet.sbc_subnet.id
  vpc_security_group_ids = [aws_security_group.ribbon_sbc.id]
  private_ip             = var.private_subnet_cidr

  tags = {
    Name = var.sbc_instance_name
  }
}

