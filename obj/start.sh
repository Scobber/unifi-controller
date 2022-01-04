#!/bin/bash
cd /opt/UniFi
java -jar lib/ace.jar start
kill -9 $(pgrep bash)
