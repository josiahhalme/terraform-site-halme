data "aws_iam_policy_document" "deploy_s3_policy" {
  statement {
    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.web.arn}", "${aws_s3_bucket.web.arn}/*"]
  }
}

resource "aws_iam_user" "deploy" {
  name = var.deployuser
}

resource "aws_iam_access_key" "deploy" {
  user = aws_iam_user.deploy.name
}

resource "aws_iam_user_policy" "deploy" {
  name   = var.deployuser
  user   = aws_iam_user.deploy.name
  policy = data.aws_iam_policy_document.deploy_s3_policy.json
}
