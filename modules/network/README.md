# terraform-aws-network

VPC com subnets públicas/privadas por AZ, Internet Gateway e NAT Gateway
único (subnets privadas saem pela internet via NAT compartilhado, não um por
AZ). Base de rede consumida pelos outros módulos deste repositório
(`rds`, `msk`, `ec2`, `alb`, `autoscaling`) e pelo template `aws-provisioning`
do Backstage (`backstage-bs`).

## Uso

```hcl
module "network" {
  source = "git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/network?ref=v1.1.0"

  name     = "minha-solucao"
  vpc_cidr = "10.0.0.0/16"
  az_count = 2
  tags = {
    Project   = "minha-solucao"
    ManagedBy = "terraform"
  }
}
```

## Inputs

| Nome | Tipo | Default | Descrição |
|---|---|---|---|
| `name` | `string` | — (obrigatório) | Prefixo dos nomes/tags dos recursos de rede. |
| `vpc_cidr` | `string` | `"10.0.0.0/16"` | Bloco CIDR da VPC. |
| `az_count` | `number` | `2` | Número de AZs (2 ou 3). |
| `tags` | `map(string)` | `{}` | Tags aplicadas a todos os recursos. |

## Outputs

| Nome | Descrição |
|---|---|
| `vpc_id` | ID da VPC. |
| `vpc_cidr_block` | Bloco CIDR da VPC. |
| `public_subnet_ids` | IDs das subnets públicas. |
| `private_subnet_ids` | IDs das subnets privadas. |
| `availability_zones` | AZs usadas. |

## Versionamento

Releases via git tag semver (`vMAJOR.MINOR.PATCH`). Consumidores devem fixar
`ref` — nunca apontar pra `main`.
