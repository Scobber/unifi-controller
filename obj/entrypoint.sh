#!/bin/bash
cd /opt/UniFi
touch '/opt/UniFi/logs/server.log'
bash /app/start.sh &
while [ true ]; do
    sleep 2
    if test -f '/opt/UniFi/logs/server.log'; then
        tail -f /opt/UniFi/logs/server.log || break 2
    fi
done
bash /app/stop.sh
tail -f /opt/UniFi/logs/server.log
exit
