#!/bin/python
from string import Template

################################################################################
# RELAY
################################################################################
# READ ONLY
################################################################################

relay = Template('''
record(ai, "$(DEVICE):RelayRb-${RELAY}") {
    field(DESC, "Read Setpoint for relay ${RELAY}") 
    field(PINI, "YES") 
    field(DTYP, "stream")
    field(INP,"@mks937b.proto get_sp($(ADDRESS),${RELAY}) $(PORT)")
}
record(ao, "$(DEVICE):RelaySp-${RELAY}") {
    field(DESC, "Setpoint for relay ${RELAY}") 
    field(DTYP, "stream")
    field(OUT,"@mks937b.proto set_sp($(ADDRESS),${RELAY}) $(PORT)")
    field(FLNK, "$(DEVICE):RelayRb-${RELAY}")
}

# Hysteresis
record(ai, "$(DEVICE):RelayHystRb-${RELAY}") {
    field(DESC, "Read Setpoint Hysteresis for relay ${RELAY}") 
    field(PINI, "YES") 
    field(DTYP, "stream")
    field(INP,"@mks937b.proto get_relay_hyst($(ADDRESS),${RELAY}) $(PORT)")
}
record(ao, "$(DEVICE):RelayHystSp-${RELAY}") {
    field(DESC, "Setpoint for relay Hysteresis ${RELAY}")
    field(DTYP, "stream")
    field(OUT,"@mks937b.proto set_relay_hyst($(ADDRESS),${RELAY}) $(PORT)")
    field(FLNK, "$(DEVICE):RelayHystRb-${RELAY}")
}
  
# Direction
record(mbbi, "$(DEVICE):RelayDirectionRb-${RELAY}") {
  field(DESC, "Direction for the relay ${RELAY}")
  field(DTYP, "stream")
  field(INP,  "@mks937b.proto get_relay_direction($(ADDRESS),${RELAY}) $(PORT)") 
  field(PINI, "YES") 
  
  field(ZRVL, "0")
  field(ONVL, "1")
  field(ZRST, "ABOVE")
  field(ONST, "BELOW")
}
record(mbbo, "$(DEVICE):RelayDirectionSp-${RELAY}"){
    field(DESC, "Set the relay ${RELAY} direction")
    field(DTYP, "stream")
    field(OUT, "@mks937b.proto set_relay_direction($(ADDRESS),${RELAY}) $(PORT)")
     
    field(UNSV, "INVALID")
    field(IVOA, "Don't drive outputs")

    field(ZRVL, "0")
    field(ONVL, "1")
    field(ZRST, "ABOVE")
    field(ONST, "BELOW")

    field(FLNK, "$(DEVICE):RelayDirectionRb-${RELAY}")
}
   
# Relay Status
# In case the unit was changed at the ihm
record(mbbi, "$(DEVICE):RelayStatusRb-${RELAY}") {
  field(DESC, "Status of the relay ${RELAY}")
  field(DTYP, "stream")
  field(INP,  "@mks937b.proto get_relay_mode($(ADDRESS),${RELAY}) $(PORT)") 
  field(PINI, "YES") 
  
  field(ZRVL, "0")
  field(ONVL, "1")
  field(TWVL, "2")
  field(ZRST, "SET")
  field(ONST, "CLEAR")
  field(TWST, "ENABLE")
} 
record(mbbo, "$(DEVICE):RelayStatusSp-${RELAY}"){
    field(DESC, "Set relay ${RELAY} status")
    field(DTYP, "stream")
    field(OUT, "@mks937b.proto set_relay_mode($(ADDRESS),${RELAY}) $(PORT)")

    field(UNSV, "INVALID")
    field(IVOA, "Don't drive outputs")

    field(ZRVL, "0")
    field(ONVL, "1")
    field(TWVL, "2")
    field(ZRST, "SET")
    field(ONST, "CLEAR")
    field(TWST, "ENABLE")

    field(FLNK, "$(DEVICE):RelayStatusRb-${RELAY}")
}

''')