output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "id" {
  description = "ID of the domain name"
  value       = try(aws_api_gateway_domain_name.this[0].id, null)
}

output "regional_domain_name" {
  description = "Regional domain name for DNS alias"
  value       = try(aws_api_gateway_domain_name.this[0].regional_domain_name, null)
}

output "regional_zone_id" {
  description = "Regional hosted zone ID for DNS alias"
  value       = try(aws_api_gateway_domain_name.this[0].regional_zone_id, null)
}
