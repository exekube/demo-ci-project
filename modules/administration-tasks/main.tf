terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

module "administration_tasks" {
  source           = "/exekube-modules/helm-release-v2"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "administration-tasks"
  release_namespace = "kube-system"

  chart_repo    = "exekube"
  chart_name    = "administration-tasks"
  chart_version = "0.3.0"
}
