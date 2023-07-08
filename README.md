# Terraform Github Actions Workload Identity Federation (WIF) 

This Terraform module sets up the necessary resources in Google Cloud Platform (GCP) to allow a GitHub Actions workflow to authenticate using Workload Identity Federation. 

## Usage 

Here is a basic example of using this module:

```hcl
module "gh-oidc" {
  source = "../.."

  project_id = var.project_id
  account_id = var.account_id
  display_name = var.display_name
  role = var.role
  pool_id = var.pool_id
  pool_display_name = var.pool_display_name
  provider_id = var.provider_id
  github_owner = "myorg"
  github_repo = "my-repo"

}
