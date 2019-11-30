from common.db import DbData
from common.utils import dump_to_history

SHEET_COUNTING_PRU = 'PVs Counting PRU'
_pru = DbData(SHEET_COUNTING_PRU)
DATA_COUNTING_PRU = _pru.data
dump_to_history(_pru.sheet, 'counting-pru.csv')
