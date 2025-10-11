
terraform {
  backend "s3" {
    bucket         = "terraform-states-chenbello-cloudride-test"
    key            = "network/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks-chenbello-cloudride-test"
  }
}
