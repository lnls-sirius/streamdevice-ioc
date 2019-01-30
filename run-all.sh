#!/bin/bash
source common/functions
export PATH=/opt/procServ:$PATH
export BASE_PROCSERV_PORT=20400
export TOP=/opt/stream-ioc

# Agilent 4UHV
run_ioc "UHV-"

# MKS 937b
run_ioc "MKS-"

# MBTemp
run_ioc "MBTemp-"

#Counting PRU
#run_ioc "CountingPRU-"
