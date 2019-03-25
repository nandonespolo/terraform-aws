# #-----compute/variables
variable "tf_ami_bastion" {}

variable "instance_type" {}
variable "ec2_data" {}
variable "tf_ami_01" {}
variable "tf_webservers_sg" {}
variable "tf_bastion_sg" {}
variable "aws_elb" {}

variable "tf_webservers_subnet" {
  type = "list"
}

variable "subnet_ips" {}
variable "terraform_key" {}
variable "key_name" {}
variable "tf_vpc" {}
