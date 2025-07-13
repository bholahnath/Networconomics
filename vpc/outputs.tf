output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.flownomics.id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = [for s in aws_subnet.private : s.id]
}

output "private_hosted_zone_id" {
  description = "Private Hosted Zone ID"
  value       = length(aws_route53_zone.private) > 0 ? aws_route53_zone.private[0].id : ""
}
