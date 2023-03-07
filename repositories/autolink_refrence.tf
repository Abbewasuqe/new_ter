locals {
  autolink_references = flatten([
    for r in var.repository : [
      for ref in setunion(var.default_autolink_references, coalesce(r.autolink_references, [])) : {
        repository          = github_repository.repository[r.name].name
        key_prefix          = ref.key_prefix
        target_url_template = ref.target_url_template
        is_alphanumeric     = coalesce(ref.is_alphanumeric, true)
      }
    ]
  ])
}

resource "github_repository_autolink_reference" "repository_autolink_reference" {
  for_each = {
    for ref in local.autolink_references : "${ref.repository}_${ref.key_prefix}" => ref
  }

  repository          = each.value.repository
  key_prefix          = each.value.key_prefix
  target_url_template = each.value.target_url_template
  is_alphanumeric     = each.value.is_alphanumeric
}
variable "default_autolink_references" {
  type = list(object({
    key_prefix          = string
    target_url_template = string
    is_alphanumeric     = optional(bool)
  }))
  default = []
}