#----root/backend.tf
terraform {
  backend "s3" {
    bucket         = "bucketnametostoretfstatefile"
    key            = "terraform/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform_lock"
    encrypt        = true
  }
}
