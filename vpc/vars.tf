variable "availability_zones" {
  type        = number
  description = "The number of Availability Zones to include (1-4).  It is safe to increase these number in an existing deployment (up to the maximum for the region)"
}

variable "frag_environment" {
  type        = string
  description = "Environment name fragment for use in resource name generation (e.g. vpc-FRAG_ENVIRONMENT-eus1)"
}

variable "frag_region" {
  type        = string
  description = "Region name fragment for use in resource name genersion (e.g. vpc-prod-FRAG_REGION).  Note this is NOT impact deployment region, which is drawn from the provider region."
}

variable "frag_stack" {
  type        = string
  description = "Stack name fragment for use in resource name generation (e.g. vpc-prod-eus1-STACK)"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC - Must be 16-bit or larger, which results in a larger Private B / spare region."
}

variable "vpc_peering_with_route" {
  description = "List of objects to define VPC Peering Routes {peering_name, vpc_id}."
  type = list(
    object({
      peering_name = string
      cidr_block = string
      vpc_id     = string
    })
  )
}
