# Sirius Stream Device IOCs

[![Lint](https://github.com/lnls-sirius/streamdevice-ioc/actions/workflows/lint.yml/badge.svg)](https://github.com/lnls-sirius/streamdevice-ioc/actions/workflows/lint.yml)

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

- Use micromamba to prepare the environment: `micromamba env create -f env.yml`
- Activate the environmet
- Run `make build`

## Deploy

The docker related files included in this repository are meant to build and test the images. Check the instructions at [docker-stacks/cons-streamdevice-ioc](https://gitlab.cnpem.br/gas/docker-stacks/tree/master/cons-streamdevice-ioc) for production deployment.

**Note**: the only IOC currently in deployment based on this version of the repository is the countingPRU IOC. Others still need testing, spreadsheet updates and figuring out startup (spixconv specifically, since the startup scripts don't have a consistent naming scheme).

[SPIxCONV](scripts/spixconv/docker/docker-compose.yml)

Some **environment variables** are available to the user:

|Env|Default|Desc|
|---|---|---|
|EPICS_IOC_CAPUTLOG_INET|0.0.0.0|EPICS Logging Inet (caput)|
|EPICS_IOC_CAPUTLOG_PORT|7012|EPICS Logging Port (caput)|
|EPICS_IOC_LOG_INET|0.0.0.0|EPICS Logging Inet (generic)|
|EPICS_IOC_LOG_PORT|7011|EPICS Logging Port (generic)|

If the **autosave** feature is used, the `*.sav` files directory should be mounted from host.

```bash
# *.sav files directory
/opt/streamdevice-ioc/autosave/save
```

**procServ** is using UNIX sockets. The `nc` app is already present in the image in order to access UNIX sockets.

```sh
nc -U <socket-path>
```

### etc..

Autosave data inside the container is located at `/opt/streamdevice-ioc/autosave/save/`
