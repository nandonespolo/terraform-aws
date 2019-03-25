#-----root/main.tf
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.aws_region}"
}

module "networking" {
  source           = "./networking"
  vpc_cidr         = "${var.vpc_cidr}"
  webservers_cidrs = "${var.webservers_cidrs}"
  db_cidrs         = "${var.db_cidrs}"
}

module "loadbalancer" {
  source               = "./loadbalancer"
  tf_webservers_sg     = "${module.networking.tf_webservers_sg}"
  tf_webservers_subnet = "${module.networking.tf_webservers_subnet}"
  server_port          = "${var.server_port}"
  tf_tg                = "${module.compute.tf_tg}"
}

module "compute" {
  source               = "./compute"
  tf_ami_01            = "${var.tf_ami_01}"
  tf_ami_bastion       = "${var.tf_ami_bastion}"
  instance_type        = "${var.instance_type}"
  tf_webservers_sg     = "${module.networking.tf_webservers_sg}"
  tf_webservers_subnet = "${module.networking.tf_webservers_subnet}"
  tf_bastion_sg        = "${module.networking.tf_bastion_sg}"
  aws_elb              = "${module.loadbalancer.elb_id}"
  subnet_ips           = "${module.networking.tf_Subnet_IPs}"
  key_name             = "${var.key_name}"
  terraform_key        = "${var.key_path}"
  ec2_data             = "${var.ec2_data}"
  tf_vpc               = "${module.networking.tf_vpc}"
}
