#!/bin/bash
# Epics Base
apt-get -y install libreadline-gplv2-dev
cd /opt
mkdir epics-${EPICS_VERSION}
cd epics-${EPICS_VERSION}
wget https://epics.anl.gov/download/base/base-3.15.5.tar.gz
tar -xvzf base-3.15.5.tar.gz
rm base-3.15.5.tar.gz
mv base-3.15.5 base
cd base
make -j ${MAKE_JOBS}

cd ..
tree -d 