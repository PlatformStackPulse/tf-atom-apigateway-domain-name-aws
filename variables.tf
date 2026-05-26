variable "domain_name" {
  description = "Custom domain name"
  type        = string
  validation {
    condition     = length(var.domain_name) > 0
    error_message = "domain_name must not be empty."
  }
}

variable "regional_certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string
  validation {
    condition     = length(var.regional_certificate_arn) > 0
    error_message = "regional_certificate_arn must not be empty."
  }
}

variable "security_policy" {
  description = "TLS version (TLS_1_0 or TLS_1_2)"
  type        = string
  default     = "TLS_1_2"
  validation {
    condition     = contains(["TLS_1_0", "TLS_1_2"], var.security_policy)
    error_message = "security_policy must be TLS_1_0 or TLS_1_2."
  }
}
