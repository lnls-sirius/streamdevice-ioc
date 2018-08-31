# Docker image for RAD Protection Probes on Sirius
#
# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory
#

FROM lnls/epics-base:base-3.15-debian-9

MAINTAINER Claudio Carneiro <claudio.carneiro@lnls.br>

# Github environment variables
ENV GITHUB_REPO https://github.com/carneirofc/sirius-temporary-dev-repo/
ENV HOME_DIR /home/controle/sirius-temporary-dev-repo/mks937b

# IOC operation variables
ENV IOC_FOLDER /opt/stream-ioc
ENV IOC_VERSION stream-ioc-1.0
ENV EPICS_BASE /opt/epics/base-3.15.5
ENV ASYN /opt/epics/base-3.15.5/modules/asyn4-33
ENV EPICS_HOST_ARCH linux-x86_64


# Pyepics libca location 
# ENV PYEPICS_LIBCA ${EPICS_BASE}/lib/${EPICS_HOST_ARCH}/libca.so

WORKDIR /root/

# System and service manager
# RUN  apt-get -y update && apt-get -y install systemd

# Requirements File
COPY requirements.txt ./

# Python 3 Setup and procServ
RUN apt-get -y update && \
apt-get -y install swig && \
apt-get -y update && \
apt-get -y install python3-pip && \
pip3 install --no-cache-dir -r requirements.txt && \
apt-get -y install procserv

# Clone and configure stream ioc
RUN cd /root/
RUN git clone ${GITHUB_REPO}
# COPY /home/controle/sirius-temporary-dev-repo /root/

# Loop to keep the program alive 
CMD ["sh", "-c", "${HOME_DIR}/server/run.sh"]