local env = std.extVar("__ksonnet/environments");
local params = std.extVar("__ksonnet/params").components["react-app-ui"];
local k = import 'k.libsonnet';
local nginxReact = import 'private-registry/nginx-react/nginx-react.libsonnet';

local namespace = params.namespace;
local appName = params.name;
local appImage = params.image;
local appDomain = params.domain;

k.core.v1.list.new([
  nginxReact.parts.deployment(namespace, appName, appImage),
  nginxReact.parts.service(namespace, appName),
  nginxReact.parts.ingress(namespace, appName, appDomain),
  nginxReact.parts.configMap(namespace, appName),
])
