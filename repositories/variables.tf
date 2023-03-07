variable "visibility" {
  description = "(Optional) Can be 'public', 'private' or 'internal'"
  type = string
  default = "private"
}

variable "delete_branch_on_merge" {
  description = "(optional) Automatically dele head breanch after pull request"
  type = bool
  default = false
}

variable "default_topics" {
  type        = list(string)
  description = "The default topics to apply to each repository."
  default     = []
}

variable "default_branch_name" {
  type    = string
  default = "main"
}

variable "repository" {
  type = list(object({
    name                = string
    default_branch_name = optional(string)
    topics              = optional(list(string))
    autolink_references = optional(list(object({
      key_prefix          = string
      target_url_template = string
      is_alphanumeric     = bool
    })))
    branch_protections = optional(map(object({
      allows_deletions         = optional(bool)
      required_linear_history  = optional(bool)
      enforce_admins           = optional(bool)
      required_pull_request_reviews = optional(object({
        dismiss_stale_reviews          = optional(bool)
        require_code_owner_reviews     = optional(bool)
        required_approving_review_count = optional(number)
    }))
    required_status_checks       = optional(object({
      contexts = optional(list(string))
      strict   = optional(bool)
    }))
    delete_branch_on_merge = optional(bool)
  })))
}))
}

variable "default_branch_protections" {
  type = map(object({
    allows_deletions            = optional(bool)
    enforce_admins              = optional(bool)
    required_linear_history     = optional(bool)
    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews          = optional(bool)
      require_code_owner_reviews     = optional(bool)
      required_approving_review_count = optional(number)
    }))
    required_status_checks       = optional(object({
      contexts = optional(list(string))
      strict   = optional(bool)
    }))
  }))
  default = {}
}