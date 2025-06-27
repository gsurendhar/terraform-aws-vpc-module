output "vpc_id" {
  value       = aws_vpc.this.id
}

output "igw_id" {
  value       = aws_internet_gateway.this.id
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  value       = aws_subnet.database[*].id
}

output "public_subnet_id-1a" {
  value       = aws_subnet.public[0].id
}

output "public_subnet_id-1b" {
  value       = aws_subnet.public[1].id
}

output "private_subnet_id-1a" {
  value       = aws_subnet.private[0].id
}

output "private_subnet_id-1b" {
  value       = aws_subnet.private[1].id
}

output "database_subnet_id-1a" {
  value       = aws_subnet.database[0].id
}

output "database_subnet_id-1b" {
  value       = aws_subnet.database[1].id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "database_route_table_id" {
  value = aws_route_table.database.id
}

# output "vpc_peering_id" {
#   value = aws_vpc_peering_connection.default[0].id
# }

# output "eip_ip" {
#   value = aws_eip.nat[0].public_ip
# }

# output "nat_gateway_id" {
#   value = aws_nat_gateway.main[0].id
# }
