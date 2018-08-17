#!/bin/bash

pipe=/tmp/serialPipe
exitMsg="serial.sh OFF"

if [[ ! -p $pipe ]]; then
    echo "Reader not running"
    exit 1
fi

trap cleanup EXIT 

cleanup(){
  echo "EXIT cleanup Serial."
  echo $exitMsg
  echo "Exiting Serial..."
  exit 1
}

echo "serial.sh ON" >$pipe

socat pty,ispeed=115200,ospeed=115200,rawer,echo=0,crnl,link=/dev/socatUSB0 pty,ispeed=115200,ospeed=115200,rawer,echo=0,crnl,link=/dev/socatUSB1