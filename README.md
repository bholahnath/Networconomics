# Terraform AWS VPC Module with Private DNS

This Terraform module provisions an AWS Virtual Private Cloud (VPC) with support for public and private subnets, NAT Gateway, Internet Gateway, and a Private Route53 Hosted Zone for internal DNS resolution.

---

## Features

- Creates a VPC with customizable CIDR block  
- Supports multiple public and private subnets  
- Creates and attaches Internet Gateway for public subnet internet access  
- Creates NAT Gateway(s) for private subnet outbound internet access (optional)  
- Creates Route Tables and subnet associations  
- Sets up a Private Route53 Hosted Zone associated with the VPC for private DNS  
- Tagging support for all resources  

---

## Usage

### Example

```hcl
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./aws_vpc_module"  # Path to this module

  vpc_cidr            = "10.0.0.0/16"
  region              = "us-east-1"
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway  = true
  private_dns_zone_name = "internal.example.com"

  tags = {
    Environment = "dev"
    Project     = "terraform-vpc"
  }
}


======================================================================
Inputs
Name	Description	Type	Default	Required
vpc_cidr	CIDR block for the VPC	string	n/a	yes
region	AWS region to deploy resources	string	n/a	yes
public_subnets	List of CIDRs for public subnets	list(string)	n/a	yes
private_subnets	List of CIDRs for private subnets	list(string)	n/a	yes
enable_nat_gateway	Enable NAT Gateway for private subnet internet access	bool	false	no
private_dns_zone_name	Name of the private Route53 hosted zone	string	n/a	yes
tags	Map of tags to apply to resources	map(string)	{}	no

Outputs
Name	Description
vpc_id	The ID of the created VPC
public_subnet_ids	List of public subnet IDs
private_subnet_ids	List of private subnet IDs
private_zone_id	ID of the private DNS zone

Requirements
Terraform 1.0 or higher

AWS Provider

Notes
Make sure your AWS credentials are properly configured.

The private DNS zone is associated only with this VPC and is not publicly accessible.

When enable_nat_gateway is true, a NAT Gateway is created in the first public subnet.


terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
