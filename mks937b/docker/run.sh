#!/bin/sh
git pull
docker run -d \
    --network host \ 
    --name mks937b lnlscon/mks937b:latest

#docker run -d \
#    -p 5065:5065 \
#    -p 5064:5064 \
#    -e CMD='mks937_min.cmd' \
#    --name mks937b lnlscon/mks937b:latest


