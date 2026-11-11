# infra-live

Os workloads, um diretório (e um state) por ambiente.

```
envs/
├── dev/    role terraform-exec-dev   state infra-live/dev/terraform.tfstate
└── prod/   role terraform-exec-prod  state infra-live/prod/terraform.tfstate
```

## Fluxo de uma mudança

1. Abre PR. O GitHub Actions roda `fmt`, `validate`, `tflint` e `trivy` (sem credencial, em segundos).
2. O Atlantis roda `plan` nos ambientes cujos arquivos mudaram e comenta o resultado.
3. O Atlantis roda as policies (`policies` repo) contra o plan. Se falhar, só um dono pode liberar com `atlantis approve_policies`.
4. Alguém **que não é o autor** aprova o PR.
5. `atlantis apply -p dev` → confere → `atlantis apply -p prod` (prod depende de dev).
6. Você faz o merge **depois** do apply. A `main` sempre reflete o que está aplicado.

## Por que diretórios e não workspaces?

- Cada ambiente tem backend, role e versões **explícitos no código**: dá para ver a diferença entre dev e prod num `diff`.
- Promover uma versão de módulo = mudar a `ref` em dev, aplicar, depois mudar em prod.
- Um `terraform workspace select` errado no terminal não existe aqui.

## Promovendo uma versão de módulo

```diff
-  source = "git::...//modules/s3-bucket-seguro?ref=s3-bucket-seguro/v1.0.0"
+  source = "git::...//modules/s3-bucket-seguro?ref=s3-bucket-seguro/v1.1.0"
```

Primeiro em `envs/dev`, num PR. Depois em `envs/prod`, em outro PR.
