# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../_helm",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

release_spec = {
  enabled          = true
  tiller_namespace = "kube-system"
  namespace        = "kube-system"

  release_name  = "nginx-ingress"
  chart_repo    = "stable"
  chart_name    = "nginx-ingress"
  chart_version = "0.11.1"
}

# kubernetes_secrets = [
#   "kube-system/kube-lego/certs.yaml",
# ]

