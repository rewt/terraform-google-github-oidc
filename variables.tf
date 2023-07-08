variable "project_id" {
  description = "The ID of your project"
  type        = string
}

variable "account_id" {
  description = "The ID of the account"
  type        = string
}

variable "display_name" {
  description = "The display name of the service account"
  type        = string
}

variable "role" {
  description = "The role to assign"
  type        = string
}

variable "pool_id" {
  description = "The ID of the identity pool"
  type        = string
}

variable "pool_display_name" {
  description = "The display name of the identity pool"
  type        = string
}

variable "provider_id" {
  description = "The ID of the provider"
  type        = string
}

variable "github_owner" {
  description = "The owner or org of the repository that is being granted access to WIF"
  type = string
}

variable "github_repo" {
  description = "The repository with github action requiring authentication through GCP WIF"
  type = string
}