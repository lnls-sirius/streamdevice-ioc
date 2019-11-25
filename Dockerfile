# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory

FROM  lnlscon/epics-r3.15.6:v1.1
LABEL maintainer="Claudio Carneiro <claudio.carneiro@lnls.br>"

# Python3
RUN apt-get update  --fix-missing  &&\
    apt-get -y install swig        &&\
    apt-get -y install python3     &&\
    apt-get -y install python3-pip &&\
    pip3 install         \
        pandas==0.23.4   \
        xlrd==1.2.0

# Epics auto addr list
ENV EPICS_CA_AUTO_ADDR_LIST YES
ENV TOP ${STREAMDEVICE}

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
COPY dbd                dbd

# Run stuff
CMD ./scripts/run.sh ${DEVICE_FOLDER} ${DEVICE_PREFIX}
