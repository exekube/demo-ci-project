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

  release_name  = "cluster-admin"
  chart_repo    = "exekube"
  chart_name    = "cluster-admin"
  chart_version = "0.2.0"
}
