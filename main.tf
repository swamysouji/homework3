terraform {
    required_version = ">= 1.7.2"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Build the Docker image from the local Dockerfile
resource "docker_image" "dummy_serv" {
  name = "dummy_serv"
  keep_locally = false
  build {
    context    = path.module
    dockerfile = "${path.module}/Dockerfile"
  }
}

# Run the container from the built image
resource "docker_container" "dummy_serv_container" {
  name  = "dummy_serv_container"
  image = docker_image.dummy_serv.image_id
  ports {
    internal = 8081
    external = 8081
  }
}