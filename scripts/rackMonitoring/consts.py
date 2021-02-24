from common.db import DbData
from common.utils import dump_to_history

SHEET_RACKMONITORING = 'PVs RackMonitoring'
_rackMon = DbData(SHEET_RACKMONITORING)
DATA_RACKMONITORING = _rackMon.data
dump_to_history(_rackMon.sheet, 'rackMonitoring.csv')
ENTITIES_RACKMONITORING = ["LM35_Temp",
                            "DHT_Temp",
                            "DHT_Humidity",
                            "FrontDoor",
                            "BackDoor",
                            "FanStatus",
                            "FanCurrent",
                            "OutletVoltage"]
