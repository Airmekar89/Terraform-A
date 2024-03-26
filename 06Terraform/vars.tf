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
}
variable "app_name" {
  description = "Application Name"
  type        = string
}
