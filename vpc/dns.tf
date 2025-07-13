resource "aws_route53_zone" "private" {
  count = length(var.private_dns_zone_name) > 0 ? 1 : 0

  name = var.private_dns_zone_name
  vpc {
    vpc_id = aws_vpc.flownomics.id
  }
  tags = var.tags
}
