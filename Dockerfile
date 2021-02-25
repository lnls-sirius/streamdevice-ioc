ARG STREAM_BASE_IMAGE
ARG STREAM_BASE_TAG

FROM  ${STREAM_BASE_IMAGE}:${STREAM_BASE_TAG} AS base
COPY scripts            scripts

FROM  base AS agilent4uhv
RUN set -x; cd scripts; make deploy-agilent4uhv
CMD ["/bin/bash", "cd scripts/ && make run-agilent4uhv"]

FROM base AS countingpru
RUN set -x; cd scripts; make deploy-countingpru
CMD ["/bin/bash", "cd scripts/ && make run-countingpru"]

FROM base AS mbtemp
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/mbtemp.sh"]

FROM base AS mks937b
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/mks937b.sh"]

FROM base AS rackMonitoring
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/rackMonitoring.sh"]

FROM base AS spixconv
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/spixconv.sh"]
