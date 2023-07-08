output "github_service_account" {
  description = "The service account used for GitHub."
  value = google_service_account.github-svc
}

output "github_access_iam_binding" {
  description = "The IAM binding for the GitHub service account."
  value = google_project_iam_member.github-access
}

output "wif_pool_name" {
  description = "The Workload Identity Federation details."
  value = module.gh-oidc.pool_name
}

output "wif_provider_name" {
  description = "The Workload Identity Federation details."
  value = module.gh-oidc.provider_name
}