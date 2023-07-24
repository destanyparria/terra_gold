# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.3.0"
    }

    # This allows us to save files to our local system
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    #this Terraform TLS provider is required to generate an SSH key
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

terraform{
  backend "s3" {
    bucket = "dparrias3wk21"
    key = "terraform.tfstate"
    region = "us-west-2"
  }
}


