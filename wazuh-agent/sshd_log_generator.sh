echo "sleeping randomly"
sleep $[ ( $RANDOM % 30 )  + 20 ]s

echo "commencing spam"
for i in {1..1000}
do
  sleep 3s
  DATE="`date +"%B %e %H:%M:%S"`"
  sed -e "s/^/$DATE $HOSTNAME /g" /opt/cropped.log > auth.log
  cat auth.log >> /var/log/auth.log
  echo "batch $i done"
done

echo "doubling logs. . ."
  cat /var/log/auth.log >> auth.log
  cat auth.log >> /var/log/auth.log

#echo "doubling logs. . . again."
#  cat /var/log/auth.log >> auth.log
#  cat auth.log >> /var/log/auth.log
#
#echo "doubling logs. . . once more with felling"
#  cat /var/log/auth.log >> auth.log
#  cat auth.log >> /var/log/auth.log

echo "emptying logs"
  rm /var/log/auth.log
  rm auth.log

echo "done spamming"
