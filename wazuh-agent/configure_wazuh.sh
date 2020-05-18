echo "sleeping randomly"
sleep $[ ( $RANDOM % 50 )  + 30 ]s

sed -i "s/udp/tcp/g" /var/ossec/etc/ossec.conf
sed -i "s/MANAGER_IP/wazuh_loadbalancer/g" /var/ossec/etc/ossec.conf

echo "
<ossec_config>

  <client_buffer>
    <!-- Agent buffer options -->
    <disabled>no</disabled>
    <queue_size>$QUEUE_SIZE</queue_size>
    <events_per_second>$EVENTS_PER_SECOND</events_per_second>
  </client_buffer>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/auth.log</location>
  </localfile>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/syslog</location>
  </localfile>

</ossec_config>" >> /var/ossec/etc/ossec.conf

chown root:ossec /var/ossec/etc/ossec.conf

/usr/sbin/rsyslogd

/var/ossec/bin/agent-auth -m wazuh_loadbalancer

/var/ossec/bin/ossec-control restart

bash /etc/sshd_log_generator.sh

/usr/sbin/sshd -D
