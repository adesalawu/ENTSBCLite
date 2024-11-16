output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_1_id" {
  value = var.SBCSWE_HFE_SUBNET
}

