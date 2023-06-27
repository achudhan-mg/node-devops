terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
  access_key = "AKIATKPLJRLMIL44LGD4"
  secret_key = "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"
}