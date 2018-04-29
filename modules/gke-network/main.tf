# ------------------------------------------------------------------------------
# INPUT VARIABLES
# ------------------------------------------------------------------------------

variable "project_id" {}
variable "serviceaccount_key" {}

variable "dns_zones" {
  default = {}
}

variable "dns_records" {
  default = {}
}

# ------------------------------------------------------------------------------
# TERRAFORM AND PROVIDER CONFIG
# ------------------------------------------------------------------------------

terraform {
  backend "gcs" {}
}

provider "google" {
  project     = "${var.project_id}"
  credentials = "${var.serviceaccount_key}"
}

# ------------------------------------------------------------------------------
# RESOURCES AND EXTERNAL MODULE IMPORTS
# ------------------------------------------------------------------------------

module "gke_network" {
  source = "/exekube-modules/gke-network"

  cluster_subnets = {
    "0" = "europe-west1,10.16.0.0/20,10.17.0.0/16,10.18.0.0/16"
  }

  # Uncomment to create a static IP address for nginx-ingress and DNS records for it
  # create_static_ip_address = false

  dns_zones   = "${var.dns_zones}"
  dns_records = "${var.dns_records}"
}

# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

# output "static_ip_address" {
#   value = "${module.gke_network.static_ip_address}"
# }

output "dns_zones" {
  value = "${module.gke_network.dns_zones}"
}

output "dns_zone_servers" {
  value = "${module.gke_network.dns_zone_servers}"
}
