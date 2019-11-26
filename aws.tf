provider "aws" {
  region              = var.region
  allowed_account_ids = [var.account_id]
  version             = "~> 2.0"
}

provider "aws" {
  alias               = "east"
  region              = "us-east-1"
  allowed_account_ids = [var.account_id]
  version             = "~> 2.0"
}
