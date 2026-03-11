locals {
  default_branch = "master"
}

data "forgejo_user" "user" {
  login = var.user_name
}

resource "forgejo_ssh_key" "ssh_key" {
  for_each = {
    for ssh_key in var.ssh_keys : ssh_key.name => ssh_key.key
  }

  title = each.key
  key   = each.value
  user  = var.user_name
}

resource "forgejo_repository" "personal_repo" {
  for_each = {
    for repo in var.personal_repo : "${repo.user == null ? var.user_name : repo.user}-${repo.name}" => repo
  }

  name           = each.key
  description    = each.value.description
  default_branch = local.default_branch
  owner          = each.value.user == null ? var.user_name : each.value.user
  private        = each.value.private

  has_issues        = false
  has_pull_requests = false
}

resource "forgejo_repository_action_secret" "personal_repo_secret" {
  for_each = {
    for it in flatten([
      for repo in var.personal_repo : [
        for key, value in repo.secrets : {
          repo_name = repo.name
          repo_user = repo.user == null ? var.user_name : repo.user
          name      = key
          secret    = value
        }
      ]
    ]) : "${it.repo_user}-${it.repo_name}-${it.name}" => it
  }

  data          = each.value.secret
  name          = each.value.name
  repository_id = forgejo_repository.personal_repo["${each.value.repo_user}-${each.value.repo_name}"].id
}
