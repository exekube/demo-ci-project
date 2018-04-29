# ↓ Module metadata

terragrunt = {
  terraform {
    # source = "/project/modules//gcp-secret-mgmt"
    # TODO: import resorces using project-scoped Terraform module
    source = "/exekube-modules//gcp-secret-mgmt"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

# A Google Cloud Storage bucket will be created for each encryption key
encryption_keys = [
  "kube-system",
  "default",
]
