ARG GEOSERVER_VERSION

FROM area51/java:serverjre-8 AS base
ARG GEOSERVER_VERSION
MAINTAINER Peter Mount <peter@retep.org>

ENV  PLUGINS	        netcdf-plugin netcdf-out-plugin grib-plugin wps-plugin imagemosaic-jdbc-plugin css-plugin

ENV  GEOSERVER_HOME	/opt/geoserver

COPY index.html /tmp

WORKDIR /opt
RUN (for i in bin $PLUGINS; do \
      echo Retrieving $i $GEOSERVER_VERSION &&\
      curl -s -o /tmp/geoserver-${i}.zip \
    	 https://cdn.area51.onl/tools/geoserver/geoserver-${GEOSERVER_VERSION}-${i}.zip || die 'failed' ;\
    done )

RUN echo Installing &&\
    unzip -q /tmp/geoserver-bin.zip &&\
    rm -f /tmp/geoserver.zip

RUN echo Moving geoserver-$GEOSERVER_VERSION to $GEOSERVER_HOME &&\
    mv geoserver-$GEOSERVER_VERSION $GEOSERVER_HOME

RUN echo Configuring root &&\
    mkdir -p $GEOSERVER_HOME/webapps/ROOT &&\
    mv /tmp/index.html $GEOSERVER_HOME/webapps/ROOT

RUN cd $GEOSERVER_HOME/webapps/geoserver/WEB-INF/lib &&\
    (for i in $PLUGINS;do echo "Installing $i";unzip -q -o /tmp/geoserver-${i}.zip;done)

FROM area51/java:serverjre-8

ENV  GEOSERVER_HOME	/opt/geoserver
ENV  GEOSERVER_DATA_DIR	/opt/data

WORKDIR $GEOSERVER_HOME/bin
#VOLUME	$GEOSERVER_DATA_DIR

COPY docker-entrypoint.sh /
COPY --from=base $GEOSERVER_HOME $GEOSERVER_HOME

RUN mkdir -p $GEOSERVER_DATA_DIR &&\
    chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
