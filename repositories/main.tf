

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

resource "github_repository" "repository" {
  for_each    = { for r in var.repository: r.name => r }
  name        = each.value.name
  description = "This is a test repository"
  topics      = concat(coalesce(each.value.topics, []), var.default_topics)
  visibility  = var.visibility
  delete_branch_on_merge = var.delete_branch_on_merge
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

locals {
  default_branches = {
    for r in var.repository :
    r.name => coalesce(r.default_branch_name, var.default_branch_name)
  }
}

resource "github_branch_default" "default_branch" {
  for_each   = local.default_branches
  repository = each.key
  branch     = each.value
}

locals {
  all_branch_protections = flatten([
    for r in var.repository : [
      for pattern, protection in merge(r.branch_protections, var.default_branch_protections) : {
        repository = github_repository.repository[r.name].name
        repository_id = github_repository.repository[r.name].node_id
        pattern = pattern
        allows_deletions = protection.allows_deletions
        required_linear_history = protection.required_linear_history
        enforce_admins = protection.enforce_admins
        required_status_checks = protection.required_status_checks != null ? {
          strict = protection.required_status_checks.strict
          contexts = protection.required_status_checks.contexts
        } : null
        required_pull_request_reviews = protection.required_pull_request_reviews != null ? {
          dismiss_stale_reviews = protection.required_pull_request_reviews.dismiss_stale_reviews
          require_code_owner_reviews = protection.required_pull_request_reviews.require_code_owner_reviews
          required_approving_review_count = protection.required_pull_request_reviews.required_approving_review_count
        } : null
      }
    ]
  ])
}

resource "github_branch_protection" "branch_protection" {
  for_each = {
    for bp in local.all_branch_protections : "${bp.repository}_${bp.pattern}" => bp
  }

  repository_id                   = each.value.repository_id
  pattern                         = each.value.pattern
  allows_deletions                = each.value.allows_deletions
  required_linear_history         = each.value.required_linear_history
  enforce_admins                  = each.value.enforce_admins

  dynamic "required_status_checks" {
    for_each = each.value.required_status_checks != null ? [each.value.required_status_checks] : []
    content {
      strict = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews != null ? [each.value.required_pull_request_reviews] : []
    content {
      dismiss_stale_reviews            = required_pull_request_reviews.value.dismiss_stale_reviews
      require_code_owner_reviews       = required_pull_request_reviews.value.require_code_owner_reviews
      required_approving_review_count  = required_pull_request_reviews.value.required_approving_review_count
    }
  }
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
