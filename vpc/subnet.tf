resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  cidr_block        = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  vpc_id            = aws_vpc.flownomics.id
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags              = merge(var.tags, { Name = "flwn-public-subnet-${count.index}" })
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  cidr_block        = var.private_subnets[count.index]
  vpc_id            = aws_vpc.flownomics.id
  map_public_ip_on_launch = false
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags              = merge(var.tags, { Name = "flwn-private-subnet-${count.index}" })
}


