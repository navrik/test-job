module "svna-vpc" {
  source = "//vpc"

  providers = {
    aws = aws.us_east_1
  }

  availability_zones = 2
  frag_environment   = "qa"
  frag_region        = "use1"
  frag_stack         = "core"
  vpc_cidr_block     = data.terraform_remote_state.metadata.outputs.map_cidr_blocks["vpc-qa-use1-core"]
  vpc_peering_with_route = [
    {
      peering_name = "peer-core-to-cvpc"
      cidr_block   = data.aws_vpc.client-vpn.cidr_block
      vpc_id       = module.client-vpn.vpc_id
    }
  ]
  private_dns_hostname_type = "ip-name"
  public_dns_hostname_type  = "ip-name"

  vpc_endpoint_s3          = true
  vpc_endpoint_ecr         = true
  vpc_endpoint_sts         = true
  vpc_endpoint_logs        = true
  vpc_endpoint_ec2         = true
  vpc_endpoint_autoscaling = true
  vpc_endpoint_elb         = true
  vpc_endpoint_appmesh     = true
}

data "aws_vpc" "vpc" {
  provider = aws.us_east_1

  id = module.svna-vpc.vpc_id
}