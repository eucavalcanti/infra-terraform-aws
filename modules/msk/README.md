# terraform-aws-msk

Cluster MSK (Kafka gerenciado). `number_of_broker_nodes` é sempre igual a
`length(subnet_ids)` (1 broker por subnet/AZ) — não é exposto como variável
porque a AWS exige que seja múltiplo do número de `client_subnets`; deixar
isso implícito no módulo remove essa forma de erro de configuração.

## Uso

```hcl
module "msk" {
  source = "git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/msk?ref=v1.1.0"

  name       = "minha-solucao"
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids

  allowed_security_group_ids = [module.ec2.security_group_id]

  tags = {
    Project   = "minha-solucao"
    ManagedBy = "terraform"
  }
}
```

## Inputs

| Nome | Tipo | Default | Descrição |
|---|---|---|---|
| `name` | `string` | — (obrigatório) | Prefixo dos recursos. |
| `vpc_id` | `string` | — (obrigatório) | VPC de destino. |
| `subnet_ids` | `list(string)` | — (obrigatório) | Subnets privadas, mínimo 2 — 1 broker por subnet. |
| `kafka_version` | `string` | `"3.8.x"` | Versão do Kafka. |
| `broker_instance_type` | `string` | `"kafka.t3.small"` | Tipo de instância dos brokers. |
| `ebs_volume_size` | `number` | `100` | EBS de cada broker (GB). |
| `allowed_cidr_blocks` | `list(string)` | `[]` | CIDRs liberados na porta 9094 (TLS). |
| `allowed_security_group_ids` | `list(string)` | `[]` | Security groups liberados. |
| `tags` | `map(string)` | `{}` | Tags dos recursos. |

## Outputs

| Nome | Descrição |
|---|---|
| `bootstrap_brokers_tls` | Endpoints TLS dos brokers. |
| `security_group_id` | SG do cluster. |

## Versionamento

Releases via git tag semver (`vMAJOR.MINOR.PATCH`). Consumidores devem fixar
`ref` — nunca apontar pra `main`.
