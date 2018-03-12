// @apiVersion 0.1.0
// @name pw.swarm.pkg.nginx-react
// @description Deploys an nginx server specifically for hosting React apps.
// @shortDescription A simple nginx server for hosting React apps.
// @optionalParam namespace string default Namespace in which to put the application
// @param name string Name to give to each of the components
// @param image string Application docker image
// @param domain string Domain name for the ingress resource.

local k = import 'k.libsonnet';
local nginxReact = import 'private-registry/nginx-react/nginx-react.libsonnet';

local namespace = import 'param://namespace';
local appName = import 'param://name';
local appImage = import 'param://image';
local appDomain = import 'param://domain';

k.core.v1.list.new([
  nginxReact.parts.deployment(namespace, appName, appImage),
  nginxReact.parts.service(namespace, appName),
  nginxReact.parts.ingress(namespace, appName, appDomain),
  nginxReact.parts.configMap(namespace, appName),
])
