# Used by vpc
data "aws_vpc" "client-vpn" {
  provider = aws.us_east_1

# Used by client-vpn
data "aws_vpc" "use1-aurora" {
  provider = aws.us_east_1

  id = "vpc-id-should-be-here"
}