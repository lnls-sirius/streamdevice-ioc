import logging

from common.db import DbData

logger = logging.getLogger()
SHEET_MKS = "PVs MKS937b"


def mks_check(row, sheet_name):
    if row["Configuracao"] == "":
        logger.error(
            "{0}: Configuration not set for {1}.".format(sheet_name, row["IP"])
        )
        return False
    return True


_mks = DbData(SHEET_MKS, aditional_check=mks_check)
DATA_MKS = _mks.data
