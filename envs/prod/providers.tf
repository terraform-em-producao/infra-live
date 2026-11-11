provider "aws" {
  region = var.regiao

  dynamic "assume_role" {
    for_each = var.assume_role_arn == "" ? [] : [var.assume_role_arn]

    content {
      role_arn     = assume_role.value
      session_name = "atlantis-infra-live-prod"
    }
  }

  default_tags {
    tags = {
      projeto     = "terraform-em-producao"
      repositorio = "terraform-em-producao/infra-live"
      gerenciado  = "terraform"
      ambiente    = "prod"
    }
  }
}
