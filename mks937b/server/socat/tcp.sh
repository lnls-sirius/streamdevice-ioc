#!/bin/bash

pipe=/tmp/tcpPipe
exitMsg="tcp.sh OFF"

if [[ ! -p $pipe ]]; then
    echo "Reader not running"
    exit 1
fi
 
trap cleanup EXIT 

cleanup(){
  echo "EXIT cleanup TCP"
  echo $exitMsg
  echo "Exiting TCP ..."
  exit 1
}

echo "tcp.sh ON" >$pipe
socat TCP-LISTEN:${SOCAT_TCP_PORT},fork,reuseaddr,nodelay,range=${SOCAT_TCP_RANGE} FILE:/dev/socatUSB1,b${SOCAT_BAUDRATE},rawer