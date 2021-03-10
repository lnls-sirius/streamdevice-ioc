from common.db import DbData

SHEET_RACKMONITORING = "PVs RackMonitoring"
_rackMon = DbData(SHEET_RACKMONITORING)
DATA_RACKMONITORING = _rackMon.data
ENTITIES_RACKMONITORING = [
    "LM35_Temp",
    "DHT_Temp",
    "DHT_Humidity",
    "FrontDoor",
    "BackDoor",
    "FanStatus",
    "FanCurrent",
    "OutletVoltage",
]
