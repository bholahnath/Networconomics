variable "vpc_cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type = bool
}

variable "private_dns_zone_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
