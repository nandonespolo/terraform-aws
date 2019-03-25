#-----loadbalancer/outputs.tf

output "elb_id" {
  value = "${aws_lb.tf_loadbalancer.id}"
}

output "elb_dns_name" {
  value = "${aws_lb.tf_loadbalancer.dns_name}"
}
