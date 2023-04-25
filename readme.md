## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 5.18.3 |

## Resources

| Name | Type |
|------|------|
| [github_actions_organization_secret.organisation_environment_secret](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_secret) | resource |
| [github_actions_organization_variable.organisation_environment_variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable) | resource |
| [github_actions_secret.environment_secret](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret) | resource |
| [github_actions_variable.environment_variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_branch_default.default_branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.branch_protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_issue_label.issue_label](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_autolink_reference.repository_autolink_reference](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_autolink_reference) | resource |
| [github_repository_tag_protection.tag_protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_tag_protection) | resource |
| [github_team.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team_membership.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership) | resource |
| [github_team_repository.team_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_autolink_references"></a> [default\_autolink\_references](#input\_default\_autolink\_references) | The default autolink_references to apply to each repository. | <pre>list(object({<br>    key_prefix          = string<br>    target_url_template = string<br>    is_alphanumeric     = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_default_branch_name"></a> [default\_branch\_name](#input\_default\_branch\_name) | The default default_branch_name to apply to each repository. | `string` | `"main"` | no |
| <a name="input_default_branch_protections"></a> [default\_branch\_protections](#input\_default\_branch\_protections) | The default_branch_protections to apply to each repository. | <pre>map(object({<br>    allows_deletions        = optional(bool)<br>    enforce_admins          = optional(bool)<br>    required_linear_history = optional(bool)<br>    required_pull_request_reviews = optional(object({<br>      dismiss_stale_reviews           = optional(bool)<br>      require_code_owner_reviews      = optional(bool)<br>      required_approving_review_count = optional(number)<br>    }))<br>    required_status_checks = optional(object({<br>      contexts = optional(list(string))<br>      strict   = optional(bool)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_default_maintainer_enabled"></a> [default\_maintainer\_enabled](#input\_default\_maintainer\_enabled) | (Optional) If true, adds the creating user as a default maintainer to the team. | `bool` | `false` | no |
| <a name="input_default_topics"></a> [default\_topics](#input\_default\_topics) | The default topics to apply to each repository. | `list(string)` | `[]` | no |
| <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge) | (optional) Automatically dele head breanch after pull request | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the repo. | `string` | `"Managed by Terraform."` | no |
| <a name="input_is_secret"></a> [is\_secret](#input\_is\_secret) | (Optional) If true, team is only visible to the people on the team and people with owner permissions. | `bool` | `false` | no |
| <a name="input_ldap_group_dn"></a> [ldap\_group\_dn](#input\_ldap\_group\_dn) | (Optional) The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise Server. | `string` | `null` | no |
| <a name="input_maintainers"></a> [maintainers](#input\_maintainers) | (Optional) A list of usernames to add users as `maintainer` role. When applied, the user will become a maintainer of the team. | `set(string)` | `[]` | no |
| <a name="input_members"></a> [members](#input\_members) | members of a team | `map(map(string))` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the team. | `string` | n/a | yes |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | (Optional) The ID of the parent team, if this is a nested team. | `string` | `null` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | List of objects containing the repository definitions. Parameter 'name' is mandatory. | <pre>list(object({<br>    name                = string<br>    default_branch_name = optional(string)<br>    topics              = optional(list(string))<br>    organisation_environment_variable = optional(list(object({<br>      secret_name          = optional(string)<br>      visibility = optional(string)<br>      selected_repository_ids = optional(list(string))<br>      value = optional(string)<br>    })))<br>    organisation_secrets = optional(list(object({<br>      secret_name          = optional(string)<br>      encrypted_value = optional(string)<br>      visibility = optional(string)<br>      selected_repository_ids = optional(list(string))<br>      plaintext_value  = optional(string)<br>    })))<br>    secrets = optional(list(object({<br>      secret_name          = string<br>      plaintext_value  = string<br>    })))<br>    environment_variables = optional(list(object({<br>      variable_name          = string<br>      value  = string<br>    })))<br>    issue_labels = optional(list(object({<br>      name = string<br>      color = string<br>    })))<br>    tag_protections = optional(list(object({<br>      pattern = string<br>    })))<br>    autolink_references = optional(list(object({<br>      key_prefix          = string<br>      target_url_template = string<br>      is_alphanumeric     = bool<br>    })))<br>    branch_protections = optional(map(object({<br>      allows_deletions        = optional(bool)<br>      required_linear_history = optional(bool)<br>      enforce_admins          = optional(bool)<br>      required_pull_request_reviews = optional(object({<br>        dismiss_stale_reviews           = optional(bool)<br>        require_code_owner_reviews      = optional(bool)<br>        required_approving_review_count = optional(number)<br>      }))<br>      required_status_checks = optional(object({<br>        contexts = optional(list(string))<br>        strict   = optional(bool)<br>      }))<br>      delete_branch_on_merge = optional(bool)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_team_permissions"></a> [team\_permissions](#input\_team\_permissions) | Team repositories | <pre>list(object({<br>    repository = string<br>    team_name  = string<br>    permission = string<br>  }))</pre> | `[]` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | (Optional) Can be 'public', 'private' or 'internal' | `string` | `"private"` | no |
