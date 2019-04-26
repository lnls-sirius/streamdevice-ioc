# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory

#FROM lnlscon/epics-r3.15.5:latest
FROM ubuntu:18.04
LABEL maintainer="Claudio Carneiro <claudio.carneiro@lnls.br>"

WORKDIR /opt/
RUN apt-get update
RUN apt-get install -y          \
    telnet                      \
    vim                         \
    logrotate                   \
    build-essential             \
    vim                         \
    libpcre3-dev                \
    wget                        \
    git                         \
    libreadline-gplv2-dev       

RUN mkdir -p /opt/epics-R3.15.5

RUN wget -O /opt/epics-R3.15.5/base-3.15.5.tar.gz   \
    https://epics.anl.gov/download/base/base-3.15.5.tar.gz

WORKDIR /opt/epics-R3.15.5

# IOC operation variables
ENV TOP /opt/stream-ioc
ENV EPICS_VERSION R3.15.5
ENV ARCH linux-x86_64
ENV EPICS_HOST_ARCH linux-x86_64
ENV EPICS_BASE /opt/epics-${EPICS_VERSION}/base
ENV EPICS_CA_AUTO_ADDR_LIST YES
ENV EPICS_MODULES /opt/epics-${EPICS_VERSION}/modules

ENV ASYN /opt/epics-${EPICS_VERSION}/modules/asyn4-35
ENV CALC /opt/epics-${EPICS_VERSION}/modules/synApps/calc-R3-7-1
ENV PATH ${EPICS_BASE}/bin/${ARCH}:/opt/procServ:${PATH}

# Pyepics libca location
ENV PYEPICS_LIBCA ${EPICS_BASE}/lib/${ARCH}/libca.so

ENV STREAM_IOC_REPO https://github.com/lnls-sirius/stream-ioc.git

# Epics Base
RUN cd /opt/epics-R3.15.5           &&\
    tar -xvzf base-3.15.5.tar.gz    &&\
    rm base-3.15.5.tar.gz           &&\
    mv base-3.15.5 base             &&\
    cd base                         &&\
    make

# asynDriver
RUN cd ${EPICS_BASE}                &&\
    cd ..                           &&\
    mkdir modules                   &&\
    cd modules                      &&\
    wget https://www.aps.anl.gov/epics/download/modules/asyn4-35.tar.gz                     &&\
    tar -xvzf asyn4-35.tar.gz                                                               &&\
    rm asyn4-35.tar.gz                                                                      &&\
    sed -i -e '3,4s/^/#/' -e '8s/^/#/' -e '11s/^/#/' -e '14cEPICS_BASE='${EPICS_BASE} asyn4-35/configure/RELEASE &&\
    cat  asyn4-35/configure/RELEASE                                                         &&\
    cd asyn4-35                                                                             &&\
    make

# synApps Calc Module
RUN cd ${EPICS_BASE}/../modules                                                                                     &&\
    mkdir synApps                                                                                                   &&\
    cd synApps                                                                                                      &&\
    wget https://github.com/epics-modules/calc/archive/R3-7-1.tar.gz                                                &&\
    tar -xvzf R3-7-1.tar.gz                                                                                         &&\
    rm R3-7-1.tar.gz                                                                                                &&\
    sed -i -e '5s/^/#/' -e '7,8s/^/#/' -e '13s/^/#/' -e '20cEPICS_BASE='${EPICS_BASE} calc-R3-7-1/configure/RELEASE &&\
    cd calc-R3-7-1                                                                                                  &&\
    make

# Streamdevice
RUN cd ${EPICS_MODULES}                                                                         &&\
    mkdir StreamDevice-2.7.11                                                                   &&\
    cd StreamDevice-2.7.11                                                                      &&\
    echo '' | makeBaseApp.pl -t support && echo ''                                              &&\
    wget https://github.com/paulscherrerinstitute/StreamDevice/archive/stream_2_7_11.tar.gz     &&\
    tar -xvzf stream_2_7_11.tar.gz                                                              &&\
    rm stream_2_7_11.tar.gz                                                                     &&\
    sed -i -e '28iASYN='${ASYN} configure/RELEASE                                               &&\
    sed -i -e '29iCALC='${CALC} configure/RELEASE                                               &&\
    echo 'PCRE_INCLUDE=/usr/include' > configure/RELEASE.Common.linux-x86_64                    &&\
    echo 'PCRE_LIB=/usr/lib/x86_64-linux-gnu' >> configure/RELEASE.Common.linux-x86_64          &&\
    sed -i -e '20istreamApp_DBD += system.dbd' StreamDevice-stream_2_7_11/streamApp/Makefile    &&\
    rm StreamDevice-stream_2_7_11/GNUmakefile                                                   &&\
    sed -i -e '11iDIRS += StreamDevice-stream_2_7_11' Makefile                                  &&\
    make

# Stream-ioc
RUN cd /opt/                                                            &&\
    git clone --recursive ${STREAM_IOC_REPO}                            &&\
    rm stream-ioc/configure/RELEASE                                     &&\
    touch stream-ioc/configure/RELEASE                                  &&\
    echo "EPICS_BASE=${EPICS_BASE}" >> stream-ioc/configure/RELEASE     &&\
    echo "ASYN=${ASYN}" >> stream-ioc/configure/RELEASE                 &&\
    echo "CALC=${CALC}" >> stream-ioc/configure/RELEASE                 &&\
    cd stream-ioc                                                       &&\
    rm StreamDevice/GNUmakefile                                         &&\
    make

# Python3
RUN apt-get -y install swig                                             &&\
    apt-get -y install python3                                          &&\
    apt-get -y install python3-pip                                      &&\
    pip3 install pandas==0.23.4                                           \
        pcaspy==0.7.2                                                     \
        pyepics==3.3.2                                                    \
        xlrd==1.2.0

# Epics auto addr list
ENV EPICS_CA_AUTO_ADDR_LIST=YES

# Base procServ port
ENV BASE_PROCSERV_PORT=20400

RUN mkdir -p /opt/streamdevice-ioc/log

# set correct timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

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
