locals {
  thisKey = {
    keyAlias                  = join("/", ["alias", var.keyAlias])
    keyDescription            = var.keyDescription
    keyUsage                  = contains(
        [
          "ENCRYPT_DECRYPT", 
          "SIGN_VERIFY", 
          "GENERATE_VERIFY_MAC"
        ], 
        var.keyUsage
      ) ? var.keyUsage : "ENCRYPT_DECRYPT"
    keyCustomerSpec           = contains(
      [
        "SYMMETRIC_DEFAULT", 
        "RSA_2048", 
        "RSA_3072", 
        "RSA_4096", 
        "HMAC_256", 
        "ECC_NIST_P256", 
        "ECC_NIST_P384", 
        "ECC_NIST_P521",
        "ECC_SECG_P256K1"
      ],
      var.keyCustomerSpec
    ) ? var.keyCustomerSpec : "SYMMETRIC_DEFAULT"
    keyMultiRegion            = false
    # keyCustomStoreID is not used at this time.
    # (Optional) ID of the KMS Custom Key Store where the key will be stored instead of KMS (eg CloudHSM).
    keyCustomStoreID          = null
    keyDeletionWindow         = null
  }

  thisPolicyId                = "key-consolepolicy-3"
  thesePolicies               = {
    "Enable IAM User Permissions" = {
      Effect                  = "Allow"
      Actions                 = ["kms:*"]
      Principals              = {
        "RootAccount"         = {
          Type                = "AWS"
          Identifiers         = [
            "arn:aws:iam::581698278165:root"
          ]
        }
      },
      Resources               = [
        "*"
      ]
    },
    "Allow access for Key Administrators" = {
      Effect                  = "Allow"
      Actions                 = [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
      ],
      Principals              = {
        "SvcAccount"          = {
          Type                = "AWS"
          Identifiers         = [
            "arn:aws:iam::581698278165:user/svcacnt-ag6hq-terraform"
          ]
        }
      },
      Resources               = [
        "*"
      ]
    },
    "Allow use of the key"    = {
      Effect                  = "Allow"
      Actions                 = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:DescribeKey",
        "kms:GetPublicKey"
      ],
      Principals              = {
        "SvcAccount"          = {
          Type                = "AWS"
          Identifiers         = [
            "arn:aws:iam::581698278165:user/svcacnt-ag6hq-terraform"
          ]
        }
      },
      Resources               = [
        "*"
      ]
    },
    "Allow attachment of persistent resources" = {
      Effect                  = "Allow"
      Actions                 = [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ],
      Principals              = {
        "SvcAccount"          = {
          Type                = "AWS"
          Identifiers         = [
            "arn:aws:iam::581698278165:user/svcacnt-ag6hq-terraform"
          ]
        }
      },
      Resources               = [
        "*"
      ]
      Conditions              = {
        "IsAWSResource"       = {
          Test                = "Bool"
          Variable            = "kms:GrantIsForAWSResource"
          Values              = [
            "true"
            ]
        }
      }
    }
  }
}