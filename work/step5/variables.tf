variable "vpc_cidr" {
  type        = string
  description = "vpc cidr"
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "subnet cidr"
}

variable "instance_type" {
  type = string
}

variable "base_name" {
  type = string
}
