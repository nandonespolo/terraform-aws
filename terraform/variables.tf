variable "aws_region" {}
variable "access_key" {}
variable "secret_key" {}

#-------networking variables
variable "vpc_cidr" {}

variable "dmz_cidrs" {
  type = "list"
}

variable "webservers_cidrs" {
  type = "list"
}

variable "db_cidrs" {
  type = "list"
}

# #-------loadbalancer variables
variable "server_port" {}

# #-------compute variables
variable "tf_ami_01" {}

variable "tf_ami_bastion" {}
variable "instance_type" {}
variable "key_name" {}
variable "key_path" {}
variable "ec2_data" {}
