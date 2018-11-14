#!/bin/python
from string import Template

relay = Template('''
# Setpoint Status
record(stringin,"$(DEVICE):Relay${RELAY}:SetpointStatus-Mon"){
	field(DESC, "Relay ${RELAY} setpoint status (clear/set)")
}

# Setpoint
record(ai, "$(DEVICE):Relay${RELAY}-RB"){
    field(DESC, "Read Setpoint for relay ${RELAY}") 
    field(PINI, "YES") 
    field(DTYP, "stream")
    field(INP, "@mks937b.proto get_sp($(ADDRESS),${RELAY}) $(PORT)")
}
record(ao, "$(DEVICE):Relay${RELAY}-SP"){
    field(DESC, "Setpoint for relay ${RELAY}") 
    field(DTYP, "stream")
    field(OUT,  "@mks937b.proto set_sp($(ADDRESS),${RELAY}) $(PORT)")
    field(FLNK, "$(DEVICE):Relay${RELAY}-RB")
}

# Hysteresis
record(ai, "$(DEVICE):Relay${RELAY}:Hyst-RB"){
    field(DESC, "Read Setpoint Hysteresis for relay ${RELAY}") 
    field(PINI, "YES") 
    field(DTYP, "stream")
    field(INP, "@mks937b.proto get_relay_hyst($(ADDRESS),${RELAY}) $(PORT)")
}
record(ao, "$(DEVICE):Relay${RELAY}:Hyst-SP"){
    field(DESC, "Setpoint for relay Hysteresis ${RELAY}")
    field(DTYP, "stream")
    field(OUT,"@mks937b.proto set_relay_hyst($(ADDRESS),${RELAY}) $(PORT)")
    field(FLNK, "$(DEVICE):Relay${RELAY}:Hyst-RB")
}
  
# Direction
record(mbbi, "$(DEVICE):Relay${RELAY}:Direction-RB"){
    field(DESC, "Direction for the relay ${RELAY}")
    field(DTYP, "stream")
    field(INP,  "@mks937b.proto get_relay_direction($(ADDRESS),${RELAY}) $(PORT)") 
    field(PINI, "YES") 

    field(ZRVL, "0")
    field(ONVL, "1")
    field(ZRST, "ABOVE")
    field(ONST, "BELOW")
}
record(mbbo, "$(DEVICE):Relay${RELAY}:Direction-SP"){
    field(DESC, "Set the relay ${RELAY} direction")
    field(DTYP, "stream")
    field(OUT, "@mks937b.proto set_relay_direction($(ADDRESS),${RELAY}) $(PORT)")
     
    field(UNSV, "INVALID")
    field(IVOA, "Don't drive outputs")

    field(ZRVL, "0")
    field(ONVL, "1")
    field(ZRST, "ABOVE")
    field(ONST, "BELOW")

    field(FLNK, "$(DEVICE):Relay${RELAY}:Direction-RB")
}
   
# Relay Status
# In case the unit was changed at the ihm
record(mbbi, "$(DEVICE):Relay${RELAY}:Status-RB"){
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
record(mbbo, "$(DEVICE):Relay${RELAY}:Status-SP"){
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

    field(FLNK, "$(DEVICE):Relay${RELAY}:Status-RB")
}

''')