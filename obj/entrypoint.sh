#!/bin/bash

#!/bin/bash
cd /usr/lib/unifi
bash /app/start.sh &
while [ true ]; do
    sleep 2
    tail -f /var/log/unifi/server.log || break 2
done
bash /app/stop.sh
tail -f /var/log/unifi/server.log || break 2
exit