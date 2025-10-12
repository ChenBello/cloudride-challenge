data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket         = "terraform-states-chenbello-cloudride-test"
    key            = "network/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks-chenbello-cloudride-test"
  }
}

module "aws-alb-ecs" {
  source          = "../../../modules/aws-alb-ecs"
  vpc_id          = data.terraform_remote_state.network.outputs.vpc_id
  region          = var.region          # "eu-west-1"
  app_name        = var.app_name        # example: "pokemon"
  container_port  = var.container_port  # 5000
  container_image = var.container_image # "chenbello3/pokemon-flask-app:latest"

  public_subnet_ids  = data.terraform_remote_state.network.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids

  public_subnet_1_id  = data.terraform_remote_state.network.outputs.public_subnet_ids[0]  # public_subnet_1_id
  public_subnet_2_id  = data.terraform_remote_state.network.outputs.public_subnet_ids[1]  # public_subnet_2_id
  private_subnet_1_id = data.terraform_remote_state.network.outputs.private_subnet_ids[0] # private_subnet_1_id
  private_subnet_2_id = data.terraform_remote_state.network.outputs.private_subnet_ids[1] # # private_subnet_2_id

  alert_email = var.alert_email
}
