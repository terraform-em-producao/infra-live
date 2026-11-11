# Um state por ambiente: plan mais rápido e um erro no dev nunca toca o prod.
terraform {
  backend "s3" {
    bucket       = "terraform-em-producao-tfstate-907079643427"
    key          = "infra-live/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    kms_key_id   = "alias/terraform-state"
    use_lockfile = true
  }
}
