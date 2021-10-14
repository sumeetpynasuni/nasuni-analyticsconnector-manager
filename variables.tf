
variable "availability_zone" {
  description = "availability zone used for the demo, based on AWS region"
  default = {
    us-east-1 = "us-east-1a"
    us-east-2 = "us-east-2a"
  }
}

# this is a keyName for key pairs
variable "aws_key_name" {
  description = "Key Pair Name used to provision to the box"
}

variable "instance_ami" {
  description = "Amazon Machine Image for the Instance"
}

variable "instance_type" {
  description = "type of instances to provision"
}

variable "vpc_public_sg_id" {
  description = "VPC public security group"
}

variable "aws_profile" {
  description = "aws profile : defaults to nasuni"
  default = "nasuni"
}
variable "region" {
  description = "VPC region: defaults to us-east-1 (N.Virginia)"
}

/* variable "public_ssh_key" {
  description = "Public SSH key value"
} */
