provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/terraform-infrastructure-deployment"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.30.0"
    }
  }
}