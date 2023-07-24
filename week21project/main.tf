resource "aws_default_vpc" "dparria_vpc" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_launch_configuration" "launch_wk21" {
  name                        = "launch_asg-wk21"
  image_id                    = "ami-0ae49954dfb447966"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.sg_wk21.id]
  user_data                   = base64encode("${var.apacheboot}")
  associate_public_ip_address = true

}
resource "aws_security_group" "sg_wk21" {
  name        = "sg_wk21"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_default_vpc.dparria_vpc.id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}


data "aws_subnet" "subnet1" {
  vpc_id = aws_default_vpc.dparria_vpc.id
  filter {
    name   = "tag:Name"
    values = ["public_subnet_1"]
  }
}

data "aws_subnet" "subnet2" {
  vpc_id = aws_default_vpc.dparria_vpc.id
  filter {
    name   = "tag:Name"
    values = ["public_subnet_2"]
  }
}


resource "aws_autoscaling_group" "asg_wk21" {
  desired_capacity = 2
  max_size         = 5
  min_size         = 2
  vpc_zone_identifier = [
    data.aws_subnet.subnet1.id,
    data.aws_subnet.subnet2.id
  ]
  launch_configuration = aws_launch_configuration.launch_wk21.id
  tag {
    key                 = "Name"
    value               = "asg_wk21"
    propagate_at_launch = true

  }
}


resource "aws_s3_bucket" "dparrias3wk21" {
  bucket = var.dparrias3wk21

  tags = {
    Name = "DParriaS3"

  }
}

resource "aws_s3_bucket_versioning" "s3version" {
  bucket = aws_s3_bucket.dparrias3wk21.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership_s3" {
  depends_on = [aws_s3_bucket.dparrias3wk21]
  bucket     = aws_s3_bucket.dparrias3wk21.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3aclwk21" {
  depends_on = [aws_s3_bucket_ownership_controls.ownership_s3]

  bucket = aws_s3_bucket.dparrias3wk21.id
  acl    = "private"
}