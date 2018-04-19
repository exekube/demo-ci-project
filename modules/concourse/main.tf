terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}
variable "domain_name" {}

module "concourse" {
  source = "/exekube-modules/helm-release-v2"

  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "concourse"
  release_namespace = "default"
  domain_name       = "${var.domain_name}"

  chart_repo    = "stable"
  chart_name    = "concourse"
  chart_version = "1.3.0"

  # These secrets will be created before installing the chart
  kubernetes_yaml = [
    "${var.secrets_dir}/default/concourse.yaml",
  ]
}
