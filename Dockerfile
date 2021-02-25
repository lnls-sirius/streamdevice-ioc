ARG STREAM_BASE_IMAGE
ARG STREAM_BASE_TAG
FROM  ${STREAM_BASE_IMAGE}:${STREAM_BASE_TAG} AS agilent4uhv
LABEL br.com.lnls-sirius.device="Agilent 4UHV"
RUN \
    cp -v -p ${TOP}/scripts/agilent4uhv/server/autosave/* ${TOP}/autosave &&\
    cp -v -p ${TOP}/scripts/agilent4uhv/server/db/*       ${TOP}/db       &&\
    cp -v -p ${TOP}/scripts/agilent4uhv/server/protocol/* ${TOP}/protocol &&\
    cp -v -p ${TOP}/scripts/agilent4uhv/server/cmd/*      ${TOP}/autosave

CMD ["/bin/bash", "cd scripts/ && make run-agilent4uhv"]

ARG STREAM_BASE_IMAGE
ARG STREAM_BASE_TAG
FROM  ${STREAM_BASE_IMAGE}:${STREAM_BASE_TAG} AS countingPRU
LABEL "br.com.lnls-sirius.device"="Counting PRU"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/countingPRU.sh"]

ARG STREAM_BASE_IMAGE
ARG STREAM_BASE_TAG
FROM ${STREAM_BASE_IMAGE}:${STREAM_BASE_TAG} AS mbtemp
LABEL "br.com.lnls-sirius.device"="MBTemp"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/mbtemp.sh"]

ARG STREAM_BASE_IMAGE
ARG STREAM_BASE_TAG
FROM ${STREAM_BASE_IMAGE}:${STREAM_BASE_TAG} AS mks937b
LABEL "br.com.lnls-sirius.device"="MKS937b"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/mks937b.sh"]

ARG STREAM_BASE_IMAGE
ARG STREAM_BASE_TAG
FROM ${STREAM_BASE_IMAGE}:${STREAM_BASE_TAG} AS rackMonitoring
LABEL "br.com.lnls-sirius.device"="RackMonitoring"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/rackMonitoring.sh"]

ARG STREAM_BASE_IMAGE
ARG STREAM_BASE_TAG
FROM ${STREAM_BASE_IMAGE}:${STREAM_BASE_TAG} AS spixconv
LABEL "br.com.lnls-sirius.device"="SPIxCONV"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/spixconv.sh"]
