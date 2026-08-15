# terraform-aws-s3

Bucket S3 com versionamento, criptografia server-side, bloqueio de acesso público
e lifecycle opcional. Usado pelo template `ardoq-solution-s3` do Backstage
(`backstage-bs`), disparado via webhook do Ardoq.

## Uso

```hcl
module "s3" {
  source = "git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/s3?ref=v1.0.0"

  bucket_name = "minha-solucao-bucket"
  tags = {
    Project   = "minha-solucao"
    ManagedBy = "terraform"
  }
}
```

## Inputs

| Nome | Tipo | Default | Descrição |
|---|---|---|---|
| `bucket_name` | `string` | — (obrigatório) | Nome do bucket (globalmente único). |
| `force_destroy` | `bool` | `false` | Permite destruir o bucket com objetos dentro. |
| `block_public_access` | `bool` | `true` | Bloqueia ACLs/políticas públicas. |
| `versioning` | `bool` | `true` | Habilita versionamento. |
| `encryption_algorithm` | `string` | `"AES256"` | `AES256` ou `aws:kms`. |
| `kms_key_id` | `string` | `null` | ARN da KMS key (obrigatório se `encryption_algorithm = "aws:kms"`). |
| `lifecycle_expiration_days` | `number` | `0` | Dias até expirar objetos. `0` desabilita. |
| `tags` | `map(string)` | `{}` | Tags do bucket. |

## Outputs

| Nome | Descrição |
|---|---|
| `bucket_id` | ID (nome) do bucket. |
| `bucket_arn` | ARN do bucket. |
| `bucket_domain_name` | Domain name do bucket. |

## Versionamento

Releases via git tag semver (`vMAJOR.MINOR.PATCH`). Consumidores devem fixar
`ref` — nunca apontar pra `main`.
