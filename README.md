# infra-terraform-aws

Módulos Terraform reutilizáveis de infraestrutura AWS, consumidos como source
remoto (`git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/<nome>?ref=vX.Y.Z`)
pelos templates de scaffolding do Backstage (`backstage-bs`).

## Módulos

| Módulo | Descrição |
|---|---|
| [`modules/network`](modules/network) | VPC, subnets públicas/privadas por AZ, Internet Gateway, NAT Gateway. |
| [`modules/s3`](modules/s3) | Bucket S3 (versionamento, criptografia, bloqueio de acesso público, lifecycle). |
| [`modules/cloudfront`](modules/cloudfront) | Distribuição CloudFront, origem S3 (via OAC) ou custom. |
| [`modules/rds`](modules/rds) | Instância RDS PostgreSQL, SG próprio, sem acesso público. |
| [`modules/sqs`](modules/sqs) | Fila SQS (standard/FIFO) com dead-letter queue opcional. |
| [`modules/dynamodb`](modules/dynamodb) | Tabela DynamoDB, PITR e TTL opcionais. |
| [`modules/ec2`](modules/ec2) | Instância EC2 standalone, acesso só via SSM. |
| [`modules/alb`](modules/alb) | Application Load Balancer + Target Group + Listener. |
| [`modules/autoscaling`](modules/autoscaling) | Launch Template + Auto Scaling Group + policy de CPU. |
| [`modules/msk`](modules/msk) | Cluster MSK (Kafka gerenciado). |

## Convenções

- Cada módulo vive em `modules/<nome>/` com `main.tf`, `variables.tf`,
  `outputs.tf`, `versions.tf`, `README.md`.
- Exemplo de uso em `examples/<nome>-basic/`.
- Releases via git tag semver (`vMAJOR.MINOR.PATCH`) na branch `main`.
  Consumidores fixam `ref` — nunca apontam pra `main` direto.
- Mudança breaking em módulo existente = nova major tag; módulos antigos
  continuam resolvendo pela tag anterior.
