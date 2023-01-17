#!/bin/bash
# this file is for any additional pipeline commands
ls /app
curl -o /tmp/unifi.zip https://dl.ui.com/unifi/7.3.81-1529bd4a64/UniFi.unix.zip
unzip  /tmp/unifi.zip -d /opt

sleep 5
