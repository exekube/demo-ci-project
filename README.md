# Demo Exekube Project: demo-ci-project

An example cloud project built with the [Exekube framework](https://github.com/exekube/exekube)

> :warning:
> This is a work in progress
> :warning:

The exekube/demo-ci-project contains configuration for deploying a Kubernetes cluster onto the Google Cloud Platform (GCP), as well as Kubernetes resources (via Helm charts) that result in this software released into the cloud:

- A self-hosted CI / CD service (<https://concourse-ci.org>)
- A private Docker Registry (https://docs.docker.com/registry)
- A private ChartMuseum repository for hosting Helm charts (https://github.com/kubernetes-helm/chartmuseum)

## Project structure

The `live` directory contains configuration for every environment (dev, stg, prod) for this product.

```sh
├── live/
│   ├── dev/
│   ├── stg/
│   ├── prod/
│   ├── .env # Common TF_VARs -- variables shared by multiple modules
│   └── terraform.tfvars # Terraform / Terragrunt config for modules (e.g. remote state config)
```

Every environment (dev, stg, test, prod, etc.) directory is further broken down into directories that contain resources (cloud resources) of these categories:

```sh
live/
├── dev/
│   ├── project/
│   ├── kubernetes/
│   ├── secrets/
│   ├── .env
│   └── ci.yaml # ci.yaml contains Concourse pipelines manifest
├── stg/
│   ├── project/
│   ├── kubernetes/
│   ├── secrets/
│   ├── .env
│   └── ci.yaml
├── prod/
│   ...
```

| Configuration types for every environment | What's in there? |
| --- | --- |
| `project` | ☁️ Cloud provider resources, e.g. network, subnets, firewall rules, DNS |
| `kubernetes` | ☸️ kube-api resources (via Helm releases) -- workloads, config, storage, and networking Kubernetes resources |
| `secrets` | 🔐 Secrets specific to this environment, stored and distributed in GCS (Cloud Storage) buckets and encrypted by Google Cloud KMS encryption keys |
| `.env` | 🔩 Environment-specific variables common to several modules |


... to be continued ...
