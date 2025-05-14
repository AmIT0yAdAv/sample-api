output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnets_ids" {
  value = aws_subnet.private[*].id
}

output "default_security_group_id" {
  value = aws_security_group.default.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "nat_gateway_ip" {
  value = aws_eip.nat_eip.public_ip
}
