terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}
variable "domain_name" {}

module "chartmuseum" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "chartmuseum"
  release_namespace = "default"
  domain_name       = "${var.domain_name}"

  chart_repo    = "stable"
  chart_name    = "chartmuseum"
  chart_version = "1.3.0"

  ingress_basic_auth = {
    secret_name = "chartrepo-htpasswd"
    username    = "${var.secrets_dir}/default/chartmuseum/basic-auth-username"
    password    = "${var.secrets_dir}/default/chartmuseum/basic-auth-password"
  }
}

# ------------------------------------------------------------------------------
# Add the chartmuseum Helm repo as "private"
# ------------------------------------------------------------------------------


# provider "helm" {}
#
# locals {
#   username = "${chomp(file("${var.secrets_dir}/default/chartmuseum/basic-auth-username"))}"
#   password = "${chomp(file("${var.secrets_dir}/default/chartmuseum/basic-auth-password"))}"
# }
#
# resource "helm_repository" "exekube" {
#   depends_on = ["module.chartmuseum"]
#   name       = "private"
#   url        = "https://${local.username}:${local.password}@${var.domain_name}"
#
#   provisioner "local-exec" {
#     command = "helm repo update"
#   }
# }

