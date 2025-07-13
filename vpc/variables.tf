variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway for private subnets"
  type        = bool
  default     = true
}

variable "private_dns_zone_name" {
  description = "Private Hosted Zone domain name"
  type        = string
  default     = ""
}

variable "private_subnets" {
  type = list(string)
  description = "List of CIDR blocks for private subnets"
}

variable "public_subnets" {
  type = list(string)
  description = "List of CIDR blocks for public subnets"
}


