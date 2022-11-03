data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
resource "aws_iam_role" "orca" {
  name = "OrcaSecurityRole"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Principal : {
          AWS : "arn:aws:iam::${var.vendor_account_id}:root"
        },
        Condition : {
          StringEquals : {
            "sts:ExternalId" : var.role_external_id
          }
        },
        Effect : "Allow",
        Sid : ""
      }
    ]
  })
}

###############################################################################

resource "aws_iam_policy" "orca" {
  policy      = data.aws_iam_policy_document.orca.json
  name        = "OrcaSecurityPolicy"
  description = "Orca Security Account Policy"
}

resource "aws_iam_role_policy_attachment" "orca" {
  role       = aws_iam_role.orca.name
  policy_arn = aws_iam_policy.orca.arn
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "orca" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:snapshot/*"]
    actions   = ["ec2:CreateTags"]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:TagKeys"
      values   = ["Orca"]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"

      values = [
        "CreateSnapshot",
        "CreateSnapshots",
        "CopySnapshot",
      ]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:snapshot/*"]
    actions   = ["ec2:DeleteSnapshot"]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/Orca"
      values   = ["*"]
    }

    condition {
      test     = "StringNotLikeIfExists"
      variable = "ec2:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:CreateSnapshots",
      "ec2:CreateSnapshot",
      "ec2:CopySnapshot",
      "ec2:ModifySnapshotAttribute",
    ]

    condition {
      test     = "StringNotLikeIfExists"
      variable = "ec2:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:ReEncryptFrom",
      "kms:ReEncryptTo",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:CreateGrant",
    ]

    condition {
      test     = "StringNotLikeIfExists"
      variable = "aws:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }

    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values   = ["ec2.*.amazonaws.com"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["kms:PutKeyPolicy"]

    condition {
      test     = "StringNotLikeIfExists"
      variable = "aws:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
  }
}

###############################################################################

resource "aws_iam_role_policy_attachment" "view_only_extras_policy" {
  role       = aws_iam_role.orca.name
  policy_arn = aws_iam_policy.view_only_extras_policy.arn
}

resource "aws_iam_policy" "view_only_extras_policy" {
  policy      = data.aws_iam_policy_document.view_only_extras_policy.json
  name        = "OrcaSecurityViewOnlyExtrasPolicy"
  description = "Orca Security Extras For View Only Policy"
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "view_only_extras_policy" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "access-analyzer:ListAnalyzers",
      "acm:DescribeCertificate",
      "acm:GetCertificate",
      "apigateway:GET",
      "application-autoscaling:Describe*",
      "appsync:Get*",
      "appsync:List*",
      "autoscaling-plans:Describe*",
      "backup:Get*",
      "backup:List*",
      "cloudfront:Get*",
      "cloudhsm:DescribeClusters",
      "cloudtrail:Describe*",
      "cloudtrail:Get*",
      "cloudtrail:List*",
      "cloudwatch:Describe*",
      "codebuild:BatchGet*",
      "codebuild:List*",
      "config:Get*",
      "dlm:Get*",
      "dms:Describe*",
      "dynamodb:Describe*",
      "dynamodb:List*",
      "ec2:Describe*",
      "ec2:GetEbsEncryptionByDefault",
      "ec2:List*",
      "ec2:SearchTransitGatewayRoutes",
      "ecr:BatchGetImage",
      "ecr:Describe*",
      "ecr:Get*",
      "ecr:List*",
      "eks:Describe*",
      "eks:List*",
      "elasticache:Describe*",
      "elasticfilesystem:Describe*",
      "elasticfilesystem:List*",
      "elasticloadbalancing:Describe*",
      "es:Describe*",
      "es:List*",
      "events:List*",
      "glacier:Describe*",
      "glacier:Get*",
      "globalaccelerator:List*",
      "glue:GetDataCatalogEncryptionSettings",
      "glue:GetDatabases",
      "glue:GetDevEndpoints",
      "glue:GetResourcePolicy",
      "glue:GetSecurityConfigurations",
      "guardduty:Get*",
      "guardduty:List*",
      "iam:Generate*",
      "iam:Get*",
      "iam:Simulate*",
      "kafka:Describe*",
      "kafka:List*",
      "kms:Describe*",
      "kms:Get*",
      "kms:List*",
      "lakeformation:GetDataLakeSettings",
      "lakeformation:GetEffectivePermissionsForPath",
      "lakeformation:ListResources",
      "lambda:Get*",
      "logs:FilterLogEvents",
      "logs:Get*",
      "logs:ListTagsLogGroup",
      "logs:StartQuery",
      "logs:TestMetricFilter",
      "memorydb:Describe*",
      "memorydb:List*",
      "mq:Describe*",
      "mq:List*",
      "organizations:Describe*",
      "qldb:DescribeLedger",
      "qldb:ListLedgers",
      "rds:List*",
      "redshift:Describe*",
      "resource-groups:Get*",
      "resource-groups:List*",
      "resource-groups:Search*",
      "route53:Test*",
      "route53domains:Check*",
      "route53domains:Get*",
      "route53domains:View*",
      "s3:Get*",
      "s3:List*",
      "secretsmanager:Describe*",
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:List*",
      "serverlessrepo:Get*",
      "serverlessrepo:List*",
      "ses:GetIdentityDkimAttributes",
      "ses:GetIdentityPolicies",
      "ses:GetIdentityVerificationAttributes",
      "sns:Get*",
      "sqs:GetQueueAttributes",
      "sqs:ListQueueTags",
      "ssm:Describe*",
      "ssm:GetParameter*",
      "ssm:GetParametersByPath",
      "ssm:List*",
      "sso:DescribePermissionSet",
      "sso:GetInlinePolicyForPermissionSet",
      "sso:ListAccountAssignments",
      "sso:ListInstances",
      "sso:ListManagedPoliciesInPermissionSet",
      "sso:ListPermissionSets",
      "identitystore:DescribeGroup",
      "identitystore:DescribeUser",
      "identitystore:ListGroups",
      "identitystore:ListUsers",
      "tag:Get*",
      "waf-regional:Get*",
      "waf:Get*",
    ]
  }
}

###############################################################################

resource "aws_iam_role_policy_attachment" "secrets_manager_policy" {
  count      = var.secrets_manager_access ? 1 : 0
  role       = aws_iam_role.orca.name
  policy_arn = aws_iam_policy.secrets_manager_policy[0].arn
}

resource "aws_iam_policy" "secrets_manager_policy" {
  count       = var.secrets_manager_access ? 1 : 0
  name        = "OrcaSecuritySecretsManagerPolicy"
  description = "Orca Security Secrets Manager Policy"
  policy      = data.aws_iam_policy_document.secrets_manager_policy[0].json
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "secrets_manager_policy" {
  count = var.secrets_manager_access ? 1 : 0
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:*"]
    actions   = ["secretsmanager:GetSecretValue"]

    condition {
      test     = "StringLike"
      variable = "secretsmanager:ResourceTag/Orca"
      values   = ["SecretAccess"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["kms:Decrypt"]

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/Orca"
      values   = ["SecretAccess"]
    }

    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values   = ["secretsmanager.*.amazonaws.com"]
    }
  }
}

###############################################################################

resource "aws_iam_role_policy_attachment" "view_only_access" {
  role       = aws_iam_role.orca.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}
