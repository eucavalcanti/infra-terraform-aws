# terraform-aws-ec2

Instância EC2 standalone. Acesso administrativo só via SSM Session Manager
(sem chave SSH, sem porta 22 aberta), IMDSv2 obrigatório, disco raiz
criptografado, AMI Amazon Linux 2023 mais recente por padrão. Cria seu
próprio security group — libere `app_port` via `allowed_cidr_blocks` e/ou
`allowed_security_group_ids`, nada é aberto por padrão.

## Uso

```hcl
module "ec2" {
  source = "git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/ec2?ref=v1.1.0"

  name      = "minha-solucao"
  vpc_id    = module.network.vpc_id
  subnet_id = module.network.private_subnet_ids[0]

  allowed_security_group_ids = [module.alb.security_group_id]

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
| `subnet_id` | `string` | — (obrigatório) | Subnet (privada) de destino. |
| `instance_type` | `string` | `"t3.small"` | Tipo da instância. |
| `ami_id` | `string` | `""` | AMI. Vazio = Amazon Linux 2023 mais recente. |
| `app_port` | `number` | `8080` | Porta liberada no SG. |
| `root_volume_size` | `number` | `20` | Tamanho do disco raiz (GB). |
| `allowed_cidr_blocks` | `list(string)` | `[]` | CIDRs liberados em `app_port`. |
| `allowed_security_group_ids` | `list(string)` | `[]` | Security groups liberados. |
| `tags` | `map(string)` | `{}` | Tags dos recursos. |

## Outputs

| Nome | Descrição |
|---|---|
| `instance_id` | ID da instância. |
| `private_ip` | IP privado. |
| `security_group_id` | SG da instância. |

## Versionamento

Releases via git tag semver (`vMAJOR.MINOR.PATCH`). Consumidores devem fixar
`ref` — nunca apontar pra `main`.
