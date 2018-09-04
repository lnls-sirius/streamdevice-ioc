# Docker image for RAD Protection Probes on Sirius
#
# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory
#

# FROM lnls/epics-base:base-3.15-debian-9
FROM debian:stretch-slim

MAINTAINER Claudio Carneiro <claudio.carneiro@lnls.br>

WORKDIR /root/

# Github environment variables
ENV GITHUB_REPO https://github.com/carneirofc/sirius-temporary-dev-repo/
ENV HOME_DIR /root/sirius-temporary-dev-repo/mks937b
ENV STREAM_IOC_REPO https://github.com/lnls-sirius/stream-ioc.git
 
# IOC operation variables
ENV TOP /opt/stream-ioc
ENV EPICS_VERSION R3.15.5
ENV ARCH linux-x86_64

ENV EPICS_BASE /opt/epics-${EPICS_VERSION}/base
ENV EPICS_MODULES /opt/epics-${EPICS_VERSION}/modules
ENV ASYN /opt/epics-${EPICS_VERSION}/modules/asyn4-33
ENV CALC /opt/epics-${EPICS_VERSION}/modules/synApps/calc-R3-7-1
ENV PATH ${EPICS_BASE}:/opt/procServ:${PATH}


ENV CMD mks937_min.cmd

ENV MAKE_JOBS 32

# Pyepics libca location 
ENV PYEPICS_LIBCA ${EPICS_BASE}/lib/${ARCH}/libca.so
 
RUN mkdir /root/init
COPY init/ /root/init/

# Requirements File
COPY requirements.txt ./

# Python 3 Setup and procServ
RUN apt-get -y update && \
apt-get -y install swig && \
apt-get -y install python3 \
apt-get -y install python3-pip && \
pip3 install --no-cache-dir -r requirements.txt 

# Python 
RUN apt-get -y update && \
apt-get -y install swig && \
apt-get -y install python && \
apt-get -y install python-pip && \
pip install --no-cache-dir -r requirements.txt 

RUN  /bin/bash /root/init/install.sh 

# Clone Strem-Ioc
RUN git clone --recursive ${STREAM_IOC_REPO}

# Github Repo ... 
RUN cd /root/
RUN git clone ${GITHUB_REPO} 

# Loop to keep the program alive 
# CMD ["sh", "-c", "${HOME_DIR}/server/run.sh"]
CMD ["sh", "-c", "/root/init/loop.sh"]
