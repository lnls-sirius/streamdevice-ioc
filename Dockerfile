FROM streamdevice-ioc-base-image
COPY scripts scripts
WORKDIR scripts

ARG IOC_NAME

RUN make deploy

ENV TOP=/opt/streamdevice-ioc
ENV STREAM_PROTOCOL_PATH=/opt/streamdevice-ioc/protocol
ENTRYPOINT ["make"]
