variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" { default = "us-west-2" }
variable "aws_vpc" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_subnet_ids" "available" {
  vpc_id = var.aws_vpc
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
