variable "vpc_cidr" {
  type = string
  description = "vpc cidr"
}

variable "subnet_cidrs" {
  type = list(string)
  description = "subnet cidrs"
}

variable "sg_ingress_rulus" {
  type = map(object({
    protocol = string
  }))
  description = "sg ingress rules"
}
