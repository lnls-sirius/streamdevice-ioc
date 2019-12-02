# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory

FROM  lnlscon/epics-r3.15.6:v1.2
LABEL maintainer="Claudio Carneiro <claudio.carneiro@lnls.br>"

# Python3
RUN pip3 install pandas==0.23.4 xlrd==1.2.0

# Epics auto addr list
ENV EPICS_CA_AUTO_ADDR_LIST YES
ENV TOP ${STREAMDEVICE}

# Base procServ port
ENV EPICS_IOC_CAPUTLOG_INET 0.0.0.0
ENV EPICS_IOC_CAPUTLOG_PORT 7012

ENV EPICS_IOC_LOG_INET 0.0.0.0
ENV EPICS_IOC_LOG_PORT 7011

RUN mkdir -p /opt/streamdevice-ioc/log && \
    mkdir -p /opt/streamdevice-ioc/streamdevice-ioc-history && rm -rf ${STREAMDEVICE}/iocBoot/*

WORKDIR /opt/streamdevice-ioc

COPY logrotate.conf     /etc/logrotate.conf
RUN  chmod 644          /etc/logrotate.conf

COPY common             common
COPY spreadsheet        spreadsheet

COPY agilent4uhv        agilent4uhv
COPY countingPRU        countingPRU
COPY mbtemp             mbtemp
COPY mks937b            mks937b
COPY spixconv           spixconv
COPY dbd                dbd
COPY bin                bin
COPY dbd/stream.dbd     ${STREAMDEVICE}/dbd/stream.dbd
COPY dbd/streamApp.dbd  ${STREAMDEVICE}/dbd/streamApp.dbd
COPY Security.as        ${STREAMDEVICE}/log/Security.as

# Run stuff
CMD echo "Overwrite the command!" && ls -la ./bin && tail -f /dev/null