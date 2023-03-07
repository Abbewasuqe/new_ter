resource "github_repository_tag_protection" "example" {
  for_each   = { for r in var.repository : r.name => r }
  repository = each.value.name
  pattern    = "v*"
}
