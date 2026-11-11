data "aws_caller_identity" "atual" {}

module "bucket_dados" {
  source = "git::https://github.com/terraform-em-producao/terraform-modules.git//modules/s3-bucket-seguro?ref=s3-bucket-seguro/v1.0.0"

  nome = "tep-dev-dados-${data.aws_caller_identity.atual.account_id}"

  # Em dev, pode apagar com conteúdo e não guardamos histórico longo (7 dias).
  force_destroy                   = true
  expirar_versoes_antigas_em_dias = 6
}
