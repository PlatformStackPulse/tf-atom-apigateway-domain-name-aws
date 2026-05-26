resource "aws_api_gateway_domain_name" "this" {
  count = module.this.enabled ? 1 : 0

  domain_name              = var.domain_name
  regional_certificate_arn = var.regional_certificate_arn
  security_policy          = var.security_policy

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = module.this.tags
}
