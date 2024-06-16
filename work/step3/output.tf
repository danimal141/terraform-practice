output "dynamic_sgid" {
  value = aws_security_group.main.id
}

output "subnets" {
  value = [for key, value in aws_subnet.main : value.id]
}
