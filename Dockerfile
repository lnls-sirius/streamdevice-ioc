ARG STREAM_BASE_IMAGE
ARG STREAM_BASE_TAG

FROM ${STREAM_BASE_IMAGE}:${STREAM_BASE_TAG} AS base
COPY scripts scripts

FROM base AS agilent4uhv
RUN set -x; cd scripts; make deploy-agilent4uhv
CMD ["/bin/bash", "-c", "set -e; cd scripts/; make run-agilent4uhv"]

FROM base AS countingpru
RUN set -x; cd scripts; make deploy-countingpru
CMD ["/bin/bash", "-c", "set -e; cd scripts/; make run-countingpru"]

FROM base AS mbtemp
VOLUME ["${TOP}/scripts/spreadsheet"]
RUN set -x; \
    apt update; \
    apt install -y python3-pip python3; \
    pip install pandas openpyxl;\
    cd scripts; \
    make deploy-mbtemp
CMD ["/bin/bash", "-c", "set -e; cd scripts/; make build-mbtemp; make deploy-mbtemp; make run-mbtemp"]

FROM base AS mks937b
RUN set -x; cd scripts; make deploy-mks937b
CMD ["/bin/bash", "-c", "set -e; cd scripts/; make run-mks937b"]

FROM base AS rackMonitoring
RUN set -x; cd scripts; make deploy-rackmon
CMD ["/bin/bash", "-c", "set -e; cd scripts/; make run-rackmon"]

FROM base AS spixconv
COPY scripts scripts

RUN set -x; \
    cd scrits; \
    cp -v -p ./spixconv/ioc/autosave/*      $(TOP)/autosave; \
    cp -v -p ./spixconv/ioc/db/*            $(TOP)/db; \
    cp -v -p ./spixconv/ioc/protocol/*      $(TOP)/protocol; \
    cp -v -p ./spixconv/ioc/cmd/*           $(TOP)/iocBoot/iocStreamDeviceIOC;

CMD ["/bin/bash", "-c", "set -e; cd scripts/; make run-spixconv"]
