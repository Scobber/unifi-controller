#!/bin/bash
# this file is for any additional pipeline commands
ls /app
#curl -o /tmp/unifi.zip https://dl.ui.com/unifi/7.5.176-1136930355/UniFi.unix.zip
#unzip  /tmp/unifi.zip -d /opt
curl -o /tmp/unifi.deb https://dl.ui.com/unifi/7.5.174-e258d1dd8c/unifi_sysvinit_all.deb
dpkg -i /tmp/unifi.deb
sleep 5
