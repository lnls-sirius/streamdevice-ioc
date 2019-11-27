import logging

from streamdeviceioc.common import DbData

logger = logging.getLogger()

SHEET_4UHV = 'PVs Agilent 4UHV'
DATA_4UHV = DbData(SHEET_4UHV).data
