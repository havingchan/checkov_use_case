provider "aws" {
  region = "us-west-2"

}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.56"
    }
  }

  required_version = ">= 1.0"
}


#resource "aws_flow_log" "flow_log" {
#  iam_role_arn    = "arn:aws:iam::314338798034:role/havingwebappec2role"
#  log_destination = "arn:aws:logs:us-west-2:314338798034:log-group:flow-logs:log-stream:flow-log"
#  traffic_type    = "ALL"
#  vpc_id          = aws_vpc.vpc.id
#}
#
#resource "aws_vpc" "vpc" {
#  cidr_block = "10.0.0.0/16"
#  tags = {
#    Name = "my-vpc"
#  }
#}
#
#resource "aws_default_security_group" "default" {
#  vpc_id = aws_vpc.vpc.id
#}
#
resource "aws_subnet" "subnet" {
  vpc_id     = "vpc-084bc1c0ccdeac344"
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "my-subnet"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = "vpc-084bc1c0ccdeac344"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "my-subnet2"
  }
}
#
#resource "aws_security_group" "sg" {
#  vpc_id      = "vpc-084bc1c0ccdeac344"
#  description = "test checko"
#
#  ingress {
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = ["10.0.0.0/16"]
#    description = "allow ingress"
#
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#    description = "allow egress"
#  }
#}
