resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "this" {
  for_each = toset(var.subnet_cidrs)
  vpc_id = aws_vpc.this.id
  cidr_block = each.key
}


