# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory

FROM  lnlscon/epics-r3.15.5:asyn3.35
LABEL maintainer="Claudio Carneiro <claudio.carneiro@lnls.br>"

# Python3
RUN apt-get -y install swig        &&\
    apt-get -y install python3     &&\
    apt-get -y install python3-pip &&\
    pip3 install         \
        pandas==0.23.4   \
        pcaspy==0.7.2    \
        pyepics==3.3.2   \
        xlrd==1.2.0

# Epics auto addr list
ENV EPICS_CA_AUTO_ADDR_LIST=YES

ENV TOP=/opt/epics-R3.15.5/modules/StreamDevice-2.8.8

# Base procServ port
ENV BASE_PROCSERV_PORT=20400

RUN mkdir -p /opt/streamdevice-ioc/log

WORKDIR /opt/streamdevice-ioc

COPY logrotate.conf     /etc/logrotate.conf
RUN  chmod 644          /etc/logrotate.conf

COPY common             common
COPY scripts            scripts
COPY spreadsheet        spreadsheet

COPY agilent4uhv        agilent4uhv
COPY countingPRU        countingPRU
COPY mbtemp             mbtemp
COPY mks937b            mks937b
COPY spixconv           spixconv

# Run stuff
CMD ./scripts/run.sh ${DEVICE_FOLDER} ${DEVICE_PREFIX}
