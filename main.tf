terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  required_version = "= 0.13.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
