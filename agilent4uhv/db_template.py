#!/usr/bin/python3
from string import Template

channel = Template("""
# Agilent-4UHV-Channel.db

# Record definition file for one Agilent 4UHV Ion Pump Controller channel. This is based on the work
# of Pete Owens from the Science and Technology Facilities Council (STFC).

# Parameters are:
#
# CHANNEL_NUMBER - Controller channel (from 1 to 4).
#
# PORT - Name of the serial port configured in asynDriver.
#
# PREFIX - Prefix name for all PVs associated with the channel.
#
# SERIAL_ADDRESS - Controller RS-485 serial address (from 0 to 31). For configuring this parameter,
# add 128 to the desired address. As an example, for the serial address 20, this parameter should
# be configured as 128 + 20 = 148.

############################################################################
##                              Scan Readings                             ##
############################################################################
# Current
record(ai, "$(PREFIX):Current-Mon") {
    field(DESC, "Measured current")
    field(DTYP, "stream")
    field(EGU, "A")
    field(HOPR, "0.9")
    field(LOPR, "0")

    field(INP, "@Agilent-4UHV.proto currentMon($(SERIAL_ADDRESS),$(CHANNEL_NUMBER)) $(PORT)")
}
# Pressure
record(ai, "$(PREFIX):Pressure-Mon") {
    field(DESC, "Measured pressure")
    field(DTYP, "stream")
    field(EGU, "mBar")
    field(PREC, "9")

    field(INP, "@Agilent-4UHV.proto pressureMon($(SERIAL_ADDRESS),$(CHANNEL_NUMBER)) $(PORT)")
}
# Voltage
record(ai, "$(PREFIX):Voltage-Mon") {
    field(DESC, "Measured voltage")
    field(DTYP, "stream")
    field(EGU, "kV")
    field(ESLO, "0.001")
    field(HOPR, "10")
    field(LOPR, "0")
    field(LINR, "LINEAR")
    field(PREC, "1")

    field(INP, "@Agilent-4UHV.proto voltageMon($(SERIAL_ADDRESS),$(CHANNEL_NUMBER)) $(PORT)")
}
# HV temperature
record(longin, "$(PREFIX):HVTemperature-Mon") {
    field(DESC, "HV temperature")
    field(DTYP, "stream")
    field(EGU, "°C")
    field(HOPR, "200")
    field(LOPR, "0")
    field(INP, "@Agilent-4UHV.proto HVTemperature$(CHANNEL_NUMBER)Mon($(SERIAL_ADDRESS)) $(PORT)")
}
# Error code
record(mbbi, "$(PREFIX):ErrorCode-Mon") {
    field(DESC, "Error code")
    field(DTYP, "stream")
    field(INP,  "@Agilent-4UHV.proto errorCodeMon($(SERIAL_ADDRESS),$(CHANNEL_NUMBER)) $(PORT)")
}
# Error code
record(mbbi, "$(PREFIX):SetErrorCode-Mon") {
    field(VAL, "0")
    field(ZRST, "")
    field(ONST, "")
    field(TWST, "Unknown Window")
    field(THST, "Data Type Error")
    field(FRST, "Out of Range")
    field(FVST, "Win Disabled")
}
############################################################################
##                             Get/Set Readings                           ##
############################################################################
# Channel HV on/off
record(mbbi, "$(PREFIX):HVState-RB") {
    field(DESC, "Channel HV on/off readback")
    field(DTYP, "stream")
    field(INP, "@Agilent-4UHV.proto getHVOnOff($(SERIAL_ADDRESS),$(CHANNEL_NUMBER)) $(PORT)")

    field(ZRVL, "0")
    field(ONVL, "1")

    field(ZRST, "OFF")
    field(ONST, "ON")
}
record(mbbo, "$(PREFIX):HVState-SP") {
    field(DESC, "Channel HV on/off setpoint")
    field(DTYP, "stream")
    field(OUT, "@Agilent-4UHV.proto setHVOnOff($(SERIAL_ADDRESS),$(CHANNEL_NUMBER),$(PREFIX):SetErrorCode-Mon) $(PORT)")

    field(ZRVL, "0")
    field(ONVL, "1")

    field(ZRST, "OFF")
    field(ONST, "ON")

    field(FLNK, "$(PREFIX):HVState-RB")
}
# Device number
record(longin, "$(PREFIX):DeviceNumber-RB") {
    field(DESC, "Device number readback")
    field(DTYP, "stream")
    field(PINI, "YES")
    field(INP, "@Agilent-4UHV.proto getDeviceNumber($(SERIAL_ADDRESS),$(CHANNEL_NUMBER)) $(PORT)")
}
# I Protect
record(ai, "$(PREFIX):CurrentProtect-RB") {
    field(DESC, "Measured Current Protect")
    field(DTYP, "stream")
    field(EGU, "mA")
    field(INP, "@Agilent-4UHV.proto getIProtect($(SERIAL_ADDRESS),$(CHANNEL_NUMBER)) $(PORT)")
}
record(ao, "$(PREFIX):CurrentProtect-SP") {
    field(DESC, "Measured Current Protect")
    field(DTYP, "stream")
    field(EGU, "mA")
    field(DRVH, "100")
    field(DRVL, "1")
    field(OUT, "@Agilent-4UHV.proto setIProtect($(SERIAL_ADDRESS),$(CHANNEL_NUMBER),$(PREFIX):SetErrorCode-Mon) $(PORT)")

    field(FLNK, "$(PREFIX):CurrentProtect-RB")
}
# V Target
record(ai, "$(PREFIX):VoltageTarget-RB") {
    field(DESC, "Voltage Target")
    field(DTYP, "stream")
    field(EGU, "V")
    field(INP, "@Agilent-4UHV.proto getVTarget($(SERIAL_ADDRESS),$(CHANNEL_NUMBER)) $(PORT)")
}
record(ao, "$(PREFIX):VoltageTarget-SP") {
    field(DESC, "Voltage Target")
    field(DTYP, "stream")
    field(EGU, "V")
    field(DRVH, "7000")
    field(DRVL, "3000")
    field(OUT, "@Agilent-4UHV.proto setVTarget($(SERIAL_ADDRESS),$(CHANNEL_NUMBER),$(PREFIX):SetErrorCode-Mon) $(PORT)")

    field(FLNK, "$(PREFIX):VoltageTarget-RB")
}
# Power Max
record(ai, "$(PREFIX):PowerMax-RB") {
    field(DESC, "Power Max")
    field(DTYP, "stream")
    field(EGU, "W")
    field(INP, "@Agilent-4UHV.proto getPowerMax($(SERIAL_ADDRESS),$(CHANNEL_NUMBER)) $(PORT)")
}
record(ao, "$(PREFIX):PowerMax-SP") {
    field(DESC, "Power Max")
    field(DTYP, "stream")
    field(EGU, "W")

    field(DRVH, "80")
    field(DRVL, "20")
    field(OUT, "@Agilent-4UHV.proto setPowerMax($(SERIAL_ADDRESS),$(CHANNEL_NUMBER),$(PREFIX):SetErrorCode-Mon) $(PORT)")

    field(FLNK, "$(PREFIX):PowerMax-RB")
}
# Setpoint
record(ai, "$(PREFIX):Setpoint-RB") {
    field(DESC, "Setpoint")
    field(DTYP, "stream")
    field(INP, "@Agilent-4UHV.proto getSepoint($(SERIAL_ADDRESS),$(CHANNEL_NUMBER)) $(PORT)")
}
record(ao, "$(PREFIX):Setpoint-SP") {
    field(DESC, "Setpoint")
    field(DTYP, "stream")
    field(OUT, "@Agilent-4UHV.proto setSepoint($(SERIAL_ADDRESS),$(CHANNEL_NUMBER),$(PREFIX):SetErrorCode-Mon) $(PORT)")

    field(FLNK, "$(PREFIX):Setpoint-RB")
}
""")

device = Template("""
# Agilent-4UHV-Device.db

# Record definition file for one Agilent 4UHV Ion Pump Controller device. This is based on the work
# of Pete Owens from the Science and Technology Facilities Council (STFC).

# Parameters are:
#
# PORT - Name of the serial port configured in asynDriver.
#
# PREFIX - Prefix name for all PVs associated with the device.
#
# SERIAL_ADDRESS - Controller RS-485 serial address (from 0 to 31). For configuring this parameter,
# add 128 to the desired address. As an example, for the serial address 20, this parameter should be
# configured as 128 + 20 = 148.

##########################################################################
#                              One time reading                          #
##########################################################################
record(ai, "$(PREFIX):TriggerOneTime"){
	field(FLNK, "$(PREFIX):Model-Cte")
}
# Model
record(stringin, "$(PREFIX):Model-Cte") {
    field(DESC, "Device model")
    field(DTYP, "stream")
    field(INP, "@Agilent-4UHV.proto getModel($(SERIAL_ADDRESS)) $(PORT)")

    field(FLNK, "$(PREFIX):SerialNumber-Cte")
}
# Serial number
record(stringin, "$(PREFIX):SerialNumber-Cte") {
    field(DESC, "Device serial number")
    field(DTYP, "stream")
    field(INP, "@Agilent-4UHV.proto getSerialNumber($(SERIAL_ADDRESS)) $(PORT)")

    field(FLNK, "$(PREFIX):OutOneTime")
}
record(bi, "$(PREFIX):Mode-RB") {
    field(PINI, "YES")
}
record(mbbi, "$(PREFIX_CH1):HVState-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH1):PowerMax-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH1):CurrentProtect-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH1):VoltageTarget-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH1):Setpoint-RB") {
    field(PINI, "YES")
}
record(mbbi, "$(PREFIX_CH2):HVState-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH2):PowerMax-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH2):CurrentProtect-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH2):VoltageTarget-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH2):Setpoint-RB") {
    field(PINI, "YES")
}
record(mbbi, "$(PREFIX_CH3):HVState-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH3):PowerMax-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH3):CurrentProtect-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH3):VoltageTarget-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH3):Setpoint-RB") {
    field(PINI, "YES")
}
record(mbbi, "$(PREFIX_CH4):HVState-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH4):PowerMax-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH4):CurrentProtect-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH4):VoltageTarget-RB") {
    field(PINI, "YES")
}
record(ai, "$(PREFIX_CH4):Setpoint-RB") {
    field(PINI, "YES")
}

##########################################################################
#                              CHAIN READINGS                            #
##########################################################################
record(longin, "$(PREFIX):FanTemperature-Mon") {
    field(DESC, "Fan temperature")
    field(DTYP, "stream")
    field(EGU, "°C")
    field(HOPR, "200")
    field(LOPR, "0")

    field(INP, "@Agilent-4UHV.proto fanTemperatureMon($(SERIAL_ADDRESS)) $(PORT)")
}
# Protect
record(longin, "$(PREFIX):Protect-Mon") {
    field(DESC, "Protect")
    field(DTYP, "stream")
    field(INP, "@Agilent-4UHV.proto protectMon($(SERIAL_ADDRESS)) $(PORT)")
}
# Step mode
record(longin, "$(PREFIX):Step-Mon") {
    field(DESC, "Step mode")
    field(DTYP, "stream")
    field(INP, "@Agilent-4UHV.proto stepMon($(SERIAL_ADDRESS)) $(PORT)")
}

##########################################################################
##                             Set/Get Readings                         ##
##########################################################################
# Unit readback
record(mbbi, "$(PREFIX):Unit-RB") {
    field(DESC, "Unit readback")
    field(DTYP, "stream")
    field(INP, "@Agilent-4UHV.proto getUnit($(SERIAL_ADDRESS)) $(PORT)")
    field(PINI,"YES")

    field(ZRST, "Torr")
    field(ONST, "mbar")
    field(TWST, "Pa")
}
# Unit setpoint
record(mbbo, "$(PREFIX):Unit-SP") {
    field(DESC, "Unit setpoint")
    field(DTYP, "stream")
    field(OUT, "@Agilent-4UHV.proto setUnit($(SERIAL_ADDRESS)) $(PORT)")

    field(ZRST, "Torr")
    field(ONST, "mbar")
    field(TWST, "Pa")

    field(FLNK,"$(PREFIX):Unit-RB")
}

# Operating mode (autostart on/off) readback
record(bi, "$(PREFIX):Mode-RB") {
    field(DESC, "Autostart readback")
    field(DTYP, "stream")
    field(INP, "@Agilent-4UHV.proto getMode($(SERIAL_ADDRESS)) $(PORT)")
    field(ONAM, "On")
    field(ZNAM, "Off")

}
# Operating mode (autostart on/off) setpoint
record(bo, "$(PREFIX):Mode-SP") {
    field(DESC, "Autostart setpoint")
    field(DTYP, "stream")
    field(ONAM, "On")
    field(OUT,  "@Agilent-4UHV.proto setMode($(SERIAL_ADDRESS)) $(PORT)")
    field(ZNAM, "Off")

    # field(FLNK, "$(PREFIX):Mode-RB")
}

############################################################################
#                                  CHAIN                                   #
#               PREFIX_CH1  PREFIX_CH2  PREFIX_CH3  PREFIX_CH4             #
############################################################################
record(ai, "$(PREFIX):Trigger"){
	field(FLNK, "$(PREFIX):Protect-Mon")
}
record(longin, "$(PREFIX):Protect-Mon") {
    field(FLNK, "$(PREFIX):FanTemperature-Mon")
}
record(longin, "$(PREFIX):FanTemperature-Mon") {
    field(FLNK, "$(PREFIX):Step-Mon")
}
record(longin, "$(PREFIX):Step-Mon") {
    field(FLNK, "$(PREFIX_CH1):Current-Mon")
}
record(ai, "$(PREFIX_CH1):Current-Mon") {
    field(FLNK, "$(PREFIX_CH1):Pressure-Mon")
}
record(ai, "$(PREFIX_CH1):Pressure-Mon") {
    field(FLNK, "$(PREFIX_CH1):Voltage-Mon")
}
record(ai, "$(PREFIX_CH1):Voltage-Mon") {
    field(FLNK, "$(PREFIX_CH1):HVTemperature-Mon")
}
record(longin, "$(PREFIX_CH1):HVTemperature-Mon") {
    field(FLNK, "$(PREFIX_CH1):ErrorCode-Mon")
}
record(mbbi, "$(PREFIX_CH1):ErrorCode-Mon") {
    field(FLNK, "$(PREFIX_CH2):Current-Mon")
}
record(ai, "$(PREFIX_CH2):Current-Mon") {
    field(FLNK, "$(PREFIX_CH2):Pressure-Mon")
}
record(ai, "$(PREFIX_CH2):Pressure-Mon") {
    field(FLNK, "$(PREFIX_CH2):Voltage-Mon")
}
record(ai, "$(PREFIX_CH2):Voltage-Mon") {
    field(FLNK, "$(PREFIX_CH2):HVTemperature-Mon")
}
record(longin, "$(PREFIX_CH2):HVTemperature-Mon") {
    field(FLNK, "$(PREFIX_CH2):ErrorCode-Mon")
}
record(mbbi, "$(PREFIX_CH2):ErrorCode-Mon") {
    field(FLNK, "$(PREFIX_CH3):Current-Mon")
}
record(ai, "$(PREFIX_CH3):Current-Mon") {
    field(FLNK, "$(PREFIX_CH3):Pressure-Mon")
}
record(ai, "$(PREFIX_CH3):Pressure-Mon") {
    field(FLNK, "$(PREFIX_CH3):Voltage-Mon")
}
record(ai, "$(PREFIX_CH3):Voltage-Mon") {
    field(FLNK, "$(PREFIX_CH3):HVTemperature-Mon")
}
record(longin, "$(PREFIX_CH3):HVTemperature-Mon") {
    field(FLNK, "$(PREFIX_CH3):ErrorCode-Mon")
}
record(mbbi, "$(PREFIX_CH3):ErrorCode-Mon") {
    field(FLNK, "$(PREFIX_CH4):Current-Mon")
}
record(ai, "$(PREFIX_CH4):Current-Mon") {
    field(FLNK, "$(PREFIX_CH4):Pressure-Mon")
}
record(ai, "$(PREFIX_CH4):Pressure-Mon") {
    field(FLNK, "$(PREFIX_CH4):Voltage-Mon")
}
record(ai, "$(PREFIX_CH4):Voltage-Mon") {
    field(FLNK, "$(PREFIX_CH4):HVTemperature-Mon")
}
record(longin, "$(PREFIX_CH4):HVTemperature-Mon") {
    field(FLNK, "$(PREFIX_CH4):ErrorCode-Mon")
}
record(mbbi, "$(PREFIX_CH4):ErrorCode-Mon") {
    field(FLNK, "$(PREFIX):Out")
}
""")
sync_1 = Template("""
###########################################################################
#                                SYNC SCAN                                #
###########################################################################
record(ai , "$(PREFIX_D1):TriggerOneTime"){
    field(PINI, "YES")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D1):OutOneTime"){
	field(FLNK, "$(PREFIX_D1):Trigger")
    field(MDEL,"-1")
}

#   SYNC SCAN LOOP
record(ai , "$(PREFIX_D1):Trigger"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D1):Out"){
	field(FLNK, "$(PREFIX_D1):Trigger")
    field(MDEL,"-1")
}
""")
sync_2 = Template("""
###########################################################################
#                                SYNC SCAN                                #
#                           PREFIX_D1  PREFIX_D2                          #
###########################################################################
record(ai , "$(PREFIX_D1):TriggerOneTime"){
    field(PINI, "YES")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D1):OutOneTime"){
	field(FLNK, "$(PREFIX_D2):TriggerOneTime")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):TriggerOneTime"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):OutOneTime"){
	field(FLNK, "$(PREFIX_D1):Trigger")
    field(MDEL,"-1")
}

#   SYNC SCAN LOOP
record(ai , "$(PREFIX_D1):Trigger"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D1):Out"){
	field(FLNK, "$(PREFIX_D2):Trigger")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):Trigger"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):Out"){
	field(FLNK, "$(PREFIX_D1):Trigger")
    field(MDEL,"-1")
}
""")

sync_3 = Template("""
###########################################################################
#                                SYNC SCAN                                #
#                      PREFIX_D1 PREFIX_D2 PREFIX_D3                      #
###########################################################################
record(ai , "$(PREFIX_D1):TriggerOneTime"){
    field(PINI, "YES")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D1):OutOneTime"){
	field(FLNK, "$(PREFIX_D2):TriggerOneTime")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):TriggerOneTime"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):OutOneTime"){
	field(FLNK, "$(PREFIX_D3):TriggerOneTime")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D3):TriggerOneTime"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D3):OutOneTime"){
    field(FLNK, "$(PREFIX_D1):Trigger")
	field(MDEL,"-1")
}


#   SYNC SCAN LOOP
record(ai , "$(PREFIX_D1):Trigger"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D1):Out"){
	field(FLNK, "$(PREFIX_D2):Trigger")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):Trigger"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):Out"){
	field(FLNK, "$(PREFIX_D3):Trigger")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D3):Trigger"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D3):Out"){
    field(FLNK, "$(PREFIX_D1):Trigger")
	field(MDEL,"-1")
}
""")

sync_4 = Template("""
###########################################################################
#                                SYNC SCAN                                #
#                   PREFIX_D1 PREFIX_D2 PREFIX_D3 PREFIX_D4               #
###########################################################################
record(ai , "$(PREFIX_D1):TriggerOneTime"){
    field(PINI, "YES")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D1):OutOneTime"){
	field(FLNK, "$(PREFIX_D2):TriggerOneTime")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):TriggerOneTime"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):OutOneTime"){
	field(FLNK, "$(PREFIX_D3):TriggerOneTime")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D3):TriggerOneTime"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D3):OutOneTime"){
    field(FLNK, "$(PREFIX_D4):TriggerOneTime")
	field(MDEL,"-1")
}
record(ai, "$(PREFIX_D4):TriggerOneTime"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D4):OutOneTime"){
    field(MDEL,"-1")
    field(FLNK, "$(PREFIX_D1):Trigger")
}


#   SYNC SCAN LOOP
record(ai , "$(PREFIX_D1):Trigger"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D1):Out"){
	field(FLNK, "$(PREFIX_D2):Trigger")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):Trigger"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D2):Out"){
	field(FLNK, "$(PREFIX_D3):Trigger")
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D3):Trigger"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D3):Out"){
    field(FLNK, "$(PREFIX_D4):Trigger")
	field(MDEL,"-1")
}
record(ai, "$(PREFIX_D4):Trigger"){
    field(MDEL,"-1")
}
record(ai, "$(PREFIX_D4):Out"){
    field(MDEL,"-1")
    field(FLNK, "$(PREFIX_D1):Trigger")
}
""")
