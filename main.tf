terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

variable "container_name" {
  type = string
  default = "hospital-web"
}

variable "web_port" {
  type = number
  default = 8085
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "hospital-web"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8086
  }
}

output "url" {
  value = "http://localhost:${var.web_port}"
}

output "container_id" {
  value = docker_container.web.id
}
