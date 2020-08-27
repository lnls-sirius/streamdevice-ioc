#!/usr/bin/env python3
import logging

logger = logging.getLogger()
handler = logging.StreamHandler()
formatter = logging.Formatter('[%(name)s %(levelname)s] %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)
logger.setLevel(logging.INFO)

