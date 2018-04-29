terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}

# Install Tiller in kube-system namespace with cluster-admin permissions
#   for all namespaces
module "system_tiller" {
  source = "/exekube-modules/helm-initializer"

  secrets_dir = "${var.secrets_dir}"
}

# Install Tiller in default namespace with cluster-admin permissions
#   only for the namespace
module "default_tiller" {
  source = "/exekube-modules/helm-initializer"

  secrets_dir      = "${var.secrets_dir}"
  tiller_namespace = "default"
}
