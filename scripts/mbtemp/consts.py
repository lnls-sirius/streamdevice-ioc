from common.db import DbData
from common.utils import dump_to_history

SHEET_MBTEMP = 'PVs MBTemp'
_mbt = DbData(SHEET_MBTEMP)
DATA_MBTEMP = _mbt.data
dump_to_history(_mbt.sheet, 'mbtemp.csv')
