#!/usr/bin/env python3
import logging
import os

from streamdeviceioc.common import SPREADSHEET_FILE

logger = logging.getLogger()
handler = logging.StreamHandler()
formatter = logging.Formatter('%(asctime)s %(name)-12s %(levelname)-8s %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)
logger.setLevel(logging.INFO)

SPREADSHEET = os.path.join(os.path.dirname(os.path.realpath(__file__)), SPREADSHEET_FILE)
