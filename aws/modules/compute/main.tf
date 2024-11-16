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

