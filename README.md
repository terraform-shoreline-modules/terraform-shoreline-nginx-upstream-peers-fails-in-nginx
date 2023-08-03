
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Nginx Upstream peers fails
---

This incident type involves an issue with NGINX upstream peers failing, which has triggered an alert. The details of the alert include information about the percentage of failures and how they compare to predicted values over a certain time period. The incident may be resolved or ongoing, and it may have impacted a specific service or team.

### Parameters
```shell
# Environment Variables

export PATH_TO_NGINX_CONFIG="PLACEHOLDER"

export UPSTREAM_PEER_URL="PLACEHOLDER"

export PATH_TO_NGINX_LOG="PLACEHOLDER"

export COMMAND_TO_CHECK_FOR_ANOMALIES="PLACEHOLDER"

export UPSTREAM_PEERS_URL="PLACEHOLDER"
```

## Debug

### Check NGINX status
```shell
systemctl status nginx
```

### Check current upstream peers configuration
```shell
cat ${PATH_TO_NGINX_CONFIG}/nginx.conf | grep upstream
```

### Check upstream peers health
```shell
curl -I ${UPSTREAM_PEER_URL}
```

### Check the network connections to upstream servers
```shell
netstat -anp | grep ${UPSTREAM_SERVER_IP}
```

### Check NGINX log for errors
```shell
tail -n 50 ${PATH_TO_NGINX_LOG}/error.log
```

### Check CPU and memory usage
```shell
top
```

### Check network usage
```shell
iftop
```

### Check system load
```shell
top -n 1 -b`
```


## Repair

### Optimize the NGINX configuration to ensure optimal performance and reduce the likelihood of upstream peer failures.
```shell
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

```