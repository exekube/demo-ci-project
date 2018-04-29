# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//chartmuseum"
  }

  dependencies {
    paths = [
      "../../kube-system/nginx-ingress",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

domain_name = "dev.charts.ci.exekube.us"
