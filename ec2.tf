terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_instance" "terraform" {
  ami           = "ami-0caf778a172362f1c"
  instance_type = "t2.medium"
  key_name = "Docker"
  vpc_security_group_ids = ["sg-03316bd636d90cc14"]
  subnet_id = "subnet-0a0778948a08ae08a"
  associate_public_ip_address = true
  availability_zone = "ap-south-1"

  tags = {
    Name = "Finance-Project_Jenkins"
  }
}

resource "aws_instance" "terraform" {
  ami           = "ami-0caf778a172362f1c"
  instance_type = "t2.micro"
  key_name = "Docker"
  vpc_security_group_ids = ["sg-03316bd636d90cc14"]
  subnet_id = "subnet-0a0778948a08ae08a"
  associate_public_ip_address = true
  availability_zone = "ap-south-1"

  tags = {
    Name = "Monitoring-tool"
  }
}
