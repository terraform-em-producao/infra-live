variable "regiao" {
  type    = string
  default = "us-east-1"
}

variable "assume_role_arn" {
  description = "Role da stack. Vazio quando a credencial já vem pronta (drift detection)."
  type        = string
  default     = "arn:aws:iam::907079643427:role/terraform-exec-prod"
}
