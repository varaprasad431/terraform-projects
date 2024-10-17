provider "aws" {
  region = "ap-south-1"
}

locals {
  env = "prasad_digital_vibes"
}

resource "aws_vpc" "prasadone" {
  cidr_block = "10.6.0.0/16"
  tags = {
    Name = "${local.env}-vpc"
  }
}

resource "aws_subnet" "prasadtwo" {
  cidr_block = "10.6.0.0/16"
  vpc_id     = aws_vpc.prasadone.id
  tags = {
    Name = "${local.env}-subnet"
  }
}

resource "tls_private_key" "prasadfour" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "prasadfive" {
  key_name   = "prasad_digital_vibes"
  public_key = tls_private_key.prasadfour.public_key_openssh
}

resource "aws_instance" "prasadthree" {
  subnet_id              = aws_subnet.prasadtwo.id
  ami                    = "ami-04a37924ffe27da53"
  instance_type          = "t2.micro"
  key_name               = "prasad_digital_vibes"
  vpc_security_group_ids = [aws_security_group.ten.id]
  availability_zone      = "ap-south-1a"
  user_data              = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "Hey Hip Hop @@@Prasad_Digital_Vibes@@@" > /var/www/html/index.html
EOF
  tags = {
    Name = "${local.env}-webserverone_instance"
  }
}


resource "aws_instance" "prasadsix" {
  subnet_id              = aws_subnet.prasadtwo.id
  ami                    = "ami-04a37924ffe27da53"
  instance_type          = "t2.micro"
  key_name               = "prasad_digital_vibes"
  vpc_security_group_ids = [aws_security_group.ten.id]
  availability_zone      = "ap-south-1b"
  user_data              = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "Hey Hip Hop $$$Prasad_Digital_Vibes$$$" > /var/www/html/index.html
EOF
  tags = {
    Name = "${local.env}-webservertwo_instance"
  }
}

resource "aws_instance" "prasadseen" {
  subnet_id              = aws_subnet.prasadtwo.id
  ami                    = "ami-04a37924ffe27da53"
  instance_type          = "t2.micro"
  key_name               = "prasad_digital_vibes"
  vpc_security_group_ids = [aws_security_group.ten.id]
  availability_zone      = "ap-south-1a"
  tags = {
    Name = "${local.env}-appserverone_instance"
  }
}

resource "aws_instance" "prasadeight" {
  subnet_id              = aws_subnet.prasadtwo.id
  ami                    = "ami-04a37924ffe27da53"
  instance_type          = "t2.micro"
  key_name               = "prasad_digital_vibes"
  vpc_security_group_ids = [aws_security_group.ten.id]
  availability_zone      = "ap-south-1b"
  tags = {
    Name = "${local.env}-appservertwo_instance"
  }
}

resource "aws_s3_bucket" "prasadnine" {
  bucket = "prasaddigitalvibes431"
}

resource "aws_iam_user" "prasadleven" {
  for_each = var.user_names
  name     = each.value
}

variable "user_names" {
  description = "*"
  type        = set(string)
  default     = ["user1", "user2", "user3", "user4"]
}

resource "aws_ebs_volume" "twelve" {
  availability_zone = "ap-southeast-1a"
  size              = 40
  tags = {
    Name = "prasaddigtalvibes-ebs"
  }
}
resource "aws_security_group" "ten" {
  name = "prasadgigitalvibes-sg"
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


