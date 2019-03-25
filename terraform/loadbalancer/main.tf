#-----loadbalancer/main.tf
resource "aws_lb" "tf_loadbalancer" {
  name               = "tf-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.tf_webservers_sg}"]
  subnets            = ["${var.tf_webservers_subnet}"]
}

resource "aws_lb_listener" "tf_lb_listener-80" {
  load_balancer_arn = "${aws_lb.tf_loadbalancer.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action = {
    type             = "forward"
    target_group_arn = "${var.tf_tg}"
  }
}
