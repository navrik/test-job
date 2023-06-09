resource "aws_default_route_table" "vpc" {
  default_route_table_id = aws_vpc.vpc.main_route_table_id

  tags = {
    Name        = "rtb-${aws_vpc.vpc.tags["Name"]}"
    description = "Default route table (${aws_vpc.vpc.tags["Name"]})"
  }
}

resource "aws_route" "peers" {
  count = length(aws_vpc_peering_connection.with_route)

  route_table_id            = aws_default_route_table.vpc.id
  destination_cidr_block    = aws_vpc_peering_connection.with_route[count.index].tags["test"]
  vpc_peering_connection_id = aws_vpc_peering_connection.with_route[count.index].id
}
