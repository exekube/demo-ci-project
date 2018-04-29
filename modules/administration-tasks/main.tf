terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

module "administration_tasks" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "administration-tasks"
  release_namespace = "kube-system"

  chart_repo    = "${helm_repository.exekube.name}"
  chart_name    = "administration-tasks"
  chart_version = "0.3.1"
}

provider "helm" {}

resource "helm_repository" "exekube" {
  name = "exekube"
  url  = "https://exekube.github.io/charts"

  provisioner "local-exec" {
    command = "helm repo update"
  }
}
