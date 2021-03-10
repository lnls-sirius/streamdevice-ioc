import logging

from common.utils import dump_to_history
from common.db import DbData

logger = logging.getLogger()

SHEET_4UHV = "PVs Agilent 4UHV"
_4UHV = DbData(SHEET_4UHV)
DATA_4UHV = _4UHV.data
