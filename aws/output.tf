output "vpc_id" {
  value = aws_vpc.main_vpc
}

output "public_subnet_1_id" {
  value = var.sbc_pub_subnet
}

