#!/bin/bash
# this file is for any additional pipeline commands
ls /app
<<<<<<< HEAD
curl -o /tmp/unifi.zip https://dl.ui.com/unifi/7.1.66-c70daa41cf/UniFi.unix.zip
=======
curl -o /tmp/unifi.zip https://dl.ui.com/unifi/7.0.25-43e7fc6711/UniFi.unix.zip
>>>>>>> parent of 54c68a7 (Update to 7.1.6.1)
unzip  /tmp/unifi.zip -d /opt

sleep 5
