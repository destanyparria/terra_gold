#terra_gold/output_providers_ssh


#Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
  }
}

