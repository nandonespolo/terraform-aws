#-----compute/main.tf
data "template_file" "user_data" {
  count    = 2
  template = "${file("ec2_data.sh")}"
}

resource "aws_key_pair" "tf_bastion_key" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.terraform_key)}"
}

resource "aws_instance" "bastion" {
  ami           = "${var.tf_ami_bastion}"
  instance_type = "t2.micro"

  subnet_id = "${element(var.tf_webservers_subnet, count.index)}"

  # change the Security Group to DMZ later
  vpc_security_group_ids = ["${var.tf_bastion_sg}"]
  key_name               = "${aws_key_pair.tf_bastion_key.id}"

  lifecycle = {
    create_before_destroy = true
  }

  tags {
    Name = "bastion"
  }
}

#----------------------------------------------------------------------
resource "aws_lb_target_group" "tf_tg" {
  name     = "tf-lb-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${var.tf_vpc}"

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_launch_configuration" "tf_lc" {
  image_id        = "${var.tf_ami_01}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${var.tf_webservers_sg}"]
  key_name        = "${aws_key_pair.tf_bastion_key.id}"
  user_data       = "${data.template_file.user_data.*.rendered[count.index]}"

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "tf_asg" {
  name_prefix          = "tf_asg"
  launch_configuration = "${aws_launch_configuration.tf_lc.id}"
  vpc_zone_identifier  = ["${var.tf_webservers_subnet}"]
  health_check_type    = "ELB"

  target_group_arns = ["${aws_lb_target_group.tf_tg.arn}"]
  desired_capacity  = 2
  min_size          = 2
  max_size          = 4

  tags {
    key                 = "Name"
    value               = "tf-asg"
    propagate_at_launch = true
  }

  lifecycle = {
    create_before_destroy = true
  }
}
