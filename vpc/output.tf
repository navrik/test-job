output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "peering_connections" {
  value = [for x in aws_vpc_peering_connection.with_route[*] : { vpc_id = aws_vpc.vpc.id, peer_vpc_id = x.peer_vpc_id, vpc_peering_connection_id = x.id }]
}
