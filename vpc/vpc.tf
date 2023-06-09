resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "vpc-${var.frag_environment}-${var.frag_region}-${var.frag_stack}"
  }
}
