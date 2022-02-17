# Sirius Stream Device IOCs

This repository contains a system to generate large amounts of EPICS IOCs via string Templates using as input an Excel spreadsheet.

The following is a list of applications and ports:

|Port|    Device    |
|:---|:-------------|
|5000|countingPRU   |
|5002|mks937b       |
|5003|mbtemp        |
|5004|agilent4uhv   |
|5005|spixconv      |
|5006|rackMonitoring|

## Building a new image

- Requires Python >= 3.6

```command
pip install openpyxl pandas
```

|                File                   |      Description      |
|---------------------------------------|-----------------------|
|[Dockerfile](Dockerfile)               | Target IOC            |
|Dockerfile.<ioc>               | Target IOC            |
|[Dockerfile.Stream](Dockerfile.Stream) | Base Streamdevice     |
|[Dockerfile.EPICS](Dockerfile.EPICS)   | EPICS base image      |

For each device supported, a tag must be created in order to mitigate conflicts.
Use `make` to build the image, editing the corresponding tag.

Some **environment variables** are available to the user:

|Env|Default|Desc|
|---|---|---|
|EPICS_IOC_CAPUTLOG_INET|0.0.0.0|EPICS Logging Inet (generic)|
|EPICS_IOC_CAPUTLOG_PORT|7012|EPICS Logging Port (generic)|
|EPICS_IOC_LOG_INET|0.0.0.0|EPICS Logging Inet (caput)|
|EPICS_IOC_LOG_PORT|7011|EPICS Logging Port (caput)|

If the **autosave** feature is used, the `*.sav` files directory should be mounted from host.

```bash
# *.sav files directory
/opt/streamdevice-ioc/autosave/save
```

The **procServ** may be using UNIX or TCP sockets. The `socat` app is already present in the image in order to access UNIX sockets.

```bash
socat - UNIX-CLIENT:<socket_path>
```

In order to access in case of TCP sockets, one may use `telnet`.

```bash
telnet <host> <port>
```

### Example:

In order to build a new mks937b image, edit the image tag of the corresponding service at [docker-compose.yml](./docker-compose.yml) so it will not overwrite when pushed to dockerhub.

Build a service:

```bash
docker-compose build <service_name>
```

## Deploy

The docker related files included in this repository are meant to build and test the images. Check the instructions at [docker-stacks/cons-streamdevice-ioc](https://gitlab.cnpem.br/con/docker-stacks/tree/master/cons-streamdevice-ioc) for production deployment.

[SPIxCONV](scripts/spixconv/docker/docker-compose.yml)

### etc..

Autosave data inside the container is located at `/opt/streamdevice-ioc/autosave/save/`
