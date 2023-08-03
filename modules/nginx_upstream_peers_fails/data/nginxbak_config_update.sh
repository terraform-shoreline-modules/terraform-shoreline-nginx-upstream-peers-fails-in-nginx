#!/bin/bash

# Backup the original NGINX configuration file

cp ${NGINX_CONFIG_FILE} ${NGINX_CONFIG_FILE}.bak


# Set the worker_connections value to 1024

sed -i 's/worker_connections [0-9]\+/worker_connections 1024/' ${NGINX_CONFIG_FILE}

# Set the worker_processes value to the number of available CPU cores

worker_processes=$(nproc)

sed -i 's/worker_processes [0-9]\+/worker_processes '$worker_processes'/' ${NGINX_CONFIG_FILE}

# Increase the keepalive_timeout value to 60 seconds

sed -i 's/keepalive_timeout [0-9]\+/keepalive_timeout 60/' ${NGINX_CONFIG_FILE}

# Reload NGINX to apply the new configuration

service nginx reload