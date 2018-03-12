local k = import 'k.libsonnet';
local nginxReact = '../nginx-react.libsonnet';

local namespace = "default";
local appName = "nginx-react";
local appImage = "nginx:1.13.9-alpine";
local appDomain = "staging.swarm.pw";

k.core.v1.list.new([
  nginxReact.parts.deployment(namespace, appName, appImage),
  nginxReact.parts.configMap(namespace, appName),
  nginxReact.parts.service(namespace, appName),
  nginxReact.parts.ingress(namespace, appName, appDomain)
])
