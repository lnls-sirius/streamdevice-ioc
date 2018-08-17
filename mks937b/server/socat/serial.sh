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

socat pty,rawer,echo=0,crnl,link=/dev/socatUSB0 pty,rawer,echo=0,crnl,link=/dev/socatUSB1