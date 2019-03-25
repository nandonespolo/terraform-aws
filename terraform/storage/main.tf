#----storage/main.tf
provider "aws" {
  region = "eu-west-2"
}

resource "random_id" "tf_bucket_id" {
  byte_length = 2
}

resource "aws_s3_bucket" "tf_code" {
  bucket        = "${var.bucket_name}-${random_id.tf_bucket_id.dec}"
  acl           = "private"
  force_destroy = true

  tags {
    Name = "tf_bucket"
  }
}

resource "aws_dynamodb_table" "tf_dynamodb" {
  # this name has to be on backend.tf file
  name           = "tf_lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
