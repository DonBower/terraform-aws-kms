output keyAlias {
  description       = "The Alias of the KMS Key as seen in the AWS Console."
  value             = aws_kms_alias.thisKey.name  
}

output keyPolicy {
  value             = jsondecode(aws_kms_key.thisKey.policy)
}