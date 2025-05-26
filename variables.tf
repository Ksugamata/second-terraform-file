variable "zone_id" {}

variable "domain_name" {
  description = "asuranox.jp"
  type        = string
}

variable "acm_cert_arn" {
  description = "arn:aws:acm:us-east-1:205144096702:certificate/9f6474c5-dbc2-429d-b007-a35521a057f6"
  type        = string
}