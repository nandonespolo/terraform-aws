#----networking/main.tf
data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "tf_vpc"
  }
}

resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  tags {
    Name = "tf_igw"
  }
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  # associate this PublicRT with the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf_internet_gateway.id}"
  }

  tags {
    Name = "tf_public"
  }
}

resource "aws_route_table" "tf_private_rt" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  tags {
    Name = "tf_private"
  }
}

resource "aws_subnet" "tf_webservers_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.tf_vpc.id}"
  cidr_block              = "${var.webservers_cidrs[count.index]}"
  map_public_ip_on_launch = true

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "tf_webservers_${count.index + 1}"
  }
}

resource "aws_route_table_association" "tf_public_rt_assoc" {
  # associate this private rt with the private subnets
  count          = "${aws_subnet.tf_webservers_subnet.count}"
  subnet_id      = "${aws_subnet.tf_webservers_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.tf_public_rt.id}"
}

resource "aws_security_group" "tf_bastion_sg" {
  name        = "tf_bastion_sg"
  description = "Used for ssh access to Bastion instance"

  vpc_id = "${aws_vpc.tf_vpc.id}"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf_bastion_sg"
  }
}

resource "aws_security_group" "tf_webservers_sg" {
  name        = "tf_webservers_sg"
  description = "Used for http access from the Load Balancer to the webservers"
  vpc_id      = "${aws_vpc.tf_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.tf_bastion_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf_webservers_sg"
  }

  lifecycle = {
    create_before_destroy = true
  }
}

# RDS infrastructure will be added later
# resource "aws_security_group" "tf_db_sg" {
#   name        = "tf_db_sg"
#   description = "Used for http access from the Load Balancer to the webservers"


#   # associate this sg to the vpc
#   vpc_id = "${aws_vpc.tf_vpc.id}"


#   #HTTP
#   ingress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = ["${aws_security_group.tf_webservers_sg.id}"]
#   }


#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }


#   tags = {
#     Name = "tf_db_sg"
#   }
# }

