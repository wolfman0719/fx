ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2022.1.0.209.0
ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2023.1.0.235.1
ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2022.1.0.209.0
ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2023.1.0.235.1
FROM $IMAGE
ARG COMMIT_ID="fxdemo"

USER root   
        
ENV ISC_TEMP_DIR=/intersystems/iris/fx

USER ${ISC_PACKAGE_MGRUSER}

COPY data/ $ISC_TEMP_DIR/
COPY FX $ISC_TEMP_DIR/src
COPY lookuptable.xml $ISC_TEMP_DIR/
COPY iris.script /tmp/
COPY iris2.script /tmp/

USER root

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} $ISC_TEMP_DIR/
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} $ISC_TEMP_DIR/in
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} $ISC_TEMP_DIR/work
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} $ISC_TEMP_DIR/arc
RUN rm $ISC_TEMP_DIR/in/.gitkeep

USER ${ISC_PACKAGE_MGRUSER}

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && cp $ISC_TEMP_DIR/samples/* $ISC_TEMP_DIR/in \
    && iris session IRIS < /tmp/iris2.script \
    && iris stop IRIS quietly
