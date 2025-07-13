resource "aws_security_group" "default" {
  name        = "${var.vpc_cidr}-flwn-sg"
  description = "Default security group"
  vpc_id      = aws_vpc.flownomics.id
  tags        = var.tags

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
