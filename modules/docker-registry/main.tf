terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}
variable "domain_name" {}

module "docker_registry" {
  source           = "/exekube-modules/helm-release-v2"
  tiller_namespace = "default"
  client_auth      = "${var.secrets_dir}/default/helm-tls"

  release_name      = "docker-registry"
  release_namespace = "default"
  domain_name       = "${var.domain_name}"

  chart_repo    = "stable"
  chart_name    = "docker-registry"
  chart_version = "1.1.2"

  ingress_basic_auth = {
    secret_name = "docker-htpasswd"
    username    = "${var.secrets_dir}/default/docker-registry/basic-auth-username"
    password    = "${var.secrets_dir}/default/docker-registry/basic-auth-password"
  }
}

# ------------------------------------------------------------------------------
# Create an imagePullSecret
# ------------------------------------------------------------------------------

locals {
  username = "${chomp(file("${var.secrets_dir}/default/docker-registry/basic-auth-username"))}"
  password = "${chomp(file("${var.secrets_dir}/default/docker-registry/basic-auth-password"))}"
}

provider "kubernetes" {}

resource "kubernetes_secret" "dockercfg" {
  metadata {
    name = "registry-secret"
  }

  type = "kubernetes.io/dockercfg"

  data {
    ".dockercfg" = <<EOF
{"${var.domain_name}:443":{"username":"${local.username}","password":"${local.password}","email":"","auth":"${base64encode(format("%s:%s", local.username, local.password))}"}}
EOF
  }
}
