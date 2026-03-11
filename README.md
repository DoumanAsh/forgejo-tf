# forgejo

[![Tofu](https://github.com/DoumanAsh/forgejo-tf/actions/workflows/tofu.yaml/badge.svg)](https://github.com/DoumanAsh/forgejo-tf/actions/workflows/tofu.yaml)

Terraform setup module for personal git instance

## Requirements

Setup your initial forgejo instance and generate token with `admin` rights
Pass following variables to configure provider:

- `host` - Full URL to the root of your forgejo instance
- `api_token` - Admin token to use for auth
- `user_name` - Specifies context of user for whom action is performed by default

## SSH key

List of ssh keys can be passed via variable `ssh_keys` with following attributes:
- `name` - Unique identifier of the key
- `key` - Public ssh key in format of `ssh-<curve> <armored key> [email]`

## Repositories

### Personal repo

You can specify list of personal repositories with collaboration disabled using `personal_repo` as list of objects with following attributes:
- `name` - Unique name of repository to create
- `description` - Optional text description to attach to the repo
- `private` - Specifies whether it is private. Defaults to `true`
- `user` - Specifies name of the owner user account. Defaults to `user_name`
- `secrets` - Key value map of secrets to create for this repository. Note that secret deletion is not supported by forgejo API
