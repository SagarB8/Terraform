terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#creating vpc

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

#creating internet gateway

resource "aws_internet_gateway" "demo-gateway" {
  vpc_id = "vpc-0293da1086a6a52fe"

  tags = {
    Name = "demo-gateway"
  }
}

#custom route table

resource "aws_route_table" "sample-route-table" {
  vpc_id = "vpc-0293da1086a6a52fe"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-036cfd7ac664fabc5"
  }

  tags = {
    Name = "sample-route-table"
  }
}

#to create subnet

resource "aws_subnet" "new-subnet" {
  vpc_id     = "vpc-0293da1086a6a52fe"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "new-subnet"
  }
}

#Associting the Subnet with the Route Table

resource "aws_route_table_association" "new-srt" {
  subnet_id      = "subnet-08c6554b3065b1635"
  route_table_id = "rtb-05ec1f035a2aa2e8b"
}

#creating new security group

resource "aws_security_group" "demo_sg" {
  name_prefix = "demo_sg"
  vpc_id      = "vpc-0293da1086a6a52fe"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo_sg"
  }
}

#creating network_interface  

resource "aws_network_interface" "demo_network" {
  subnet_id       = "subnet-08c6554b3065b1635"
  private_ips     = ["10.0.1.10"]
  security_groups = ["sg-043b0f45e0eec8506"]

  tags = {
    Name = "demo_network"
  }
}

#creating elastic_ip

resource "aws_eip" "new_eip" {
  vpc = true
}

resource "aws_eip_association" "new_eip" {
  network_interface_id = "eni-0b4f558bcbd1b4a39"
  allocation_id        = "eipalloc-0d0baf3e63dc955ea"
}

#create new instance

resource "aws_instance" "terraform" {
  ami           = "ami-0caf778a172362f1c"
  instance_type = "t2.micro"
  key_name = "Docker"
  vpc_security_group_ids = ["sg-043b0f45e0eec8506"]
  subnet_id = "subnet-08c6554b3065b1635"
  associate_public_ip_address = true

  tags = {
    Name = "Terraform2"
  }
}
