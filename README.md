# AWS Onboarding Orca

# Usage

# Resources

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.37.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.inaccount-scanner-client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.secrets_manager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.view_only_extras_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.inaccount-scanner-client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach_secrets_manager_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_view_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_view_only_extras](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.inaccount-scanner-client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.inaccount-scanner-client-ro](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.inaccount-scanner-client-secrets-manager-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.orca-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_partition"></a> [aws\_partition](#input\_aws\_partition) | AWS partition (aws / aws-cn / aws-us-gov) | `string` | `"aws"` | no |
| <a name="input_inaccount_scanner_account_id"></a> [inaccount\_scanner\_account\_id](#input\_inaccount\_scanner\_account\_id) | in case of inaccount, the scanner account id | `string` | `null` | no |
| <a name="input_policy_type"></a> [policy\_type](#input\_policy\_type) | policy type to install (Supported types: saas/inaccount). Default: saas | `string` | `"saas"` | no |
| <a name="input_role_external_id"></a> [role\_external\_id](#input\_role\_external\_id) | Role external ID. We will be supplied from Orca. | `string` | n/a | yes |
| <a name="input_secrets_manager_access"></a> [secrets\_manager\_access](#input\_secrets\_manager\_access) | Whether to attach SecretsManager policy to Orca's role. Default: true | `bool` | `true` | no |
| <a name="input_vendor_account_id"></a> [vendor\_account\_id](#input\_vendor\_account\_id) | The vendor account id. This is supplied by Orca. | `string` | `"976280145156"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customer_account_id"></a> [customer\_account\_id](#output\_customer\_account\_id) | This is the account id to be used for onboarding the account |
| <a name="output_orca_role_arn"></a> [orca\_role\_arn](#output\_orca\_role\_arn) | Role ARN to be used to onboard |
| <a name="output_orca_role_external_id"></a> [orca\_role\_external\_id](#output\_orca\_role\_external\_id) | The role External ID |
| <a name="output_sidescanner_role_arn"></a> [sidescanner\_role\_arn](#output\_sidescanner\_role\_arn) | The role ARN of the sidescanner. (In case of inaccount policy type) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
