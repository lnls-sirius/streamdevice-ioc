# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory

FROM lnlscon/epics-r3.15.5:latest
LABEL maintainer="Claudio Carneiro <claudio.carneiro@lnls.br>"

WORKDIR /opt/

RUN apt-get install -y telnet vim logrotate
RUN pip3 install pandas xlrd

# Epics auto addr list
ENV EPICS_CA_AUTO_ADDR_LIST=YES

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


# Clear stream-ioc's database, interface, protocol and iocBoot folders.
RUN rm -rd ${TOP}/database/*  && \
    rm -rd ${TOP}/interface/* && \
    rm -rd ${TOP}/protocol/*  && \
    rm -rd ${TOP}/iocBoot/*

# Run stuff
CMD ./scripts/run.sh ${DEVICE_FOLDER} ${DEVICE_PREFIX}
