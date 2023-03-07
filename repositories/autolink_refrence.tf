


# resource "github_repository_autolink_reference" "repository_autolink_reference" {
#   for_each = local.autolink_references
#   # for_each = {
#   #   for repo in var.repository : repo.name => repo.autolink_references
#   #   if length(repo.autolink_references) > 0
#   # }

#   repository          = github_repository.repository[each.key].name
#   key_prefix          = each.value[0].key_prefix
#   target_url_template = each.value[0].target_url_template
# }

# locals {
#   autolink_references = flatten([
#     for r in var.repository : [
#       for ref in concat(var.default_autolink_references, coalesce(r.autolink_references, [])) : {
#         repository_id = github_repository.repository[r.name].id
#         key_prefix = ref.key_prefix
#         target_url_template = ref.target_url_template
#         is_alphanumeric = coalesce(ref.is_alphanumeric, true)
#       }
#     ]
#   ])
# }


# resource "github_repository_autolink_reference" "repository_autolink_reference" {
#   for_each = {
#     for ref in local.autolink_references : "${ref.repository_id}_${ref.key_prefix}" => ref
#   }

#   repository          = github_repository.repository[each.value.repository_id].name
#   key_prefix          = each.value.key_prefix
#   target_url_template = each.value.target_url_template
#   is_alphanumeric     = each.value.is_alphanumeric
# }


# locals {
#   autolink_references = [
#     for r in var.repository : [
#       for ref in setunion(var.default_autolink_references, coalesce(r.autolink_references, [])) : {
#         repository_id = github_repository.repository[r.name].id
#         key_prefix = ref.key_prefix
#         key = "${github_repository.repository[r.name].id}_${ref.key_prefix}"
#         repository = github_repository.repository[r.name].name
#         target_url_template = ref.target_url_template
#         is_alphanumeric = coalesce(ref.is_alphanumeric, true)
#       }
#     ]
#     if length(r.autolink_references) > 0
#   ]
# }

# resource "github_repository_autolink_reference" "repository_autolink_reference" {
#   for_each = {
#   for ref in local.autolink_references :
#   ref.key => ref
# }


#   repository          = each.value.repository
#   key_prefix          = each.value.key_prefix
#   target_url_template = each.value.target_url_template
#   is_alphanumeric     = each.value.is_alphanumeric
# }




locals {
  autolink_references = flatten([
    for r in var.repository : [
      for ref in setunion(var.default_autolink_references, coalesce(r.autolink_references, [])) : {
        repository = github_repository.repository[r.name].name
        key_prefix = ref.key_prefix
        target_url_template = ref.target_url_template
        is_alphanumeric = coalesce(ref.is_alphanumeric, true)
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
    key_prefix = string
    target_url_template = string
    is_alphanumeric = optional(bool)
  }))
  default = []  
}