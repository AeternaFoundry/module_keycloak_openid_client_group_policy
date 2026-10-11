resource "keycloak_openid_client_group_policy" "openid_client_group_policies" {
  for_each = var.openid_client_group_policies

  decision_strategy  = each.value.decision_strategy
  name               = each.value.name
  realm_id           = each.value.realm_id
  resource_server_id = each.value.resource_server_id
  description        = each.value.description
  groups_claim       = each.value.groups_claim
  logic              = each.value.logic

  dynamic "groups" {
    for_each = each.value.groups
    content {
      extend_children = groups.value.extend_children
      id              = groups.value.id
      path            = groups.value.path
    }
  }
}

