data "aws_caller_identity" "atual" {}

module "bucket_dados" {
  source = "git::https://github.com/terraform-em-producao/terraform-modules.git//modules/s3-bucket-seguro?ref=s3-bucket-seguro/v1.0.0"

  nome = "prod-dados-${data.aws_caller_identity.atual.account_id}"

  expirar_versoes_antigas_em_dias = 90
}
