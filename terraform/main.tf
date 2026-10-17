terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "vpn_gateway" {
  name_prefix = "hybrid-vpn-lab-"
  description = "Access to illustrative VPN endpoint"
  vpc_id      = var.vpc_id

  ingress {
    description = "WireGuard traffic from pre-approved site endpoint"
    protocol    = "udp"
    from_port   = 51820
    to_port     = 51820
    cidr_blocks = [var.site_public_cidr]
  }

  ingress {
    description = "SSH from trusted administration host"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.admin_public_cidr]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_app" {
  name_prefix = "hybrid-app-lab-"
  description = "Illustrative private app allow-list"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from authorized on-prem administrative network"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = [var.site_admin_cidr]
  }

  ingress {
    description     = "SSH from VPN gateway security group"
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.vpn_gateway.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vpn_gateway" {
  ami                         = var.ubuntu_ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  key_name                    = var.ec2_key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.vpn_gateway.id]
  source_dest_check           = false
  metadata_options { http_tokens = "required" }
  root_block_device { encrypted = true }
  tags = { Name = "hybrid-example-vpn" }
}

resource "aws_instance" "application" {
  ami                         = var.ubuntu_ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_id
  key_name                    = var.ec2_key_name
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.private_app.id]
  metadata_options { http_tokens = "required" }
  root_block_device { encrypted = true }
  tags = { Name = "hybrid-example-app" }
}
