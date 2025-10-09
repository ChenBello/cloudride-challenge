# terraform.tfvars.example

# AWS region to deploy to
region = "us-east-1"

# Application name
app_name = "cloudride-challenge"

# Port the container listens on
container_port = 5000

# Full container image URI (ECR or Docker Hub)
# Example: "123456789012.dkr.ecr.us-east-1.amazonaws.com/app_name:latest"
container_image = ""
