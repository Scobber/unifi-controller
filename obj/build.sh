#!/bin/bash
# this file is for any additional pipeline commands
ls /app
curl -o /tmp/unifi.zip curl -o /tmp/unifi.zip https://dl.ui.com/unifi/7.2.94/UniFi.unix.zip
unzip  /tmp/unifi.zip -d /opt

sleep 5
