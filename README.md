# Sirius Stream Device IOCs
This repository contains a system to generate large amounts of EPICS IOCs via string Templates,
using as input an Excel spreadsheet.

The following is a list of applications and ports:

|   Device  |Port|
|:---------:|:---:|
|rackMonitoring   |5006|
|spixconv   |5005|
|agilent4uhv|5004|
|mbtemp     |5003|
|mks937b    |5002|
|countingPRU|5000|

## Building a new image

Two dockerfiles are used in order to build the containers.

|File|Description|
|:--:|:---------:|
|[Dockerfile](Dockerfile)|streamdevice-ioc files|
|[Dockerfile.EPICS](Dockerfile.EPICS)| EPICS base image|

For each device supported, a specific tag must be created in order to mitigate conflicts when multiple devices are changing. The recommended way to create a new tag is to build it via the `docker-compose` command.

### Example:
In order to build a new mks937b image, edit the image tag of the corresponding service at [docker-compose.yml](./docker-compose.yml) so it will not overwrite when pushed to dockerhub.

Build a service:
```
docker-compose build <service-name>
```

## Deploy
The docker related files included in this repository are meant to build and test the images. Check the instructions at [docker-stacks/cons-streamdevice-ioc](https://gitlab.cnpem.br/con/docker-stacks/tree/master/cons-streamdevice-ioc) for production deplyment.
