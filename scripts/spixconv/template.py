#!/usr/bin/env python3
from string import Template

docker_compose_prefix = """
version: "3.6"
x-swarm-settings: &swarm-settings
    image: ${STREAM_BASE_IMAGE}:${SPIXCONV_TAG}
    networks:
      - host_network
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints:
          - node.hostname != CA-RaCtrl-CO-Srv-1
          - node.hostname != LA-RaCtrl-CO-Srv-1
          - node.hostname != TA-TiRack-CO-FWSrv-1
    logging:
      driver: "json-file"
      options:
        max-file: "1"
        max-size: "50m"

networks:
  host_network:
    external:
      name: "host"

services:"""

docker_compose_tmplt = Template(
    """
  ${SERVICE}:
    <<: *swarm-settings
    environment:
      ADDRESS: ${ADDRESS}
      IOC_CMD: ${FILENAME}
      IOC_NAME: ${SERVICE}
      IOC_PREFIX: ${PREFIX}
    labels:
      spixconv.beaglebone.address: "${IP_ADDR}"
      spixconv.board.address: "${ADDRESS}"
      spixconv.description: "${DESCRIPTION}"
      spixconv.ioc.autosave: "${PREFIX}.sav"
      spixconv.ioc.cmd: "${FILENAME}"
      spixconv.ioc.db: "${DATABASE}"
      spixconv.ioc.delay: "${DELAY}"
      spixconv.ioc.prefix: "${PREFIX}"
      spixconv.ioc.scan_rate: "${SCAN_RATE}"
      spixconv.ioc.trigger: "${TRIGGER}"
      spixconv.ioc.voltage-factor: "${VOLTAGE_FACTOR}"
"""
)


top = Template(
    """#!../../bin/linux-x86_64/streamDeviceIOC
< envPaths

# ${DESCRIPTION}

epicsEnvSet("EPICS_IOC_LOG_INET", "$(EPICS_IOC_LOG_INET)")
epicsEnvSet("EPICS_IOC_LOG_PORT", "$(EPICS_IOC_LOG_PORT)")

# Database definition file
cd $(TOP)

dbLoadDatabase("dbd/streamDeviceIOC.dbd")
streamDeviceIOC_registerRecordDeviceDriver(pdbbase)
asSetFilename("$(TOP)/db/Security.as")

#==========================================================================
#                                       --prefix--
# Kicker:
#  - Ejection Kicker:                BO-48D:PU-EjeKckr
#  - Injection Kicker:               BO-01D:PU-InjKckr
#  - Injection Dipolar Kicker:       SI-01SA:PU-InjDpKckr
#  - Injection Non-Linear Kicker:    SI-01SA:PU-InjNLKckr
#
# Pinger:
#  - Vertical Pinger:                SI-19C4:PU-PingV
#
#  - Septum:
#  - Injection Septum:               TB-04:PU-InjSept
#  - Ejection Thick Septum:          TS-01:PU-EjeSeptG
#  - Ejection Thin Septum:           TS-01:PU-EjeSeptF
#  - Injection Thick Septum:         TS-04:PU-InjSeptG-1
#                                    TS-04:PU-InjSeptG-2
#  - Injection Thin Septum:          TS-04:PU-InjSeptF
#
#==========================================================================
drvAsynIPPortConfigure("socket_spixconv", "${IP_ADDR}")

# database for 10 kV Voltage source:
dbLoadRecords("db/${DATABASE}.db", "PREFIX=${PREFIX}, SCAN_RATE=${SCAN_RATE}, SPIxCONV_ADDRESS=${ADDRESS}, VOLTAGE_FACTOR=${VOLTAGE_FACTOR}, STEP_DELAY=${DELAY}, STEP_TRIGGER=${TRIGGER}")
dbLoadRecords("db/SPIxCONV_Config.db", "P=${PREFIX}")
"""
)

bot = Template(
    """

# Effectively initializes the IOC
cd iocBoot
iocInit
iocLogInit
caPutLogInit "$(EPICS_IOC_CAPUTLOG_INET):$(EPICS_IOC_CAPUTLOG_PORT)" 2

cd ..
"""
)
