# Wazuh Docker Copyright (C) 2020 Wazuh Inc. (License GPLv2)
FROM tekn0ir/nginx-stream:latest

VOLUME ["/etc/nginx/conf.d"]

ENV NGINX_NAME="foo" \
    NGINX_PWD="bar"

COPY entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
