# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//gke-network"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

dns_zones = {
  ci-exekube-us = "ci.exekube.us."
}

dns_records = {
  ci-exekube-us = "*.ci.exekube.us."
}
