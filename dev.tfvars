vpc_cidr           = "10.0.0.0/16"
region             = "eu-west-2"
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.101.0/24", "10.0.102.0/24"]
enable_nat_gateway = true
private_dns_zone_name = "dev.flwn.com"
tags = {
  Environment = "dev"
  Project     = "flownomics"
}
