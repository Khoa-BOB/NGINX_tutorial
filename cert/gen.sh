#!/bin/bash

openssl req -x509 \
  -newkey rsa:2048 \
  -nodes \
  -days 365 \
  -keyout /Users/khoatran/Documents/Software_KhoaTran/nginx_tutorial/cert/localhost.key \
  -out /Users/khoatran/Documents/Software_KhoaTran/nginx_tutorial/cert/localhost.crt \
  -subj "/CN=localhost" \
  -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"