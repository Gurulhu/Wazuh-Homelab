# Wazuh-Homelab

## DISCLAIMER: 
This is by no means production-ready, not even production-oriented. There's event a hardcoded cluster key. 
Please be sure that deploying it for anything other than testing and learning purposes requires either heavy customization or an acknowledgment of pwn.

## Purpose:
This is a fully dockerized Wazuh environment. It expands [the original Wazuh-Docker repository](https://github.com/wazuh/wazuh-docker) clusterizing the Wazuh manager with a scalabe number of workers, a NGINX load balancer and a scalable number of agents.

I made this to test the viability of a contanerized deploy and make some stress tests, but those evolved into failure tests and load balancing tuning tests after some time. For tips and tricks on how to run a Wazuh setup, [check my medium post here.](https://medium.com/@Gurulhu/tips-for-setting-up-a-wazuh-cluster-f05665023c10?sk=9fb8e6088d9f9021bf2d50223c223b60)

All agents deployed will generate logs after ~30 seconds, creating fake sshd logs by reshuffling the auth.log.
This behavior is controlled by the sshd_log_generator.sh, and uses the cropped.log as base. The original logs are kept in the sample.log if you might need it.

## How to Use
Providing you have docker-compose and docker installed, you just need to build our custom images and run the compose.
I made a handy script to build then all so you just need to run:

```bash
build.sh 
docker-compose down --remove-orphans 
docker-compose up --scale wazuh_worker=4 --scale agent=10
```

### Note: make sure that the environment variable WORKERS in the loadbalancer compose is equal to the # of workers you're deploying. The loadbalancer will fail if WORKERS is greater, or won't route correctly if it's lesser.
