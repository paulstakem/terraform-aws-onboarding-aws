# Simple Integration

Configuration in this directory creates the IAM roles needed to integrate Orca with an AWS account.

## Usage

```bash
terraform validate
terraform init
terraform plan
terraform apply
```

## Terrform Docs
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.12 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_orca"></a> [orca](#module\_orca) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | IAM role used for Orca intergration |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
