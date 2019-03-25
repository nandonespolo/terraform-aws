# #-----compute/outputs
output "terraform_key" {
  value = "terraform_key"
}

output "tf_Bastion_Instance" {
  value = "${aws_instance.bastion.public_dns}"
}

output "tf_tg" {
  value = "${aws_lb_target_group.tf_tg.arn}"
}
