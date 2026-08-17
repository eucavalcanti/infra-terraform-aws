# terraform-aws-autoscaling

Launch Template + Auto Scaling Group + política de target tracking por CPU.
Mesmo padrão de acesso do módulo `ec2` (SSM, sem SSH, IMDSv2, disco
criptografado). Não sabe nada sobre ALB — se você quer anexar a um load
balancer, passe `target_group_arns` e (se quiser restringir a origem do
tráfego ao ALB) `allowed_security_group_ids`, ambos vindos do módulo `alb`.

## Uso

```hcl
module "autoscaling" {
  source = "git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/autoscaling?ref=v1.1.0"

  name       = "minha-solucao"
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids

  target_group_arns          = [module.alb.target_group_arn]
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
| `subnet_ids` | `list(string)` | — (obrigatório) | Subnets privadas de destino. |
| `instance_type` | `string` | `"t3.small"` | Tipo das instâncias. |
| `ami_id` | `string` | `""` | AMI. Vazio = Amazon Linux 2023 mais recente. |
| `app_port` | `number` | `8080` | Porta liberada no SG. |
| `root_volume_size` | `number` | `20` | Tamanho do disco raiz (GB). |
| `min_size` / `max_size` / `desired_capacity` | `number` | `1` / `3` / `1` | Tamanho do grupo. |
| `target_cpu_utilization` | `number` | `60` | Alvo (%) da política de scaling. |
| `target_group_arns` | `list(string)` | `[]` | Target groups pra anexar. Vazio = sem load balancer. |
| `allowed_cidr_blocks` | `list(string)` | `[]` | CIDRs liberados em `app_port`. |
| `allowed_security_group_ids` | `list(string)` | `[]` | Security groups liberados. |
| `tags` | `map(string)` | `{}` | Tags dos recursos. |

## Outputs

| Nome | Descrição |
|---|---|
| `asg_name` | Nome do Auto Scaling Group. |
| `security_group_id` | SG das instâncias. |

## Versionamento

Releases via git tag semver (`vMAJOR.MINOR.PATCH`). Consumidores devem fixar
`ref` — nunca apontar pra `main`.
