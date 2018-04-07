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
  tiller_namespace = "default"
  namespace        = "default"

  domain_name   = "registry.flexeption.pw"
  release_name  = "docker-registry"
  chart_repo    = "stable"
  chart_name    = "docker-registry"
  chart_version = "1.0.5"
}

ingress_basic_auth = {
  secret_name = "registry-htpasswd"
  username    = "default/docker-registry/basic-auth-username"
  password    = "default/docker-registry/basic-auth-password"
}
