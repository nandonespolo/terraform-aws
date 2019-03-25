access_key = "YOURACCESSKEY"
secret_key = "YouRScreTKey29843hgnj9420fnb39rud75g"

aws_region = "eu-west-2"

vpc_cidr = "10.77.0.0/16"

dmz_cidrs = [
  "10.77.1.0/24",
  "10.77.2.0/24",
]

webservers_cidrs = [
  "10.77.11.0/24",
  "10.77.12.0/24",
]

db_cidrs = [
  "10.77.21.0/24",
  "10.77.22.0/24",
]

tf_ami_01 = "ami-23r45y6u7jhygt"

tf_ami_bastion = "ami-werthygbfvdet454tu"

instance_type = "t2.micro"

key_name = "terraform_key"

key_path = "./terraform-bastion_rsa.pub"

ec2_data = "./ec2_data.sh"

server_port = "80"
