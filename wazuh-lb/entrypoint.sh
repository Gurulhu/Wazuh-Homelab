#!/bin/bash

set -e

if [ "x${NGINX_PORT}" = "x" ]; then
  NGINX_PORT=443
fi

echo "Configuring NGINX"
mkdir /var/log/nginx

SERVERS=`seq -f "    server wazuh_wazuh_worker_%g:1514;" ${WORKERS}`

echo "upstream master {
    server wazuh_wazuh_master_1:1515;
}

upstream mycluster {
hash \$remote_addr consistent;
    server wazuh_wazuh_master_1:1514;
$SERVERS
    }

    server {
        listen 1515;
        proxy_pass master;
        error_log  /var/log/nginx/1515.log info;
    }

    server {
        listen 1514;
        proxy_pass mycluster;
        error_log  /var/log/nginx/1514.log info;
    }" >> /opt/nginx/stream.conf.d/default.conf

echo "Starting NGINX"
exec /opt/nginx/sbin/nginx -g 'daemon off;'
