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

### Inputs

| Name              | Description                                                  | Type             | Default | Required |
|-------------------|--------------------------------------------------------------|------------------|---------|----------|
| `project_id`      | The ID of the project in which resources will be managed.    | `string`         | n/a     | yes      |
| `account_id`      | The ID of the Service Account to be created.                 | `string`         | n/a     | yes      |
| `display_name`    | The display name for the Service Account.                    | `string`         | n/a     | yes      |
| `role`            | The role that should be applied to the Service Account at the project level. | `string` | n/a | yes |
| `pool_id`         | The ID of the workload identity pool.                        | `string`         | n/a     | yes      |
| `pool_display_name` | The display name for the workload identity pool.           | `string`         | n/a     | yes      |
| `provider_id`     | The ID of the workload identity provider.                    | `string`         | n/a     | yes      |
| `sa_mapping`      | Service account mapping for the OIDC.                        | `map(object)`    | n/a     | yes      |
| `github_owner`    | The owner of the GitHub repository.                          | `string`         | n/a     | yes      |
| `github_repo`     | The name of the GitHub repository.                           | `string`         | n/a     | yes      |

### Outputs

| Name                      | Description                                           |
|---------------------------|-------------------------------------------------------|
| `github_service_account_email` | The email of the created Service Account associated with the Workload Identity Pool |
| `artifact_registry_location` | The location of the Artifact Registry |
| `artifact_registry_url` | The URL of the Artifact Registry |
| `wif_provider_name` | The name of the Workload Identity Federation provider |
| `wif_provider_issuer_uri` | The issuer URI of the Workload Identity Federation provider |
| `service_account_name` | The name of the created Service Account |
| `service_account_unique_id` | The unique ID of the created Service Account |
