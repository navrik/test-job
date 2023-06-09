resource "aws_subnet" "private" {
  count                                       = var.availability_zones
  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = cidrsubnet(var.vpc_cidr_block, 3, count.index)
  availability_zone                           = "${data.aws_region.current.name}${data.terraform_remote_state.metadata.outputs.map_az_number[count.index]}"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"

  tags = {
    Name = "subnet-${var.frag_environment}-${var.frag_region}-${var.frag_stack}-private-${data.terraform_remote_state.metadata.outputs.map_az_number[count.index]}"
  }
}

resource "aws_subnet" "public" {
  count                                       = var.availability_zones
  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = cidrsubnet(var.vpc_cidr_block, 4, count.index + 8)
  availability_zone                           = "${data.aws_region.current.name}${data.terraform_remote_state.metadata.outputs.map_az_number[count.index]}"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"

  tags = {
    Name = "subnet-${var.frag_environment}-${var.frag_region}-${var.frag_stack}-public-${data.terraform_remote_state.metadata.outputs.map_az_number[count.index]}"
  }
}