variable "aws_region" {
  description = "Region where the environment will be"
  type        = string
  default     = "us-west-2"
}

variable "ami" {
  description = "ami-id"
  type        = string
  default     = "ami-0ae49954dfb447966"
}

variable "apacheboot" {
  description = "Bootstraps EC2 with Apache Webserver"
  type        = string
  default     = <<-EOF
    
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo systemctl restart httpd
    EOF
}

variable "dparrias3wk21" {
  description = "S3 bucket for ASG remote backend"
  type        = string
  default     = "dparrias3wk21"
}



    