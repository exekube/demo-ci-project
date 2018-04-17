terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

module "cluster_admin" {
  source           = "/exekube-modules/helm-release-v2"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "cluster-admin"
  release_namespace = "kube-system"

  chart_repo    = "exekube"
  chart_name    = "cluster-admin"
  chart_version = "0.2.0"
}
