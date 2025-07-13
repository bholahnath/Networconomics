resource "aws_vpc" "flownomics" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags       = merge(var.tags, { Name = "flownomics-vpc" })
}
