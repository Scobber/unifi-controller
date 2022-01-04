#!/bin/bash
cd /opt/UniFi
java -jar lib/ace.jar start & 
while [ true ]; do
    sleep 2
    tail -f logs/server.log
done
