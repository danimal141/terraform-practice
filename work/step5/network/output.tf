output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = [for key, value in aws_subnet.this : value.id]
}
