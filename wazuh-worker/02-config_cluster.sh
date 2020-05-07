sed -i "s/node01/${HOSTNAME}/g" /var/ossec/etc/ossec.conf
sed -i "s/CLUSTER_KEY/${CLUSTER_KEY}/g" /var/ossec/etc/ossec.conf

if [ $HOSTNAME != wazuh_master ]
  then
    sed -i "s/<node_type>master/<node_type>worker/g" /var/ossec/etc/ossec.conf
fi
