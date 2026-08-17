# terraform-aws-cloudfront

Distribuição CloudFront com origem S3 privada (via Origin Access Control) ou
origem HTTP custom. Não cria nem depende do bucket — quem chama o módulo
passa `origin_domain_name` (ex: `module.s3.bucket_regional_domain_name`).

## Uso

```hcl
module "cloudfront" {
  source = "git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/cloudfront?ref=v1.1.0"

  name                          = "minha-solucao"
  origin_domain_name            = module.s3.bucket_regional_domain_name
  use_s3_origin_access_control  = true
  tags = {
    Project   = "minha-solucao"
    ManagedBy = "terraform"
  }
}
```

Se `use_s3_origin_access_control = true`, o bucket S3 de origem precisa de uma
`aws_s3_bucket_policy` liberando `cloudfront.amazonaws.com` com a condição
`AWS:SourceArn = module.cloudfront.distribution_arn` — isso fica por conta de
quem orquestra os módulos (o bucket não pertence a este módulo).

## Inputs

| Nome | Tipo | Default | Descrição |
|---|---|---|---|
| `name` | `string` | — (obrigatório) | Prefixo do nome do Origin Access Control. |
| `origin_domain_name` | `string` | — (obrigatório) | Domain name da origem. |
| `use_s3_origin_access_control` | `bool` | `false` | `true` = origem S3 privada via OAC. `false` = origem HTTP custom. |
| `price_class` | `string` | `"PriceClass_100"` | `PriceClass_100`, `PriceClass_200` ou `PriceClass_All`. |
| `default_root_object` | `string` | `"index.html"` | Objeto padrão da raiz. |
| `viewer_protocol_policy` | `string` | `"redirect-to-https"` | `allow-all`, `redirect-to-https` ou `https-only`. |
| `allowed_methods` | `list(string)` | `["GET","HEAD"]` | Métodos permitidos. |
| `cached_methods` | `list(string)` | `["GET","HEAD"]` | Métodos cacheados. |
| `compress` | `bool` | `true` | Compressão automática. |
| `default_ttl` | `number` | `86400` | TTL padrão em segundos. |
| `tags` | `map(string)` | `{}` | Tags da distribuição. |

## Outputs

| Nome | Descrição |
|---|---|
| `domain_name` | Domain name da distribuição. |
| `distribution_id` | ID da distribuição. |
| `distribution_arn` | ARN da distribuição. |

## Versionamento

Releases via git tag semver (`vMAJOR.MINOR.PATCH`). Consumidores devem fixar
`ref` — nunca apontar pra `main`.
