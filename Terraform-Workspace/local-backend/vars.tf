# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources will be created"
  type        = string
  default     = "us-east-1"
}
variable "aws_profile" {
  description = "IAM profile in AWS to be authenticated and authorized by"
  type        = string
  default     = "iac_user"
}
variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "172.30.0.0/16"
}
variable "environment_name" {
  description = "name of the environment"
  type        = string
  default     = "dev"
}
variable "app_name" {
  description = "Application Name"
  type        = string
  default     = "tf-s3bknd"
}
variable "instance_type" {
  description = "EC2 Instance Type - Instance Sizing"
  type = string
  default = "t2.micro"
  #default = "t2.small"
}