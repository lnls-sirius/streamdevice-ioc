#!/bin/sh
git pull
docker run -d -p 4161:4161 -p 5065:5065/udp -p 5064:5064/udp \
    -e CMD='mks937_min.cmd' \
    --name mks937b lnlscon/mks937b:latest

# docker run -d \
#     -p 4161:4161 \
#     -e SOCAT_PORT=4161 \
#     -e DEVICE_IP_ADDRESS=10.0.28.69 \
#     -e RF_RING_SERIAL_PORT="/dev/rfRingSerial" \
#     -e PYTHONPATH=/root/cas-rf/sirius-cas-rf-ring/server \
# --name rf-ring lnlscon/rf-ring:latest
