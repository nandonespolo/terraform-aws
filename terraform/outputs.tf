# #----root/outputs.tf-----
output "tf_LoadBalancer_DNS_name" {
  value = "${module.loadbalancer.elb_dns_name}"
}

output "tf_Bastion_Instance" {
  value = "${module.compute.tf_Bastion_Instance}"
}

output "tf_webservers_subnet" {
  value = "${join(", ", module.networking.tf_webservers_subnet)}"
}
