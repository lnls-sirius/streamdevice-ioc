#!/bin/bash

# Bind using TCP
socat -d -d TCP-LISTEN:${SOCAT_PORT},fork,reuseaddr,nodelay,range=${SERVER_IP_ADDR}:${SERVER_MASK} FILE:/dev/ttyUSB0,b115200,rawer,crln
