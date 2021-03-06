FROM ubuntu:focal
VOLUME /var/lib/apt/lists /opt/UniFi/data/backup /opt/UniFi/data /opt/UniFi/logs
RUN mkdir -p /dep
RUN mkdir -p /app
COPY /dep /dep
RUN /bin/bash /dep/installdeps.sh
COPY /obj /app
RUN bash /app/build.sh
ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]
