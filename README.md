# mlb-nginx-http2

This is a demo of marathon-lb with nginx using HTTP/2.

To begin, you'll need to add this as a URI resource:

     https://downloads.mesosphere.com/marathon/marathon-lb/templates-https-frontend-tcp.tar.gz

For example:

```json
  {
    "id": "/marathon-lb"
    "uris": [
      "https://downloads.mesosphere.com/marathon/marathon-lb/templates-https-frontend-tcp.tar.gz"
    ]
  }
```

# App Definition

```json
```
