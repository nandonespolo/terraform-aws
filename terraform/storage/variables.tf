#----storage/variables.tf
variable "bucket_name" {
  description = "Bucket name used to store the terraform.tfstate files"
  default     = "anythingyouwant"
}
