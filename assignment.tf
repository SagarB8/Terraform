terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA3KZTPWQJJLNVTX62"
  secret_key = "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"
}

#creating vpc 

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "new-vpc"
  }
}

#creating internet gate way

resource "aws_internet_gateway" "new-gateway" {
  vpc_id = "vpc-051b0b0194a88045d"

  tags = {
    Name = "new-gateway"
  }
}

