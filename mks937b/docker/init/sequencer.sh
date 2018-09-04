
#!/bin/bash
# Sequencer 
apt-get -y install re2c
cd ${EPICS_MODULES}
wget http://www-csr.bessy.de/control/SoftDist/sequencer/releases/seq-2.2.6.tar.gz
tar -xvzf seq-2.2.6.tar.gz
rm seq-2.2.6.tar.gz
sed -i -e '6cEPICS_BASE='${EPICS_BASE} seq-2.2.6/configure/RELEASE
cd seq-2.2.6
make -j ${MAKE_JOBS}
