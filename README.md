# infra-terraform-aws

Módulos Terraform reutilizáveis de infraestrutura AWS, consumidos como source
remoto (`git::https://github.com/eucavalcanti/infra-terraform-aws.git//modules/<nome>?ref=vX.Y.Z`)
pelos templates de scaffolding do Backstage (`backstage-bs`).

## Módulos

| Módulo | Descrição |
|---|---|
| [`modules/s3`](modules/s3) | Bucket S3 (versionamento, criptografia, bloqueio de acesso público, lifecycle). |

## Convenções

- Cada módulo vive em `modules/<nome>/` com `main.tf`, `variables.tf`,
  `outputs.tf`, `versions.tf`, `README.md`.
- Exemplo de uso em `examples/<nome>-basic/`.
- Releases via git tag semver (`vMAJOR.MINOR.PATCH`) na branch `main`.
  Consumidores fixam `ref` — nunca apontam pra `main` direto.
- Mudança breaking em módulo existente = nova major tag; módulos antigos
  continuam resolvendo pela tag anterior.
