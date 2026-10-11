variable "openid_client_group_policies" {
  description = <<EOT
Map of openid_client_group_policies, attributes below
Required:
    - decision_strategy
    - name
    - realm_id
    - resource_server_id
    - groups (block):
        - extend_children (required)
        - id (required)
        - path (required)
Optional:
    - description
    - groups_claim
    - logic
EOT

  type = map(object({
    decision_strategy  = string
    name               = string
    realm_id           = string
    resource_server_id = string
    description        = optional(string)
    groups_claim       = optional(string)
    logic              = optional(string)
    groups = list(object({
      extend_children = bool
      id              = string
      path            = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.openid_client_group_policies : (
        length(v.groups) >= 1
      )
    ])
    error_message = "Each groups list must contain at least 1 items"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

