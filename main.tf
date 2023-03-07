provider "github" {
}

terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.16.0"
    }
  }
}

module "repositories" {
  source = "./repositories"
  default_topics = [ "ksad", "asdasd" ]
  default_autolink_references = [ {
    is_alphanumeric = false
    key_prefix = "TICKET-"
    target_url_template = "https://example.com/TICKET?query=<num>"
  } ]
  default_branch_protections = {
    "release-*" = {
      required_linear_history = false
    }
  }
  repository = [{
    name = "my-repo"
    description = "my new repo"
    default_branch_name = "main"
    delete_branch_on_merge = true
  },
  {
    name = "enzo"
    description = "second repo"
    default_branch_name = "master"
    delete_branch_on_merge = false
  }
  ]
}







# module "repositories" {
#   source = "./repositories"
#   default_topics = [ "test" ]
#   default_autolink_references = [{
#     key_prefix = "SYS-",
#     target_url_template = "https://example.com/TICKET?query=<num>"
#     is_alphanumeric = false
#   }]
#   default_branch_protections = {
#     master = {
#       allows_deletions = true
#       enforce_admins = true
#       required_linear_history = true
#       required_status_checks = {
#         strict = false
#         contexts = ["test"]
#       }
#     }
#   }
#   repository = [
#     {
#       name = "terraform-test"
#       default_branch = "stage"
#       topics = ["test-01"]
#       autolink_references = [{
#         key_prefix = "SYS-",
#         target_url_template = "https://example.com/TICKET?query=<num>"
#         is_alphanumeric = false
#       }]
#       branch_protections = {
#         dev = {
#           required_linear_history = true
#         }
#       }
#     },
#     {
#       name = "terraform_test_02"
#       default_branch = "dev"
#       topics = ["test-02"]
#       autolink_refrences = [{
#         key_prefix = "SYS-",
#         target_url_template = "https://example.com/TICKET?query=<num>"
#         is_alphanumeric = false
#       }]
#     }
#   ]
# }


# module "repositories" {
#   source                       = "./repositories"
#   default_topics               = [ "test" ]
#   default_autolink_references  = [{
#     key_prefix                = "SYS-",
#     target_url_template       = "https://example.com/TICKET?query=<num>"
#     is_alphanumeric          = false
#   }]
#   default_branch_protections  = {
#     master = {
#       allows_deletions       = true
#       enforce_admins         = true
#       required_linear_history = true
#       required_status_checks = {
#         strict               = false
#         contexts             = ["test"]
#       }
#     }
#   }
#   repository                   = [
#     {
#       name                    = "terraform-test"
#       default_branch_name = "dev"
#       topics                  = ["test-01"]
#       autolink_references     = [{
#         key_prefix            = "SYS-",
#         target_url_template   = "https://example.com/TICKET?query=<num>"
#         is_alphanumeric      = false
#       }]
#       branch_protections      = {
#         dev                   = {
#           required_linear_history = true
#           }
#         }
#     },
#     {
#       name                    = "terraform_test_02"
#       default_branch_name = "stage"
#       autolink_references     = [{
#         key_prefix            = "SYS-",
#         target_url_template   = "https://example.com/TICKET?query=<num>"
#         is_alphanumeric      = false
#       }]
#     }
#   ]
# }





#       }]
#     },
#     {
#       name = "terraform_test_02"
#       topics = ["test-02"]
#       delete_branch_on_merge = true
#       autolink_references = [{
#         key_prefix = "SYSa-",
#         target_url_template = "https://example.com/TICKET?query=<num>",
#         is_alphanumeric = false
#       branch_protections = {
#         main = {
#           allows_deletions = true
#           enforce_admins = true
#           required_linear_history = true
#           required_pull_request_reviews = null
#           required_status_checks = null
#           pattern = "main"
#   }
# }
#       }]
#     }
#   ]
# }
