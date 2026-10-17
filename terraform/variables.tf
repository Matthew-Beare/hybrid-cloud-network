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
variable "site_admin_cidr" { type = string }
variable "site_public_cidr" {
  type = string
  validation {
    condition     = can(cidrnetmask(var.site_public_cidr)) && var.site_public_cidr != "0.0.0.0/0"
    error_message = "Provide a restricted IPv4 site source range, never 0.0.0.0/0."
  }
}
variable "admin_public_cidr" {
  type = string
  validation {
    condition     = can(cidrnetmask(var.admin_public_cidr)) && var.admin_public_cidr != "0.0.0.0/0"
    error_message = "Provide a restricted IPv4 administrative source range."
  }
}
