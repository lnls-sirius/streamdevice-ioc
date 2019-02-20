# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory

FROM lnlscon/epics-r3.15.5:latest
LABEL maintainer="Claudio Carneiro <claudio.carneiro@lnls.br>"

WORKDIR /opt/

# Github environment variables
ENV GITHUB_REPO https://github.com/lnls-sirius/streamdevice-ioc.git

RUN apt-get install -y telnet

# Clear stream-ioc's database, interface, protocol and iocBoot folders.
RUN rm -rd ${TOP}/database/* && \
    rm -rd ${TOP}/interface/* && \
    rm -rd ${TOP}/protocol/* && \
    rm -rd ${TOP}/iocBoot/*

# Github Repo
RUN git clone ${GITHUB_REPO}
WORKDIR /opt/streamdevice-ioc

RUN git checkout origin/docker-support

# Epics auto addr list
ENV EPICS_CA_AUTO_ADDR_LIST=YES

# Base procServ port
ENV BASE_PROCSERV_PORT=20400

# Run stuff
CMD ./scripts/run.sh ${DEVICE_FOLDER} ${DEVICE_PREFIX}
