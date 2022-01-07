
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
  type = map
  default = {
    us-east-1 = "nac-manager-nv"
    us-east-2 = "nac-manager"
  }
}
variable "instance_ami" {
  description = "Amazon Machine Image for the Instance"
  type = map
  default = {
    "us-east-1" = "ami-09e67e426f25ce0d7"
    "us-east-2" = "ami-00399ec92321828f5"
  }
}


variable "instance_type" {
  description = "type of instances to provision"
  default="m4.large"
}

# variable "vpc_public_sg_id" {
#   description = "VPC public security group"
# }

variable "aws_profile" {
  description = "aws profile : defaults to nasuni"
  default = "nasuni"
}
variable "region" {
  description = "VPC region: defaults to us-east-2 (Ohio)"
  default = "us-east-2"
}
variable "volume_size" {
  description = "volume_size default is set as 32GiB"
  default=500
}

variable "nac_scheduler_name" {
  description = "nac_scheduler_name by default is NACScheduler"
  default="NACScheduler"
}