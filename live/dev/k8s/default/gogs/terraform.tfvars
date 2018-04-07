# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../_helm",
      "../../kube-system/nginx-ingress",
      "../../kube-system/kube-lego",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

release_spec = {
  enabled          = true
  tiller_namespace = "default"
  namespace        = "default"

  release_name  = "gogs"
  chart_repo    = "incubator"
  chart_name    = "gogs"
  chart_version = "0.5.2"

  domain_name = "git.flexeption.pw"
}
