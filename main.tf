module thisKeyPolicy {
  source  = "app.terraform.io/ag6hq/policy/aws"
  version = "0.1.0-rc1"
  policyId                              = local.thisKey.keyPolicyId
  policyStatement                       = local.thisKey.keyPolicies
}

resource aws_kms_key thisKey {
  description                           = local.thisKey.keyDescription
  key_usage                             = local.thisKey.keyUsage
  custom_key_store_id                   = local.thisKey.keyCustomStoreID
  deletion_window_in_days               = local.thisKey.keyDeletionWindow
  customer_master_key_spec              = local.thisKey.keyCustomerSpec
  multi_region                          = local.thisKey.keyMultiRegion
  policy                                = module.thisKeyPolicy.policyDocument
  bypass_policy_lockout_safety_check    = local.thisKey.keyLockoutSafetyCheck
  is_enabled                            = local.thisKey.keyIsEnabled
  enable_key_rotation                   = local.thisKey.keyRotationIsEnabled

  tags                                  = merge(
    var.theseTags,
    tomap({
      "Name"                            = local.thisKey.keyAlias
    })
  )
}

resource aws_kms_alias thisKey {
  name                                  = local.thisKey.keyAlias
  target_key_id                         = aws_kms_key.thisKey.key_id
}

locals {

}