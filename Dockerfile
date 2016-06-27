FROM nginx:stable-alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY insecure-cert.pem /etc/nginx/insecure-cert.pem
COPY index.html /usr/share/nginx/html/index.html
