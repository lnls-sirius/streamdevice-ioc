#!/bin/python
from string import Template

relay = Template(
    """
# Setpoint Status
record(stringin,"$(DEVICE):Relay${RELAY}:SetpointStatus-Mon"){
    field(DESC, "Relay ${RELAY} setpoint status (clear/set)")
}

# Setpoint
record(ai, "$(DEVICE):Relay${RELAY}:Setpoint-RB"){
    field(DESC, "Read Setpoint for relay ${RELAY}")
    field(EGU,  "mBar")
    field(PINI, "YES")
    field(PHAS, "0")
    field(PRIO, "HIGH")
    field(DTYP, "stream")
    field(INP, "@mks937b.proto get_sp($(ADDRESS),${RELAY}) $(PORT)")
}
record(ao, "$(DEVICE):Relay${RELAY}:Setpoint-SP"){
    field(DESC, "Setpoint for relay ${RELAY}")
    field(EGU,  "mBar")
    field(DTYP, "stream")
    field(PHAS, "0")
    field(PRIO, "HIGH")
    field(OUT,  "@mks937b.proto set_sp($(ADDRESS),${RELAY}) $(PORT)")
    field(DISV, "1")
    field(SDIS, "$(DEVICE):Relay${RELAY}:Setpoint_INIT.PACT")
    field(FLNK, "$(DEVICE):Relay${RELAY}:Setpoint-RB")
}
record(seq, "$(DEVICE):Relay${RELAY}:Setpoint_INIT"){
    field(PINI, "YES")
    field(PHAS, "1")
    field(DLY1, "1")
    field(DOL1, "$(DEVICE):Relay${RELAY}:Setpoint-RB")
    field(LNK1, "$(DEVICE):Relay${RELAY}:Setpoint-SP PP")
}

# Hysteresis
record(ai, "$(DEVICE):Relay${RELAY}:Hyst-RB"){
    field(DESC, "Read Setpoint Hysteresis for relay ${RELAY}")
    field(EGU,  "mBar")
    field(PINI, "YES")
    field(PHAS, "0")
    field(PRIO, "HIGH")
    field(DTYP, "stream")
    field(INP, "@mks937b.proto get_relay_hyst($(ADDRESS),${RELAY}) $(PORT)")
}
record(ao, "$(DEVICE):Relay${RELAY}:Hyst-SP"){
    field(DESC, "Setpoint for relay Hysteresis ${RELAY}")
    field(EGU,  "mBar")
    field(PRIO, "HIGH")
    field(DTYP, "stream")
    field(OUT,  "@mks937b.proto set_relay_hyst($(ADDRESS),${RELAY}) $(PORT)")
    field(DISV, "1")
    field(SDIS, "$(DEVICE):Relay${RELAY}:Hyst_INIT.PACT")
    field(FLNK, "$(DEVICE):Relay${RELAY}:Hyst-RB")
}
record(seq, "$(DEVICE):Relay${RELAY}:Hyst_INIT"){
    field(PINI, "YES")
    field(PHAS, "1")
    field(DLY1, "1")
    field(DOL1, "$(DEVICE):Relay${RELAY}:Hyst-RB")
    field(LNK1, "$(DEVICE):Relay${RELAY}:Hyst-SP PP")
}

# Direction
record(mbbi, "$(DEVICE):Relay${RELAY}:Direction-RB"){
    field(DESC, "Direction for the relay ${RELAY}")
    field(DTYP, "stream")
    field(INP,  "@mks937b.proto get_relay_direction($(ADDRESS),${RELAY}) $(PORT)")
    field(PINI, "YES")
    field(PHAS, "0")
    field(PRIO, "HIGH")
    field(ZRVL, "0")
    field(ONVL, "1")
    field(ZRST, "ABOVE")
    field(ONST, "BELOW")
}
record(mbbo, "$(DEVICE):Relay${RELAY}:Direction-SP"){
    field(DESC, "Set the relay ${RELAY} direction")
    field(DTYP, "stream")
    field(OUT, "@mks937b.proto set_relay_direction($(ADDRESS),${RELAY}) $(PORT)")
    field(PRIO, "HIGH")

    field(UNSV, "INVALID")
    field(IVOA, "Don't drive outputs")

    field(ZRVL, "0")
    field(ONVL, "1")
    field(ZRST, "ABOVE")
    field(ONST, "BELOW")

    field(DISV, "1")
    field(SDIS, "$(DEVICE):Relay${RELAY}:Direction_INIT.PACT")

    field(FLNK, "$(DEVICE):Relay${RELAY}:Direction-RB")
}
record(seq, "$(DEVICE):Relay${RELAY}:Direction_INIT"){
    field(PINI, "YES")
    field(PHAS, "1")
    field(DLY1, "1")
    field(DOL1, "$(DEVICE):Relay${RELAY}:Direction-RB.RVAL")
    field(LNK1, "$(DEVICE):Relay${RELAY}:Direction-SP.RVAL PP")
}

# Relay Status
# In case the unit was changed at the ihm
record(mbbi, "$(DEVICE):Relay${RELAY}:Status-RB"){
    field(DESC, "Status of the relay ${RELAY}")
    field(DTYP, "stream")
    field(INP,  "@mks937b.proto get_relay_mode($(ADDRESS),${RELAY}) $(PORT)")
    field(PINI, "YES")
    field(PHAS, "0")
    field(PRIO, "HIGH")
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
    field(PRIO, "HIGH")

    field(UNSV, "INVALID")
    field(IVOA, "Don't drive outputs")

    field(ZRVL, "0")
    field(ONVL, "1")
    field(TWVL, "2")
    field(ZRST, "SET")
    field(ONST, "CLEAR")
    field(TWST, "ENABLE")

    field(DISV, "1")
    field(SDIS, "$(DEVICE):Relay${RELAY}:Status_INIT.PACT")

    field(FLNK, "$(DEVICE):Relay${RELAY}:Status-RB")
}
record(seq, "$(DEVICE):Relay${RELAY}:Status_INIT"){
    field(PINI, "YES")
    field(PHAS, "1")
    field(DLY1, "1")
    field(DOL1, "$(DEVICE):Relay${RELAY}:Status-RB.RVAL")
    field(LNK1, "$(DEVICE):Relay${RELAY}:Status-SP.RVAL PP")
}
"""
)
