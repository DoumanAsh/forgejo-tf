variable "host" {
  description = "Forgejo API host"
  type        = string
}

variable "api_token" {
  description = "Forgejo API key"
  type        = string
  sensitive   = true
}

variable "user_name" {
  description = "Your account user name"
  type        = string
}

variable "ssh_keys" {
  description = "List of SSH keys to register with name being unique identifier of the provided public key"
  type = list(object({
    name = string,
    key  = string
  }))
  default = []
}

variable "personal_repo" {
  description = "List of repositories to create for personal use. All collaboration elements are disabled"
  type = list(object({
    name        = string,
    description = optional(string, null)
    private     = optional(bool, true)
    user        = optional(string, null)
    secrets     = optional(map(string), {})
  }))
  default = []
}
