

# Data source for availability zones
data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "flownomics-gw" {
  vpc_id = aws_vpc.flownomics.id
  tags   = merge(var.tags, { Name = "flwn-igw" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.flownomics.id
  tags   = merge(var.tags, { Name = "flwn-public-rt" })
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.flownomics-gw.id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? length(aws_subnet.public) : 0
}

resource "aws_nat_gateway" "flownomics-ng" {
  count         = var.enable_nat_gateway ? length(aws_subnet.public) : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags          = merge(var.tags, { Name = "flwn-ng-${count.index}" })
}

resource "aws_route_table" "private" {
  count  = var.enable_nat_gateway ? length(aws_subnet.private) : 0
  vpc_id = aws_vpc.flownomics.id
  tags   = merge(var.tags, { Name = "flwn-private-rt-${count.index}" })
}

resource "aws_route" "private_nat_gateway" {
  count                  = var.enable_nat_gateway ? length(aws_route_table.private) : 0
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.flownomics-ng[count.index].id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
