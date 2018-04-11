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
  enabled          = false
  tiller_namespace = "kube-system"
  namespace        = "default"
  release_name     = "chartmuseum"

  chart_repo    = "stable"
  chart_name    = "chartmuseum"
  chart_version = "1.2.0"
  domain_name   = "charts.flexeption.pw"
}

post_hook = {
  command = "sleep 60"
}

ingress_basic_auth = {
  secret_name = "chartrepo-htpasswd"
  username    = "default/chartmuseum/basic-auth-username"
  password    = "default/chartmuseum/basic-auth-password"
}
