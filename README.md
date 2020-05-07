# Wazuh-Homelab

##DISCLAIMER: 
This is by no means production-ready, not even production-oriented. There's event a hardcoded cluster key. 
Please be sure that deploying it for anything other than testing and learning purposes requires either heavy customization or an acknowledgment of pwn.

##Purpose:
This is a fully dockerized Wazuh environment. It expands [the original Wazuh-Docker repository](https://github.com/wazuh/wazuh-docker) clusterizing the Wazuh manager with a scalabe number of workers, a NGINX load balancer and a scalable number of agents.

I made this to test the viability of a contanerized deploy and make some stress tests, but those evolved into failure tests and load balancing tuning tests after some time.

All agents deployed will generate logs after ~30 seconds, creating fake sshd logs by reshuffling the auth.log.
This behavior is controlled by the sshd_log_generator.sh, and uses the cropped.log as base. The original logs are kept in the sample.log if you might need it.

##How to Use
I'll upload a medium text to explain some caveats and tips on using Wazuh clusters soon, and will create a how-to-use section soon after.

For now, you can deploy it out-of-the-box with:
```bash
build.sh 
docker-compose down --remove-orphans 
docker-compose up --scale wazuh_worker=4 --scale agent=10
```

###Note: make sure that the environment variable WORKERS in the loadbalancer compose is equal to the # of workers you're deploying. The loadbalancer will fail if WORKERS is greater, or won't route correctly if it's lesser.
