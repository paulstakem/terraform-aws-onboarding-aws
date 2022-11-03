output "arn" {
  description = "IAM role used for Orca intergration"
  value       = module.orca.orca_role_arn
}
