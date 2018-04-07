# demo-ci-project

This is a demo project built with the [Exekube framework](https://github.com/exekube/exekube)

If you are new to Exekube, follow the *Getting Started Tutorial* tutorial at https://exekube.github.io/exekube/in-practice/getting-started

## What we're building

Our goal is to deploy a production-like GKE cluster, then deploy these applications onto it:

- Gogs (Private Git service)
- Concourse server (CI service)
- Docker Registry v2 (Docker image registry)
- ChartMuseum (Helm chart repository)

## Environments

- dev

## Live modules

- [Cloud resources](#cloud-resources)
	- [infra/network](#infranetwork)
	- [k8s/cluster](#k8scluster)
- [Kubernetes resources](#kubernetes-resources)
	- [k8s/kube-system/_helm](#k8skube-systemhelm)
	- [k8s/kube-system/cluster-admin](#k8skube-systemcluster-admin)
	- [k8s/kube-system/nginx-ingress](#k8skube-systemnginx-ingress)
	- [k8s/kube-system/kube-lego](#k8skube-systemkube-lego)
	- [k8s/default/_helm](#k8sdefaulthelm)
	- [k8s/default/concourse](#k8sdefaultconcourse)
	- [k8s/default/chartmuseum](#k8sdefaultchartmuseum)
    - [k8s/default/gogs](#k8sdefaultgogs)
	- [k8s/default/docker-registry](#k8sdefaultdocker-registry)

### Cloud resources

#### infra/network

> ⚠️ You must set `dns_zones` and `dns_records` variables for the demo
>
[gke-network module](/)

- New network for GCP project
- Subnets for nodes, pods, services in GKE cluster
- Regional static IP addresses for nginx-ingress
- DNS records for nginx-ingress IP address

#### k8s/cluster

> [gke-cluster module](/)

- A GKE Kubernetes cluster
- Node pools

### Kubernetes resources

#### k8s/kube-system/_helm

> [helm-initializer module](/)

- Generate CA, Tiller server, Helm client TLS certificates and private keys
- Install Tiller into kube-system namespace

#### k8s/kube-system/cluster-admin

> [helm-release module](/)
>
> [exekube/cluster-admin Helm chart](/)

- Create namespaces
- Create deny-all default NetworkPolicies for the namespaces
- Assign cluster-admins

#### k8s/kube-system/nginx-ingress

> [helm-release module](/)
>
> [stable/nginx-ingress Helm chart](/)

> ⚠️ You must use the regional static IP address from infra/network module output to set `conroller.service.loadBalancerIP` variable in values.yaml

- Release nginx-ingress Helm chart
- Use static regional IP address for the cloud TCP Load Balancer

#### k8s/kube-system/kube-lego

> ⚠️ Staging Let's Encrypt server is used by default

- Release stable/kube-lego Helm chart

#### k8s/default/_helm

- Generate CA, Tiller server, Helm client TLS certificates and private keys
- Install Tiller into default namespace

#### k8s/default/concourse

> ⚠️ Disabled by default

- Release stable/concourse Helm chart

#### k8s/default/chartmuseum

> ⚠️ Disabled by default

- Release incubator/chartmuseum Helm chart

#### k8s/default/gogs

> ⚠️ Disabled by default

- Release incubator/gogs Helm chart

#### k8s/default/docker-registry

> ⚠️ Disabled by default

- Release stable/docker-registry Helm chart
