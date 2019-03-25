#-----networking/outputs.tf
output "tf_vpc" {
  value = "${aws_vpc.tf_vpc.id}"
}

output "tf_webservers_subnet" {
  value = "${aws_subnet.tf_webservers_subnet.*.id}"
}

output "tf_webservers_sg" {
  value = "${aws_security_group.tf_webservers_sg.id}"
}

output "tf_Subnet_IPs" {
  value = "${aws_subnet.tf_webservers_subnet.*.cidr_block}"
}

output "tf_bastion_sg" {
  value = "${aws_security_group.tf_bastion_sg.id}"
}
