#!/bin/bash
# Sys Upgrade
apt-get -y update
apt-get -y update && \
apt-get -y upgrade && \
apt-get -y dist-upgrade && \
apt-get -y autoremove && \
apt-get clean
