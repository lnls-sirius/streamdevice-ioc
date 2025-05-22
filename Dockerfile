FROM streamdevice-ioc-base-image
COPY scripts scripts
WORKDIR scripts

ARG IOC_NAME

RUN make deploy

ENTRYPOINT ["make"]
