#!/bin/bash

NAME="unifi"
DESC="Ubiquiti UniFi Network application"

BASEDIR="/usr/lib/unifi"

PATH=/bin:/usr/bin:/sbin:/usr/sbin

UMASK=027
FILE_MODE=$(printf '%x' $((0x7777 - 0x${UMASK} & 0x0666)))
DIR_MODE=$(printf '%x' $((0x7777 - 0x${UMASK} & 0x0777)))

MONGOPORT=27117

DATALINK=${BASEDIR}/data
LOGLINK=${BASEDIR}/logs
RUNLINK=${BASEDIR}/run

ENABLE_UNIFI=yes

/usr/sbin/unifi-network-service-helper init
[ -f ${DATALINK}/system_env ] && . ${DATALINK}/system_env
[ -f /etc/default/${NAME} ] && . /etc/default/${NAME}

[ "x${ENABLE_UNIFI}" != "xyes" ] && exit 0

DATADIR=${UNIFI_DATA_DIR:-/var/lib/${NAME}}
LOGDIR=${UNIFI_LOG_DIR:-/var/log/${NAME}}
RUNDIR=${UNIFI_RUN_DIR:-/var/run/${NAME}}


UNIFI_USER=${UNIFI_USER:-unifi}
UNIFI_GROUP=$(id -gn ${UNIFI_USER})

umask ${UMASK}

MONGOLOCK="${DATADIR}/db/mongod.lock"

UNIFI_UID=$(id -u ${UNIFI_USER})
DATADIR_UID=$(stat ${DATADIR} -Lc %u)
if [ ${UNIFI_UID} -ne ${DATADIR_UID} ]; then
    msg="${NAME} cannot start. Please create ${UNIFI_USER} user, and chown -R ${UNIFI_USER} ${DATADIR} ${LOGDIR} ${RUNDIR}"
    logger $msg
    echo $msg >&2
    exit 1
fi

cd ${BASEDIR}
manual_stop_unifi() {
	local MYDIR=$1
	local MYUSER=$2
	local MYGROUP=$3
	local MYMODE=$4

	TMP_UNIFI_STOP=$(mktemp)
	rm -f ${MYDIR}/launcher.looping
	install -o ${MYUSER} -g ${MYGROUP} -m ${MYMODE} ${TMP_UNIFI_STOP} ${MYDIR}/server.stop
	rm -f ${TMP_UNIFI_STOP}
}

is_not_running() {
[ -z "$(pgrep -f ${BASEDIR}/lib/ace.jar)" ] && true || false
}
is_running() {
[ -z "$(pgrep -f ${BASEDIR}/lib/ace.jar)" ] && false || true
}
log_progress_msg() {
    local PROGRESS
    echo "Progress... ${PROGRESS}"
}
log_end_msg() 
{
    local MSG
    echo "End... ${MSG}"
}
UNIFI_CORE_ENABLED=${UNIFI_CORE_ENABLED:-"false"}
UNIFI_JVM_OPTS=${UNIFI_JVM_OPTS:-"-Xmx1024M -XX:+UseParallelGC"}

[ ! -f ${DATADIR}/system.properties ] || api_port=$(grep "^[^#;]" ${DATADIR}/system.properties | sed -n 's/unifi.http.port=\([0-9]\+\)/\1/p')
    api_port=${api_port:-8080}
if is_not_running; then
    nohup /usr/bin/java \
    -Dfile.encoding=UTF-8 \
    -Djava.awt.headless=true \
    -Dapple.awt.UIElement=true \
    -Dunifi.core.enabled=${UNIFI_CORE_ENABLED} \
    $UNIFI_JVM_OPTS \
    -XX:+ExitOnOutOfMemoryError \
    -XX:+CrashOnOutOfMemoryError \
    -XX:ErrorFile=${BASEDIR}/logs/hs_err_pid%p.log \
    -Dunifi.datadir=${DATADIR} \
    -Dunifi.logdir=${LOGDIR} \
    -Dunifi.rundir=${RUNDIR} \
    --add-opens java.base/java.lang=ALL-UNNAMED \
    --add-opens java.base/java.time=ALL-UNNAMED \
    --add-opens java.base/sun.security.util=ALL-UNNAMED \
    --add-opens java.base/java.io=ALL-UNNAMED \
    --add-opens java.rmi/sun.rmi.transport=ALL-UNNAMED \
    -jar ${BASEDIR}/lib/ace.jar start &
    sleep 1
    if is_not_running; then
        log_end_msg 1
    else
        MAX_WAIT=60
        http_code=$(curl -s --connect-timeout 1 -o /dev/null -w "%{http_code}" http://localhost:${api_port}/status)
        for i in `seq 1 ${MAX_WAIT}` ; do
            if [ "${http_code}" != "200" ]; then
                sleep 1
                http_code=$(curl -s --connect-timeout 1 -o /dev/null -w "%{http_code}" http://localhost:${api_port}/status)
            else
                break
            fi
        done
        if [ "${http_code}" != "200" ]; then
            log_end_msg 1
        else
            log_end_msg 0
        fi
    fi
    echo "Streaming Log File ${LOGDIR}/server.log"
    if test -f "${LOGDIR}/server.log"; then
        tail -f ${LOGDIR}/server.log || break 2
    fi
    while [[ !(is_running) ]]
    do
        echo "***PROCESS STILL EXECUTING***"
        sleep 1000
    done
    else
        log_progress_msg "(already running)"
        log_end_msg 1
    fi
sleep 1000