#!/bin/bash

# Start the first process
./serial.sh -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start serial.sh: $status"
  exit $status
fi

sleep 2

# Start the second process
./tcp.sh -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start tcp.sh: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited. 
# Otherwise it loops forever, waking up every 60 seconds
while sleep 10; do
  if [${SERIAL_RUN} == 1]; then
    echo "Serial Process =  ${SERIAL_RUN}"
  fi
  if [${TCP_RUN} == 1]; then
    echo "TCP Process =  ${TCP_RUN}"
  fi
  # ps aux |grep serial.sh |grep -q -v grep
  # PROCESS_1_STATUS=$?
  # ps aux |grep tcp.sh |grep -q -v grep
  # PROCESS_2_STATUS=$?
  # # If the greps above find anything, they exit with 0 status
  # # If they are not both 0, then something is wrong
  # if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
  #   echo "One of the processes has already exited."
  #   exit 1
  # fi
done

