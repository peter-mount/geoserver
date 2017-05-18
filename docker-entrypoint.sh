#!/bin/ash

cd /opt/geoserver/bin

# Set the port, default is 8080
INI=../start.ini
if [ -n $PORT ]
then
    sed -i s/jetty.port=.*/jetty.port=$PORT/g $INI
fi

exec ./startup.sh
