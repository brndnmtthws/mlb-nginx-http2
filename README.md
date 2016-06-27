# mlb-nginx-http2

This is a technology demo of HTTP/2 with marathon-lb, vhosts, and nginx. Please note, this is _not_ the only way to do this with HAProxy. It's also possible to terminate TLS at HAProxy, and pass HTTP/2 through to the backends unencrypted.

To begin, you'll need to add this as a URI resource to MLB:

```
https://downloads.mesosphere.com/marathon/marathon-lb/templates-https-frontend.tar.gz
```

For example, add it to the URIs part of your MLB app definition:

```json
  {
    "id": "/marathon-lb",
    "uris": [
      "https://downloads.mesosphere.com/marathon/marathon-lb/templates-https-frontend.tar.gz"
    ]
  }
```

The template package above will override several global template values.

# nginx App Definition

Here's a sample app definition (be sure to replace the vhost):

```json
{
  "id": "/nginx-http2",
  "cpus": 1,
  "mem": 128,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "brndnmtthws/mlb-nginx-http2:latest",
      "network": "BRIDGE",
      "portMappings": [
        {
          "containerPort": 443,
          "servicePort": 10000,
          "protocol": "tcp",
        }
      ]
    }
  },
  "healthChecks": [
    {
      "protocol": "TCP",
      "portIndex": 0,
      "gracePeriodSeconds": 30,
      "intervalSeconds": 6,
      "timeoutSeconds": 2,
      "maxConsecutiveFailures": 3
    }
  ],
  "labels": {
    "HAPROXY_0_REDIRECT_TO_HTTPS": "true",
    "HAPROXY_GROUP": "external",
    "HAPROXY_0_VHOST": "brenden-s-publicsl-45c9w0mb4hbw-1097994302.us-west-2.elb.amazonaws.com"
  }
}
```

# Caveats

 - This configuration breaks TLS termination at MLB for all other apps
 - You **must** enable the HTTP to HTTPS redirect
 - Several other features will break, such as the `X-Marathon-App-Id` header routing
 - You cannot use routing by path
