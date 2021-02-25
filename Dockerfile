ARG STREAM_BASE_IMAGE
ARG STREAM_BASE_TAG

FROM ${STREAM_BASE_IMAGE}:${STREAM_BASE_TAG} AS base
COPY scripts scripts

FROM base AS agilent4uhv
RUN set -x; cd scripts; make deploy-agilent4uhv
CMD ["/bin/bash", "cd scripts/ && make run-agilent4uhv"]

FROM base AS countingpru
RUN set -x; cd scripts; make deploy-countingpru
CMD ["/bin/bash", "cd scripts/ && make run-countingpru"]

FROM base AS mbtemp
RUN set -x; cd scripts; make deploy-mbtemp
CMD ["/bin/bash", "cd scripts/ && make run-mbtemp"]

FROM base AS mks937b
RUN set -x; cd scripts; make deploy-mks937b
CMD ["/bin/bash", "cd scripts/ && make run-mks937b"]

FROM base AS rackMonitoring
RUN set -x; cd scripts; make deploy-rackmon
CMD ["/bin/bash", "cd scripts/ && make run-rackMonitoring"]

FROM base AS spixconv
RUN set -x; cd scripts; make deploy-spixconv
CMD ["/bin/bash", "cd scripts/ && make run-mks937b"]
