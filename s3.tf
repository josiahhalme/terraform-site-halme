resource "aws_s3_bucket" "web" {
  bucket = var.domain
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid       = "PublicReadGetObject"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.web.arn}/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "web" {
  bucket = aws_s3_bucket.web.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
