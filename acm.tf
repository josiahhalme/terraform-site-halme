resource "aws_acm_certificate" "cert" {
  provider                  = aws.east
  domain_name               = var.domain
  validation_method         = "DNS"
  subject_alternative_names = ["www.${var.domain}"]

  tags = {
    Name        = var.domain
    Environment = "production"
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "domain_name" {
  value = aws_acm_certificate.cert.domain_name
}

output "domain_validation_options" {
  value = aws_acm_certificate.cert.domain_validation_options
}
