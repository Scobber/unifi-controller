#!/bin/bash
# this file is for any additional pipeline commands
ls /app
#curl -o /tmp/unifi.zip https://dl.ui.com/unifi/7.5.176-1136930355/UniFi.unix.zip
#unzip  /tmp/unifi.zip -d /opt
#7.5.174
#curl -o /tmp/unifi.deb https://dl.ui.com/unifi/7.5.174-e258d1dd8c/unifi_sysvinit_all.deb

#7.5.187
#curl -o /tmp/unifi.deb https://dl.ui.com/unifi/7.5.187-f57f5bf7ab/unifi_sysvinit_all.deb
#dpkg -i /tmp/unifi.deb

#8.0.26
curl -o /tmp/unifi.deb https://dl.ui.com/unifi/8.0.26/unifi_sysvinit_all.deb
dpkg -i /tmp/unifi.deb
sleep 5
