resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

# resource "aws_subnet" "main" {
#   count = length(var.subnet_cidrs)
#   vpc_id     = aws_vpc.main.id
#   cidr_block = var.subnet_cidrs[count.index]
# }


resource "aws_subnet" "main" {
  for_each = toset(var.subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = each.key
}

resource "aws_security_group" "main" {
  name   = "main-sg"
  vpc_id = aws_vpc.main.id

 #  dynamic "ingress" {
 #    for_each = toset(var.sg_allow_cidrs)
 #    content {
 #      description = "TLS from VPC"
 #      from_port = 443
 #      to_port = 443
 #      protocol = "tcp"
 #      cidr_blocks = [ingress.key]
 #    }
 #  }

 dynamic "ingress" {
   for_each = var.sg_ingress_rulus
   content {
     description = "ingress rule"
     from_port = 443
     to_port = 443
     protocol = ingress.value.protocol
     cidr_blocks = [ingress.key]
   }
 }
}
