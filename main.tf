module thisKeyPolicy {
  source                                = "./modules/policyDocument"
  policyId                              = local.thisPolicyId
  policies                              = local.thesePolicies
}

resource aws_kms_key thisKey {
  description                           = local.thisKey.keyDescription
  key_usage                             = local.thisKey.keyUsage
  custom_key_store_id                   = local.thisKey.keyCustomStoreID
  deletion_window_in_days               = local.thisKey.keyDeletionWindow
  customer_master_key_spec              = local.thisKey.keyCustomerSpec
  multi_region                          = local.thisKey.keyMultiRegion
  policy                                = module.thisKeyPolicy.policyDocument

  #  - (Optional) Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, HMAC_256, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT. For help with choosing a key spec, see the AWS KMS Developer Guide.
/*
policy - (Optional) A valid policy JSON document. Although this is a key policy, not an IAM policy, an aws_iam_policy_document, in the form that designates a principal, can be used. For more information about building policy documents with Terraform, see the AWS IAM Policy Document Guide.
NOTE:
Note: All KMS keys must have a key policy. If a key policy is not specified, AWS gives the KMS key a default key policy that gives all principals in the owning account unlimited access to all KMS operations for the key. This default key policy effectively delegates all access control to IAM policies and KMS grants.
bypass_policy_lockout_safety_check - (Optional) A flag to indicate whether to bypass the key policy lockout safety check. Setting this value to true increases the risk that the KMS key becomes unmanageable. Do not set this value to true indiscriminately. For more information, refer to the scenario in the Default Key Policy section in the AWS Key Management Service Developer Guide. The default value is false.
deletion_window_in_days - (Optional) The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30. If the KMS key is a multi-Region primary key with replicas, the waiting period begins when the last of its replica keys is deleted. Otherwise, the waiting period begins immediately.
is_enabled - (Optional) Specifies whether the key is enabled. Defaults to true.
enable_key_rotation - (Optional) Specifies whether key rotation is enabled. Defaults to false.
*/
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