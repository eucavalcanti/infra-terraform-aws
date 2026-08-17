# terraform-aws-dynamodb

Tabela DynamoDB com partition key (+ sort key opcional), point-in-time
recovery opcional e TTL opcional.

## Uso

```hcl
module "dynamodb" {
  source = "git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/dynamodb?ref=v1.1.0"

  name = "minha-solucao-table"
  tags = {
    Project   = "minha-solucao"
    ManagedBy = "terraform"
  }
}
```

## Inputs

| Nome | Tipo | Default | Descrição |
|---|---|---|---|
| `name` | `string` | — (obrigatório) | Nome da tabela. |
| `billing_mode` | `string` | `"PAY_PER_REQUEST"` | `PAY_PER_REQUEST` ou `PROVISIONED`. |
| `read_capacity` | `number` | `5` | Só se `PROVISIONED`. |
| `write_capacity` | `number` | `5` | Só se `PROVISIONED`. |
| `hash_key` | `string` | `"id"` | Partition key. |
| `hash_key_type` | `string` | `"S"` | `S`, `N` ou `B`. |
| `range_key` | `string` | `""` | Sort key. Vazio desabilita. |
| `range_key_type` | `string` | `"S"` | `S`, `N` ou `B`. |
| `point_in_time_recovery` | `bool` | `false` | Habilita PITR. |
| `ttl_attribute` | `string` | `""` | Atributo de TTL. Vazio desabilita. |
| `tags` | `map(string)` | `{}` | Tags da tabela. |

## Outputs

| Nome | Descrição |
|---|---|
| `table_name` | Nome da tabela. |
| `table_arn` | ARN da tabela. |

## Versionamento

Releases via git tag semver (`vMAJOR.MINOR.PATCH`). Consumidores devem fixar
`ref` — nunca apontar pra `main`.
