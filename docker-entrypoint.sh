#!/bin/ash

cd $GEOSERVER_HOME

# Set the port, default is 8080
INI=start.ini
if [ -n "$PORT" ]
then
    sed -i s/jetty.port=.*/jetty.port=$PORT/g $INI
fi

# If data dir is empty then initialise it with default
[ "$(ls -A $GEOSERVER_DATA_DIR)" ] || (
    echo "Empty data directory $GEOSERVER_DATA_DIR Initialising"
    cp -rp $GEOSERVER_HOME/data_dir/* $GEOSERVER_DATA_DIR
)

cd bin
exec ./startup.sh
