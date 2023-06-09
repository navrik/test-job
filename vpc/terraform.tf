terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.36.1"
    }
  }
}

data "terraform_remote_state" "metadata" {
  backend = "s3"
  config = {
    bucket         = "test_bucket"
    key            = "tfstate-data"
    region         = "us-east-1"
    profile        = "terraform-123123"
    dynamodb_table = "terraform-test"
  }
}

data "aws_region" "current" {}