provider "aws" {
  region = var.region # "eu-west-1"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "Dev"
      Application = "Cloudride Challenge ECS-Fargate"
    }
  }
}