variable "region" {
  description = "Main region for all resources"
  type        = string
}

variable "app_name" {
  type        = string
  description = "Name of the application"
  default     = "cloudride-flask-app"
}

variable "container_port" {
  type        = number
  description = "Port the container listens on"
  default     = 80
}

variable "container_image" {
  type        = string
  description = "Docker image to run"
  default     = "chenbello3/cloudride-flask-app:latest"
}

variable "alert_email" {
  description = "Email to receive alerts"
  type        = string
}

# variable "public_subnet_ids" {
#   description = "List of public subnet IDs"
#   type        = list(string)
# }

# variable "private_subnet_ids" {
#   description = "List of private subnet IDs"
#   type        = list(string)
# }

# variable "cluster_name" {
#   description = "The name of the ECS cluster."
#   type        = string
#   default     = "cloudride-app-cluster"
# }

