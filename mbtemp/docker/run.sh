#!/bin/sh
docker run -d \
    --network host \ 
    --name mbtemp lnlscon/mbtemp:latest
