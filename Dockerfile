FROM area51/java:serverjre-8
MAINTAINER Peter Mount <peter@retep.org>

ENV  GEOSERVER_VERSION 2.11.0
ENV  GEOSERVER_HOME    /opt/geoserver

COPY geoserver-2.11.0-bin.zip /tmp/geoserver.zip

COPY index.html /tmp
COPY docker-entrypoint.sh /

WORKDIR /opt
RUN unzip -q /tmp/geoserver.zip &&\
    mv geoserver-$GEOSERVER_VERSION $GEOSERVER_HOME &&\
    mkdir -p $GEOSERVER_HOME/webapps/ROOT &&\
    mv /tmp/index.html $GEOSERVER_HOME/webapps/ROOT &&\
    rm -f /tmp/geoserver.zip &&\
    chmod +x /docker-entrypoint.sh

WORKDIR $GEOSERVER_HOME/bin

CMD ["/docker-entrypoint.sh"]
