#!/bin/bash

# Communication pipes
serialPipe=/tmp/serialPipe
tcpPipe=/tmp/tcpPipe

trap cleanup EXIT 

cleanup(){
  echo "EXIT cleanup."
  rm -f $serialPipe
  rm -f $tcpPipe
  pkill -f serial.sh
  pkill -f tcp.sh
  echo "Exiting ..."
  exit 1
}

if [[ ! -p $serialPipe ]]; then
    mkfifo $serialPipe
fi

if [[ ! -p $tcpPipe ]]; then
    mkfifo $tcpPipe
fi


sleep 2

# Start the first process
./serial.sh &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start serial.sh: $status"
  exit $status
fi

sleep 2

# Start the second process
./tcp.sh &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start tcp.sh: $status"
  exit $status
fi


echo "Init !"

# Naive check runs checks once a minute to see if either of the processes exited. 
# Otherwise it loops forever, waking up every x seconds
while sleep 1; do 
  if read line <$serialPipe; then
      if [[ "$line" == 'serial.sh OFF' ]]; then
          echo $line 
          cleanup
          exit 1
      fi
      echo $line
  fi

  if read line <$tcpPipe; then
      if [[ "$line" == 'tcp.sh OFF' ]]; then
          echo $line 
          cleanup
          exit 1
      fi
      echo $line
  fi 

done

