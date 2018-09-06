# Docker image for RAD Protection Probes on Sirius
#
# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory
#

FROM lnlscon/epics-r3.15.5:latest

MAINTAINER Claudio Carneiro <claudio.carneiro@lnls.br>

WORKDIR /root/

# Github environment variables
ENV GITHUB_REPO https://github.com/carneirofc/sirius-temporary-dev-repo/
ENV HOME_DIR /root/sirius-temporary-dev-repo/mks937b
ENV BASE_PROCSERV_PORT=20200 

ENV MAKE_JOBS 32
  
# Github Repo ... 
RUN cd /root/
RUN git clone ${GITHUB_REPO} 

# Loop to keep the program alive 
CMD ["sh", "-c", "${HOME_DIR}/server/run.sh"]
