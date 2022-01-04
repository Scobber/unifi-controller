#!/bin/bash
cd /opt/UniFi
bash /app/start.sh &
while [ true ]; do
    sleep 2
    tail -f /opt/UniFi/logs/server.log || break 2
done
bash /app/stop.sh
tail -f /opt/UniFi/logs/server.log
