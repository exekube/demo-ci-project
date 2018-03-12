{
  parts:: {
    deployment(namespace, name, image, labels={app: name}):: {
      local defaults = {
        image: image,
        imagePullPolicy: "Always",
      },

      apiVersion: "extensions/v1beta1",
      kind: "Deployment",
      metadata: {
        namespace: namespace,
        name: name,
        labels: labels,
      },
      spec: {
        replicas: 1,
        strategy: {
          rollingUpdate: {
            maxSurge: 0,
            maxUnavailable: 1,
          },
        },
        template: {
          metadata: { labels: labels },
          spec: {
            containers: [
              {
                name: name,
                image: image,
                imagePullPolicy: defaults.imagePullPolicy,
                resources: {},
                ports: [
                  {
                    containerPort: 80,
                  },
                ],
                volumeMounts: [
                  {
                    name: "nginx-config",
                    mountPath: "/etc/nginx/conf.d",
                  },
                ],
              }
            ],
            volumes: [
              {
                name: "nginx-config",
                configMap: {
                  name: name,
                },
              },
            ],
          },
        },
      },
    },

    service(namespace, name, selector={app: name}):: {
      apiVersion: "v1",
      kind: "Service",
      metadata: {
        namespace: namespace,
        name: name,
        labels: { app: name },
      },
      spec: {
        type: "ClusterIP",
        ports: [
          {
            port: 80,
            targetPort: 80,
          },
        ],
        selector: selector,
      },
    },

    ingress(
        namespace,
        name,
        domain,
        labels={app: name},
        annotations={
          "kubernetes.io/ingress.class": "nginx",
          "kubernetes.io/tls-acme": "true",
        }):: {
      apiVersion: "extensions/v1beta1",
      kind: "Ingress",
      metadata: {
        namespace: namespace,
        name: name,
        labels: labels,
        annotations: annotations,
      },
      spec: {
        rules: [
          {
            host: domain,
            http: {
              paths: [
                {
                  backend: {
                    serviceName: name,
                    servicePort: 80,
                  },
                },
              ],
            },
          },
        ],
        tls: [
          {
            secretName: domain + "-tls",
            hosts: [
              domain,
            ],
          },
        ],
      },
    },

    configMap(namespace, name):: {
      local defaults = {
        nginxConfig:
        |||
        server {
          listen 80;
          location / {
            root   /usr/share/nginx/html;
            index  index.html index.htm;
            try_files $uri $uri/ /index.html;
          }
          error_page   500 502 503 504  /50x.html;
          location = /50x.html {
            root   /usr/share/nginx/html;
          }
        }
      |||
      },

      apiVersion: "v1",
      kind: "ConfigMap",
      metadata: {
        namespace: namespace,
        name: name,
        labels: { app: name }
      },
      data: {
        "default.conf": defaults.nginxConfig,
      },
    },
  }
}
