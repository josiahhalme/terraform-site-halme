resource "aws_s3_bucket" "terraform_state" {
  bucket        = "web-${var.name}-terraform"
  force_destroy = true

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "web-${var.name}-terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# You can't use interpolations for this
terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    bucket         = "web-halme-terraform"
    key            = "terraform"
    region         = "ap-southeast-2"
    encrypt        = "true"
    dynamodb_table = "web-halme-terraform-lock"
  }
}
