# terraform-aws-alb

Application Load Balancer + Target Group + Listener HTTP, já ligados entre
si (no Ardoq, ALB e Target Group costumam ser 2 componentes de arquitetura
separados — aqui nascem juntos, é a mesma unidade de infraestrutura).

## Uso

```hcl
module "alb" {
  source = "git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/alb?ref=v1.1.0"

  name       = "minha-solucao"
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.public_subnet_ids

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
| `subnet_ids` | `list(string)` | — (obrigatório) | Subnets do ALB, mínimo 2. |
| `internal` | `bool` | `false` | `true` = ALB interno (subnets privadas). |
| `target_port` | `number` | `80` | Porta de destino do target group. |
| `health_check_path` | `string` | `"/"` | Path do health check. |
| `allowed_cidr_blocks` | `list(string)` | `["0.0.0.0/0"]` | CIDRs liberados na porta 80. |
| `tags` | `map(string)` | `{}` | Tags dos recursos. |

## Outputs

| Nome | Descrição |
|---|---|
| `dns_name` | DNS name do ALB. |
| `arn` | ARN do ALB. |
| `target_group_arn` | ARN do target group. |
| `security_group_id` | SG do ALB. |

## Versionamento

Releases via git tag semver (`vMAJOR.MINOR.PATCH`). Consumidores devem fixar
`ref` — nunca apontar pra `main`.
