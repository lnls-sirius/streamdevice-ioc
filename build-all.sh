#!/bin/bash
source common/functions
export TOP=/opt/stream-ioc

# Params: Folder CMD_KEY Base Epics CA Port

# Agilent 4UHV
build "agilent4uhv" "UHV-" "5400"

# MKS 937b
build "mks937b" "MKS-" "5600"

# MBTemp
build "mbtemp" "MBTemp-" "5800"