variable keyDescription {
  description = "A Description of the KMS Key"
  type        = string
}

variable keyAlias {
  description = "This is the Alias as it appears in the AWS Console"
  type        = string
  default     = "kms-key"
}

variable keyUsage {
  description = "This Usage for the key, one of 'ENCRYPT_DECRYPT', 'SIGN_VERIFY', 'GENERATE_VERIFY_MAC'"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable keyCustomerSpec {
  description = "Algorithm for the key, see Hasicorp for list."
  type        = string
  default     = "RSA_4096"
}

variable theseTags {
  description = "Map of additional AWS Tags in `{key = \"value\"}` format."
  type        = map
  default     = {}
}

variable awsRegion {
  description = "AWS Region to create keypair in."
  type        = string
  default     = "us-east-1"
}