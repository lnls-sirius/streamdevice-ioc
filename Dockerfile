# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory

FROM  lnlscon/epics-r3.15.8:v1.0
LABEL maintainer="Claudio Carneiro <claudio.carneiro@lnls.br>"

# Python3
RUN pip3 install pandas==0.23.4 xlrd==1.2.0

# VIM
RUN apt-get -y update && apt-get -y install procps vim

# Epics auto addr list
ENV EPICS_CA_AUTO_ADDR_LIST YES

# Base procServ port
ENV EPICS_IOC_CAPUTLOG_INET 0.0.0.0
ENV EPICS_IOC_CAPUTLOG_PORT 7012

ENV EPICS_IOC_LOG_INET 0.0.0.0
ENV EPICS_IOC_LOG_PORT 7011

RUN mkdir -p /opt/streamdevice-ioc/log &&\
    mkdir -p ${STREAMDEVICE}/autosave/save &&\
    mkdir -p /opt/streamdevice-ioc/streamdevice-ioc-history

ENV TOP /opt/streamdevice-ioc
WORKDIR /opt/streamdevice-ioc

COPY logrotate.conf     /etc/logrotate.conf
RUN  chmod 644          /etc/logrotate.conf

COPY streamDeviceIOCApp streamDeviceIOCApp
COPY Makefile           Makefile
COPY configure          configure
COPY iocBoot            iocBoot

RUN envsubst < configure/RELEASE.tmplt > configure/RELEASE && mkdir protocol && mkdir autosave
RUN make distclean && make clean && make &&\
    cat iocBoot/iocStreamDeviceIOC/envPaths

COPY agilent4uhv        agilent4uhv
COPY bin/*              bin/
COPY common             common
COPY countingPRU        countingPRU
COPY mbtemp             mbtemp
COPY mks937b            mks937b
COPY rackMonitoring     rackMonitoring
COPY spixconv           spixconv
COPY spreadsheet        spreadsheet

# Run stuff
CMD echo "Overwrite the command!" && ls -la ./bin && tail -f /dev/null
