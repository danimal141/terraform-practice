resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = var.dev ? true : false
  enable_dns_hostnames = var.dev ? true : false
}

resource "aws_subnet" "main" {
 for_each = var.dev ? toset(var.subnet_cidrs) : toset([])
 vpc_id = aws_vpc.main.id
 cidr_block = each.key
}
