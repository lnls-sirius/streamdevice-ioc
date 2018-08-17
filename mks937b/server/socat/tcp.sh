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
socat TCP-LISTEN:4161,fork,reuseaddr,nodelay,range=10.0.6.43:255.255.255.0 FILE:/dev/socatUSB1,b115200,rawer