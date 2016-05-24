server {
  listen 80;
  server_name host-01.example.com;
  ## redirect http to https ##
  rewrite ^ https://host-01.example.com$request_uri? permanent;
}

server {

  listen 443 ssl;

  ssl on;
  ssl_certificate_key /etc/nginx/certs/host-01.example.com.key;
  ssl_certificate /etc/nginx/certs/host-01.example.com.crt;

  ssl_ciphers 'AES256+EECDH:AES256+EDH:!aNULL';

  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_session_cache shared:SSL:10m;

  ssl_stapling on;
  ssl_stapling_verify on;
  resolver 8.8.4.4 8.8.8.8 valid=300s;
  resolver_timeout 10s;

  ssl_prefer_server_ciphers on;
  ssl_dhparam /etc/nginx/certs/dhparam.pem;

  add_header Strict-Transport-Security max-age=63072000;
  add_header X-Frame-Options DENY;
  add_header X-Content-Type-Options nosniff;

  chunked_transfer_encoding on;

  server_name host-01.example.com;
  server_tokens off; ## Don't show the nginx version number, a security best practice

  ## Increase this if you want to upload large attachments
  client_max_body_size 0;

  ## Individual nginx logs for this vhost
  access_log /var/log/nginx/host-01.example.com_access.log;
  error_log /var/log/nginx/host-01.example.com_error.log;

  location / {
    include proxy_params;
    proxy_pass http://host_01_backend;
  }
}

upstream host_01_backend {
    server 172.17.0.1:8080;
}
