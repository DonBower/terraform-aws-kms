module kms {
  source                                = "../"
  keyAlias                              = "terraform-aws-kms"
  keyDescription                        = "KMS Key for encrypting Marnegro Data on S3"
  
  theseTags                             = tomap(
    {
      "Name"                            = "terraform-aws-kms", 
      "thisHost"                        = "macbookpro.ag6hq.net"
    }
  )
}
