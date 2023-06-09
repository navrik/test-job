resource "aws_vpc_peering_connection" "with_route" {
  count = length(var.vpc_peering_with_route)

  vpc_id      = aws_vpc.vpc.id
  peer_vpc_id = var.vpc_peering_with_route[count.index].vpc_id

  tags = {
    Name                = var.vpc_peering_with_route[count.index].peering_name
    test = var.vpc_peering_with_route[count.index].cidr_block
  }
}
