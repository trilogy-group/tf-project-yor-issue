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

locals {
  stage = "dev"
  public_instance_name = "public-instance"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "${local.stage}-test-bucket"
  tags = {
    Name                        = "${local.stage}-respond-test-bucket"
    yor_trace                   = "37fb80ff-18cd-4d83-a6fa-59049653877b"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = local.public_instance_name
  }
}
