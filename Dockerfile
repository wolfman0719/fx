ARG IMAGE=store/intersystems/iris-community-arm64:2020.4.0.547.0
ARG IMAGE=store/intersystems/iris-community-arm64:2021.1.0.215.0
ARG IMAGE=intersystemsdc/iris-community:2020.3.0.221.0-zpm
ARG IMAGE=intersystemsdc/iris-community:2020.4.0.547.0-zpm
ARG IMAGE=store/intersystems/iris-community:2020.4.0.547.0
ARG IMAGE=store/intersystems/iris-community:2021.1.0.215.0
FROM $IMAGE
ARG COMMIT_ID="pgdemo"

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

USER ${ISC_PACKAGE_MGRUSER}

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && cp $ISC_TEMP_DIR/samples/* $ISC_TEMP_DIR/in \
    && iris session IRIS < /tmp/iris2.script \
    && iris stop IRIS quietly
