#!/bin/bash
# this file is for any additional pipeline commands
ls /app
curl -o /tmp/unifi.zip https://dl.ui.com/unifi/7.1.61-c7eb1400e2/UniFi.unix.zip
unzip  /tmp/unifi.zip -d /opt

sleep 5
