# Sirius Stream Device IOCs
This repository contains a system to generate large amounts of EPICS IOCs via string Templates,
using as input an Excel spreadsheet.

The following is a list of applications and ports:

|   Device  |Port|
|:---------:|:---:|
|spixconv   |5005|
|agilent4uhv|5004|
|mbtemp     |5003|
|mks937b    |5002|
|countingPRU|5000|


Add the following environment variables to a service in order to launch IOCs in different ports.<br>
The user must set the initial port value.

```
EPICS_CA_PORT_INCREASE=--epics-ca-port-increase
BASE_EPICS_CA_PORT=--base-epics-ca-port 5070
```
