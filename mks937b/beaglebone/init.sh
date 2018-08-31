#!/bin/bash

# Bind using TCP
socat -d -d TCP-LISTEN:${SOCAT_PORT},reuseaddr,fork,nodelay,range=${SERVER_IP_ADDR}:${SERVER_MASK} FILE:${DEVICE},b${BAUDRATE},rawer
