# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory

FROM lnlscon/epics-r3.15.5:latest

MAINTAINER Claudio Carneiro <claudio.carneiro@lnls.br>

WORKDIR /root/streamdevice-ioc

# Github environment variables
ENV GITHUB_REPO https://github.com/lnls-sirius/streamdevice-ioc.git

# Clear stream-ioc's database, interface, protocol and iocBoot folders.
RUN rm -rd ${TOP}/database/* && \
    rm -rd ${TOP}/interface/* && \
    rm -rd ${TOP}/protocol/* && \
    rm -rd ${TOP}/iocBoot/*

# Github Repo
RUN git clone ${GITHUB_REPO}

# Loop to keep the program alive
