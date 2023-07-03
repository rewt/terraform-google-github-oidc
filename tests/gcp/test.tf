terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.5"
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
  default     = "github-access"
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
  default     = "gh-identity-pool"
}

variable "pool_display_name" {
  description = "The display name of the identity pool"
  type        = string
  default     = "Identity Pool"
}

variable "provider_id" {
  description = "The ID of the provider"
  type        = string
  default     = "gh-provider"
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}


# enable project services
resource "google_project_service" "wif_api" {
  for_each = toset([
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
  ])

  service            = each.value
  disable_on_destroy = false
}

# Service account associated with workload identity pool
resource "google_service_account" "github-svc" {
  project      = var.project_id
  account_id   = var.account_id
  display_name = var.display_name
}

resource "google_project_iam_member" "github-access" {
  project = var.project_id
  role    = var.role
  member  = "serviceAccount:${google_service_account.github-svc.email}"
}

# create workload id pool and provider
module "gh_oidc" {
  source            = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version           = "v3.1.1"

  project_id        = var.project_id
  pool_id           = format("%s-%s", var.pool_id, random_string.suffix.id)
  pool_display_name = var.pool_display_name
  provider_id       = var.provider_id
  sa_mapping = {
    (google_service_account.github-svc.account_id) = {
      sa_name   = google_service_account.github-svc.name
      attribute = "*"
    }
  }
}