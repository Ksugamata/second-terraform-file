variable "zone_id" {}

variable "domain_name" {
  description = "example.com"
  type        = string
}

variable "acm_cert_arn" {
  description = "arn:aws:acm:us-east-1:xxxxxxxxxxx:certificate/xxxxxxxxxxx-xxxxxxxxx"
  type        = string
}
