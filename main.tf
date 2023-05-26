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
  region = "us-east-1"
}

#A resource block to declare the resource being used. Need to have resource name "aws_instance" defined the same as Terraform documentation.
resource "aws_instance" "dp_website" {
  ami           = "ami-0715c1897453cabd1"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}