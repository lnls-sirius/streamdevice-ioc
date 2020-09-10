# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory

FROM  lnlscon/epics-r3.15.8:v1.2 as stream
LABEL "maintainer"="Claudio Carneiro <claudio.carneiro@lnls.br>"
LABEL "repository"="https://github.com/lnls-sirius/streamdevice-ioc"
LABEL "br.com.lnls-sirius.description"="StreamDevice IOC"
LABEL "br.com.lnls-sirius.department"="CONS"
LABEL "br.com.lnls-sirius.maintener"="Claudio Ferreira Carneiro"

# Python3
RUN pip3 install pandas==0.23.4 xlrd==1.2.0

# VIM
RUN apt-get -y update && apt-get -y install procps vim socat

# Epics auto addr list
ENV EPICS_CA_AUTO_ADDR_LIST YES

# Base procServ port
ENV EPICS_IOC_CAPUTLOG_INET 0.0.0.0
ENV EPICS_IOC_CAPUTLOG_PORT 7012

ENV EPICS_IOC_LOG_INET 0.0.0.0
ENV EPICS_IOC_LOG_PORT 7011

ENV TOP /opt/streamdevice-ioc

RUN \
    mkdir -p ${TOP}/autosave/save &&\
    mkdir -p ${TOP}/log &&\
    mkdir -p ${TOP}/protocol &&\
    mkdir -p ${TOP}/sockets &&\
    mkdir -p ${TOP}/streamdevice-ioc-history

WORKDIR ${TOP}

COPY crontab            /etc/crontab
COPY logrotate.conf     /etc/logrotate.conf
RUN  chmod 644          /etc/logrotate.conf

COPY streamDeviceIOCApp streamDeviceIOCApp
COPY Makefile           Makefile
COPY configure          configure
COPY iocBoot            iocBoot
COPY procCtrl           /opt/procCtrl

RUN cd /opt/procCtrl && envsubst < configure/RELEASE.tmplt > configure/RELEASE &&\
    cat configure/RELEASE && make distclean && make clean && make -j$(nproc) &&\
    \
    cd ${TOP} && envsubst < configure/RELEASE.tmplt > configure/RELEASE && \
    make distclean && make clean && make -j$(nproc)

COPY scripts            scripts
COPY common             common
COPY spreadsheet        spreadsheet

CMD echo "Overwrite the command!" && ls -la ./scripts && tail -f /dev/null

FROM stream AS agilent4uhv
COPY agilent4uhv agilent4uhv
LABEL "br.com.lnls-sirius.device"="Agilent 4UHV"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/agilent.sh"]

FROM stream AS countingPRU
COPY countingPRU countingPRU
LABEL "br.com.lnls-sirius.device"="Counting PRU"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/countingPRU.sh"]

FROM stream AS mbtemp
COPY mbtemp mbtemp
LABEL "br.com.lnls-sirius.device"="MBTemp"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/mbtemp.sh"]

FROM stream AS mks937b
COPY mks937b mks937b
LABEL "br.com.lnls-sirius.device"="MKS937b"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/mks937b.sh"]

FROM stream AS rackMonitoring
COPY rackMonitoring     rackMonitoring
LABEL "br.com.lnls-sirius.device"="RackMonitoring"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/rackMonitoring.sh"]

FROM stream AS spixconv
COPY spixconv spixconv
LABEL "br.com.lnls-sirius.device"="SPIxCONV"
CMD ["/bin/bash", "/opt/streamdevice-ioc/scripts/spixconv.sh"]
