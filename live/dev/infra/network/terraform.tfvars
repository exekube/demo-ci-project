# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//gke-network"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

dns_zones = {
  "flexeption-pw" = "flexeption.pw."
  "flexeption-us" = "flexeption.us."
}

dns_records = {
  "flexeption-pw" = "*.flexeption.pw."
  "flexeption-us" = "*.flexeption.us."
}
