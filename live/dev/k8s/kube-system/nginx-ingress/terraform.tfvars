# ↓ Module metadata
terragrunt = {
  terraform {
    source = "/project/modules//nginx-ingress"
  }

  dependencies {
    paths = [
      "../administration-tasks",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

# load_balancer_ip = "35.195.185.26"

load_balancer_ip = ""
