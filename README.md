# geoserver

This is a docker container containing Geoserver

Note: This is a work in progress

## Environment Variables

PORT The port within the container to listen to. Default 8080

GEOSERVER_DATA_DIR The directory within the container that contains geoserver's persistent data. Default is /opt/data

## Branches

Each branch represents an official build of Geoserver, the version number is also the tag for the image.
Currently the following branches exist:

* 2.14.0 also builds as the latest tag.
* 2.13.2
* 2.12.4
* 2.13.0

Branches 2.14.0 or lower are all based on Java 8.

The master branch now represents a test build in preparation for Geoserver migrating to Java 11.
The master branch will generate the master tag for the image.
