#!/bin/bash

# Bind using TCP
#socat TCP-LISTEN:4161,fork,reuseaddr,nodelay FILE:/dev/ttyUSB0,b115200,raw

# Bind using UDP
socat UDP-LISTEN:4161,fork FILE:/dev/ttyUSB0,b115200,raw

