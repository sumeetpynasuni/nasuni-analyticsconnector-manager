
variable "availability_zone" {
  description = "availability zone used for the demo, based on AWS region"
  default = {
    us-east-1 = "us-east-1a"
    us-east-2 = "us-east-2a"
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

variable "pem_key_file" {
  description = "Pem Key file path to be used to SSH the NACScheduler instance"
  default = ""
}
variable "aws_key" {
  description = "Key Pair Name used to provision the NAC Scheduler instance"
  default = ""
}