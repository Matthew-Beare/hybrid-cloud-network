variable "aws_region" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_id" { type = string }
variable "private_subnet_id" { type = string }
variable "ubuntu_ami_id" { type = string }
variable "ec2_key_name" { type = string }

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "site_admin_cidr" {
  type = string
  validation {
    condition     = can(cidrnetmask(var.site_admin_cidr)) && can(regex("/(2[4-9]|3[0-2])$", var.site_admin_cidr))
    error_message = "Use a defined IPv4 administration subnet (/24 or narrower)."
  }
}

variable "site_public_cidr" {
  type = string
  validation {
    condition     = can(cidrnetmask(var.site_public_cidr)) && can(regex("/32$", var.site_public_cidr))
    error_message = "The WireGuard peer must have one approved public IPv4 /32 address."
  }
}

variable "admin_public_cidr" {
  type = string
  validation {
    condition     = can(cidrnetmask(var.admin_public_cidr)) && can(regex("/32$", var.admin_public_cidr))
    error_message = "SSH administration must be limited to one public IPv4 /32 address."
  }
}
