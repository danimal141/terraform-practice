variable "vpc_cidr" {
  type = string
  description = "vpc cidr"
}

variable "dev" {
  type = bool
}

variable "subnet_cidrs" {
  type = list(string)
  description = "subnet cidr"
}
