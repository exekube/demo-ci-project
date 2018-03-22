# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../../cluster",
      "../../system/ingress-controller",
      "../../system/kube-lego",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration

custom_tls_dir = "system"

release_spec = {
  enabled      = false
  release_name = "rails-app"

  chart_repo = "exekube"
  chart_name = "rails-app"

  domain_name = "prod.rails-app.flexeption.pw"
}
