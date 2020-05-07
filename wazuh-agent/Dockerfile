FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server curl apt-transport-https lsb-release gnupg2 rsyslog

RUN mkdir /var/run/sshd

RUN echo 'root:test' | chpasswd

RUN useradd foo && echo 'foo:bar' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN sed -i 's/#SyslogFacility/SyslogFacility/g' /etc/ssh/sshd_config

RUN sed -i 's/#LogLevel/LogLevel/g' /etc/ssh/sshd_config

RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

# SSH login fix. Otherwise user is kicked off after login

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


ENV NOTVISIBLE "in users profile"

RUN echo "export VISIBLE=now" >> /etc/profile

RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -

RUN echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list

RUN apt update && apt-get install -y wazuh-agent

COPY configure_wazuh.sh /etc/configure_wazuh.sh

RUN chmod +x /etc/configure_wazuh.sh

COPY sshd_log_generator.sh /etc/sshd_log_generator.sh

RUN chmod +x /etc/sshd_log_generator.sh

COPY cropped.log /opt/cropped.log

ENTRYPOINT ["/bin/bash", "-c", "/etc/configure_wazuh.sh"]
