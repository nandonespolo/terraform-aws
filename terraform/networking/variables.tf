#------networking/variables.tf
variable "vpc_cidr" {}

variable "webservers_cidrs" {
  type = "list"
}

variable "db_cidrs" {}
