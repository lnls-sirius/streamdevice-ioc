#!/bin/sh
git pull
docker run -d \
    -p 4161:4161 \
    -p 5065:5065/udp \
    -p 5064:5064/udp \
    -e CMD='mks937_min.cmd' \
    --name mks937b lnlscon/mks937b:latest
