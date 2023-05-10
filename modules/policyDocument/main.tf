variable policyId {}
variable policies {
  # type = map(object())
}
data aws_iam_policy_document thisPolicy {
  policy_id                             = var.policyId
  dynamic statement {
    for_each                            = var.policies
    content {
      sid                               = statement.key
      effect                            = statement.value["Effect"]
      actions                           = try(statement.value["Actions"], [])
      not_actions                       = try(statement.value["NotActions"], [])
      dynamic principals {
        for_each                        = try(statement.value["Principals"], {})
        content {
          type                          = principals.value["Type"]
          identifiers                   = principals.value["Identifiers"]
        }
      }
      dynamic not_principals {
        for_each                        = try(statement.value["NotPrincipals"], {})
        content {
          type                          = not_principals.value["Type"]
          identifiers                   = not_principals.value["Identifiers"]
        }
      }
      resources                         = try(statement.value["Resources"], [])
      not_resources                     = try(statement.value["NotResources"], [])
      dynamic condition {
        for_each                        = try(statement.value["Conditions"], {})
        content {
          test                          = condition.value["Test"]
          variable                      = condition.value["Variable"]
          values                        = condition.value["Values"]
        }
      }
    }
  }
}
output policyDocument {
  value = data.aws_iam_policy_document.thisPolicy.json
}