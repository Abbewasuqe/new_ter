provider "github" {
}

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.16.0"
    }
  }
}

module "repositories" {
  source         = "./repositories"
  default_topics = ["ksad", "asdasd"]
  default_autolink_references = [{
    is_alphanumeric     = false
    key_prefix          = "TICKET-"
    target_url_template = "https://example.com/TICKET?query=<num>"
  }]
  default_branch_protections = {
    "release-*" = {
      required_linear_history = false
    }
  }
  repository = [
    {
          name                   = "my-repo"
          description            = "my new repo"
          default_branch_name    = "main"
          delete_branch_on_merge = true
    },
    {
      name                   = "enzo"
      description            = "second repo"
      default_branch_name    = "master"
      delete_branch_on_merge = false
    },
    {
      name                   = "test"
      description            = "test"
      default_branch_name    = "main"
      delete_branch_on_merge = true
    }
  ]
}
