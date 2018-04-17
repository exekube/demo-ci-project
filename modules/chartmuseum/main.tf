terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}
variable "domain_name" {}

module "chartmuseum" {
  source           = "/exekube-modules/helm-release-v2"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "chartmuseum"
  release_namespace = "default"
  domain_name       = "${var.domain_name}"

  chart_repo    = "stable"
  chart_name    = "chartmuseum"
  chart_version = " 1.2.0"

  ingress_basic_auth = {
    secret_name = "chartrepo-htpasswd"
    username    = "${var.secrets_dir}/default/chartmuseum/basic-auth-username"
    password    = "${var.secrets_dir}/default/chartmuseum/basic-auth-password"
  }
}
