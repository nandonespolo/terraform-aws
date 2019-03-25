#-----loadbalancer/variables.tf
variable "tf_webservers_sg" {}

variable "tf_webservers_subnet" {
  type = "list"
}

variable "server_port" {}
variable "tf_tg" {}
