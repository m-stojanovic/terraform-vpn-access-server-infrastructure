aws_account_id                = ""
product_name                  = "devops"
product_env                   = "dev"
aws_region                    = "us-east-1"
vpc_id                        = "vpc-0da6da380e01aadca"
instance_type                 = "t2.small"
volume_size                   = 8
volume_type                   = "gp3"
marketplace_access_server_ami = "ami-0bd9errad0a812dc"


tags = {
  "TechnicalProvisioner" = "terraform"
  "Environment"          = "dev"
  "Owner"                = "devops"
  "CreatedBy"            = "devops"
  "DataClassification"   = "public"
  "TechnicalFunction"    = "vpn"
}