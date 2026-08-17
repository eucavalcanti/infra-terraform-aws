# terraform-aws-rds

Instância RDS PostgreSQL de instância única, storage criptografado, sem
acesso público. Cria seu próprio security group — libere acesso via
`allowed_cidr_blocks` e/ou `allowed_security_group_ids`, nada é aberto por
padrão.

## Uso

```hcl
module "rds" {
  source = "git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/rds?ref=v1.1.0"

  name       = "minha-solucao"
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids
  password   = var.db_password

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
| `name` | `string` | — (obrigatório) | Identifier da instância. |
| `vpc_id` | `string` | — (obrigatório) | VPC de destino. |
| `subnet_ids` | `list(string)` | — (obrigatório) | Subnets privadas, mínimo 2. |
| `password` | `string` | — (obrigatório, sensitive) | Senha do usuário master. |
| `engine_version` | `string` | `"16"` | Versão do PostgreSQL. |
| `instance_class` | `string` | `"db.t4g.micro"` | Classe da instância. |
| `allocated_storage` | `number` | `20` | Storage (GB). |
| `db_name` | `string` | `"appdb"` | Nome do banco. |
| `username` | `string` | `"app_user"` | Usuário master. |
| `port` | `number` | `5432` | Porta do PostgreSQL. |
| `multi_az` | `bool` | `false` | Multi-AZ. |
| `backup_retention_days` | `number` | `7` | Retenção de backup. `0` desabilita snapshot final. |
| `allowed_cidr_blocks` | `list(string)` | `[]` | CIDRs liberados na porta do banco. |
| `allowed_security_group_ids` | `list(string)` | `[]` | Security groups liberados. |
| `tags` | `map(string)` | `{}` | Tags dos recursos. |

## Outputs

| Nome | Descrição |
|---|---|
| `db_endpoint` | Endpoint (host:port). |
| `db_instance_id` | ID da instância. |
| `security_group_id` | SG da instância. |

## Versionamento

Releases via git tag semver (`vMAJOR.MINOR.PATCH`). Consumidores devem fixar
`ref` — nunca apontar pra `main`.
