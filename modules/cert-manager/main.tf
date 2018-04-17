terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

# cert-manager Helm release
module "cert_manager" {
  source           = "/exekube-modules/helm-release-v2"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "cert-manager"
  release_namespace = "kube-system"

  chart_repo    = "stable"
  chart_name    = "cert-manager"
  chart_version = "0.2.8"
}

# cert-manager issuers
resource "null_resource" "cert_manager_resources" {
  depends_on = ["module.cert_manager"]

  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/resources/"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "kubectl delete -f ${path.module}/resources/"
  }
}
