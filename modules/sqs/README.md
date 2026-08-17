# terraform-aws-sqs

Fila SQS (standard ou FIFO) com dead-letter queue opcional.

## Uso

```hcl
module "sqs" {
  source = "git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/sqs?ref=v1.1.0"

  name = "minha-solucao-queue"
  tags = {
    Project   = "minha-solucao"
    ManagedBy = "terraform"
  }
}
```

## Inputs

| Nome | Tipo | Default | Descrição |
|---|---|---|---|
| `name` | `string` | — (obrigatório) | Nome base da fila. |
| `fifo` | `bool` | `false` | Fila FIFO em vez de standard. |
| `visibility_timeout_seconds` | `number` | `30` | Timeout de visibilidade. |
| `message_retention_seconds` | `number` | `345600` | Retenção de mensagens. |
| `delay_seconds` | `number` | `0` | Atraso antes de ficar visível. |
| `content_based_deduplication` | `bool` | `false` | Só se `fifo = true`. |
| `dead_letter_queue_enabled` | `bool` | `true` | Cria dead-letter queue. |
| `max_receive_count` | `number` | `5` | Tentativas antes de ir pra DLQ. |
| `tags` | `map(string)` | `{}` | Tags das filas. |

## Outputs

| Nome | Descrição |
|---|---|
| `queue_url` | URL da fila principal. |
| `queue_arn` | ARN da fila principal. |
| `dlq_url` | URL da DLQ (`null` se desabilitada). |
| `dlq_arn` | ARN da DLQ (`null` se desabilitada). |

## Versionamento

Releases via git tag semver (`vMAJOR.MINOR.PATCH`). Consumidores devem fixar
`ref` — nunca apontar pra `main`.
