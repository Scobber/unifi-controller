#!/bin/bash
bash start.sh &
while [ true ]; do
    sleep 2
    tail -f /opt/UniFi/logs/server.log
done
