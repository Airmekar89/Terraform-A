# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-east-1"
}
/*
# commented as i moved ami_id to using datasource.
variable "ec2_ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0915bcb5fa77e4892" # Amazon2 Linux AMI ID
}
*/
variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 2
}
variable "ec2_instance_tags" {
  description = "EC2 Instance Tags"
  type        = map(string)
  default = {
    Name = "ec2-web"
    Tier = "Web"
  }
}
/*
variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type        = list(string)
  default     = ["t2.micro", "t2.small","t2.medium"]
}
*/
variable "ec2_instance_type_map" {
  description = "EC2 Instance Type using maps"
  type        = map(string)
  default = {
    small-apps  = "t2-micro"
    medium-apps = "t2-medium"
    big-apps    = "t2-large"
  }
}
variable "ec2_key_name" {
  description = "EC2 Instance key pair"
  type        = string
  default     = "LM-Class32"
}
variable "environment_name" {
  description = "name of the environment"
  type        = string
}
variable "app_name" {
  description = "Application Name"
  type        = string
}

 