module kms {
  source                                = "../"
  keyAlias                              = "terraform-aws-kms"
  keyDescription                        = "KMS Key for testing module terraform-aws-kms"
  
  theseTags                             = tomap(
    {
      "Name"                            = "terraform-aws-kms", 
      "thisHost"                        = "macbookpro.ag6hq.net"
    }
  )
}
