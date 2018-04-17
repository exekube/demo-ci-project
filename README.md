# demo-ci-project

This is a demo project built with the [Exekube framework](https://github.com/exekube/exekube)

> :warning:
>
> This is a work in progress
>
> :warning:

---

If you are new to Exekube, follow the *Getting Started Tutorial* at https://exekube.github.io/exekube/in-practice/getting-started

## What we're building

Our goal is to create a production-like GKE cluster, then deploy these applications onto it:

- Concourse server (CI service)
- Docker Registry v2 (Docker image registry)
- ChartMuseum (Helm chart repository)

## How to configure the project

To get this working, you'll need to:

1. Set the *GCP project* name base in `docker-compose.yaml`:
    ```yaml
    TF_VAR_project_id: ${ENV:?err}-demo-apps-296e23
    ```
2. Configure project-scoped modules in the `modules` directory: all settings that will be *the same across all environments of the project*.
3. Configure module imports for the *dev* environment in the `live/dev` directory. We use [Terragrunt](/) to do module imports for us.

## Project structure

### Project modules

```sh
modules/
├── gcp-secret-mgmt   # Cloud KMS cryptokeys + GCS storage buckets for secrets
├── gke-network       # Networking module for the cluster
├── gke-cluster       # GKE cluster module
├── helm-initializer  # Install Tiller in kube-system and default namespaces
├── cluster-admin     # exekube/cluster-admin Helm release
├── cert-manager      # stable/cert-manager Helm release
├── nginx-ingress     # stable/nginx-ingress Helm release
└── concourse         # stable/concourse Helm release
```

### Project environments

```sh
live/
├── dev
│   ├── infra
│   │   ├── network
│   │   │   └── terraform.tfvars
│   │   └── secret-mgmt
│   │       ├── permissions.tf
│   │       └── terraform.tfvars
│   ├── k8s
│   │   ├── cluster
│   │   │   └── terraform.tfvars
│   │   ├── default
│   │   │   └── bookinfo
│   │   │       └── terraform.tfvars
│   │   ├── istio-system
│   │   │   └── istio
│   │   │       └── terraform.tfvars
│   │   └── kube-system
│   │       ├── cert-manager
│   │       │   ├── resources
│   │       │   │   └── certs.yaml
│   │       │   └── terraform.tfvars
│   │       ├── cluster-admin
│   │       │   └── terraform.tfvars
│   │       └── helm-initializer
│   │           └── terraform.tfvars
│   └── secrets
│       ├── default
│       │   └── helm-tls
│       └── kube-system
│           ├── helm-tls
│           └── owner.json
├── stg
│   ...
├── prod
│   ...
└── terraform.tfvars
```
