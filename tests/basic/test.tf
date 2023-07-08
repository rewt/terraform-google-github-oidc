terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0, < 5.0.0"
    }
  }
  required_version = ">= 1.0.0"
}


provider "google" {
  project     = var.project_id
}

variable "project_id" {
  description = "The ID of your project"
  type        = string
}

variable "account_id" {
  description = "The ID of the account"
  type        = string
  default     = "github-access-test"
}

variable "display_name" {
  description = "The display name of the service account"
  type        = string
  default     = "Managed by Terraform - Infra Deploy"
}

variable "role" {
  description = "The role to assign"
  type        = string
  default     = "roles/editor"
}

variable "pool_id" {
  description = "The ID of the identity pool"
  type        = string
  default     = "gh-identity-pool-test"
}

variable "pool_display_name" {
  description = "The display name of the identity pool"
  type        = string
  default     = "Identity Pool Test"
}

variable "provider_id" {
  description = "The ID of the provider"
  type        = string
  default     = "gh-provider-test"
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}


module "gh-oidc" {
  source = "../.."

  project_id = var.project_id
  account_id = var.account_id
  display_name = var.display_name
  role = var.role
  pool_id = var.pool_id
  pool_display_name = var.pool_display_name
  provider_id = var.provider_id
  github_owner = "rewt"
  github_repo = "chatgpt-retrieval-plugin"

}

output "github_service_account" {
  value = module.gh-oidc.github_service_account
}

output "github_access_iam_binding" {
  value = module.gh-oidc.github_access_iam_binding
}

output "wif_pool_name" {
  description = "The Workload Identity Federation details."
  value = module.gh-oidc.wif_pool_name
}

output "wif_provider_name" {
  description = "The Workload Identity Federation details."
  value = module.gh-oidc.wif_provider_name
}