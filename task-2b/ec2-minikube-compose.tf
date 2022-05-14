//This Terraform Template creates 1 Minikube Machines on EC2 Instances
//Docker-compose Machines will run on Amazon Linux 2 with custom security group
//allowing SSH (22) and HTTP (80) TCP (8080) TCP(30000-32767) connections from anywhere.
//User needs to select appropriate key name when launching the instance.

provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
  //  If you have entered your credentials in AWS CLI before, you do not need to use these arguments.
}

resource "aws_instance" "docker-server" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t3a.medium"
  //  Write your pem file name
  key_name      = "firstkey"
  security_groups = ["minikube-sec-group"]
  tags = {
    Name = "minikube-instance"
  }
  user_data = <<-EOF
              #! /bin/bash

              #update the instance
              apt-get update -y
              apt-get upgrade -y

              #Docker install:
              apt-get install -y docker.io
              
              EOF
}


resource "aws_security_group" "sec-gr" {
  name = "minikube-sec-group"
  tags = {
    Name = "minikube-sec-group"
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 30000
    protocol    = "tcp"
    to_port     = 32767
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "docker-compose-public-ip" {
  value = aws_instance.docker-server.public_ip
}
