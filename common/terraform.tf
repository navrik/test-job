terraform {
  backend "s3" {
    bucket         = "twill-terraform-qa"
    key            = "tfstate-common"
    region         = "us-east-1"
    profile        = "terraform-123123"
    dynamodb_table = "test"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.36.1"
    }
  }
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  profile = "terraform-123123"

  default_tags {
    tags = {
      Environment  = "qa"
      twill-region = "US"
      Terraform    = "True"
    }
  }
}

data "terraform_remote_state" "metadata" {
  backend = "s3"
  config = {
    bucket         = "twill-terraform-qa"
    key            = "tfstate-metadata"
    region         = "us-east-1"
    profile        = "terraform-123123"
    dynamodb_table = "test"
  }
}

data "aws_caller_identity" "us_east_1" {
  provider = aws.us_east_1
}
