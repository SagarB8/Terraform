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

resource "aws_instance" "Terraform hands-on" {
  ami           = "ami-0caf778a172362f1c"
  instance_type = "t2.micro"
  key_name = "LinuxCLS1"
  vpc_security_group_ids = ["sg-03316bd636d90cc14"]
  subnet_id = "subnet-0a0778948a08ae08a"
  associate_public_ip_address = true

  tags = {
    Name = "Terraform hands-on"
  }
}
