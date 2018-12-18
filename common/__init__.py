#!/usr/bin/python3
import logging
import os
import pandas

logger = logging.getLogger()
handler = logging.StreamHandler()
formatter = logging.Formatter(
        '%(asctime)s %(name)-12s %(levelname)-8s %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)
logger.setLevel(logging.DEBUG)

SPREADSHEET = os.path.dirname(os.path.realpath(__file__)) + \
    '/../Redes e Beaglebones.xlsx'

SHEET_MBTEMP = 'PVs MBTemp'
SHEET_4UHV = 'PVs Agilent 4UHV'
SHEET_MKS = 'PVs MKS937b'

DATA_MBTEMP = {}
DATA_4UHV = {}
DATA_MKS = {}

# ---------------------------------------------------------------------
sheet = pandas.read_excel(SPREADSHEET, sheet_name=SHEET_MBTEMP, dtype=str)
sheet = sheet.replace('nan', '')
for index, row in sheet.iterrows():
    if row['IP'] == '':
        logger.error('Ip not set for {}'.format(row))
        continue

    if row['IP'] in DATA_MBTEMP:
        DATA_MBTEMP[row['IP']].append(row)
    else:
        DATA_MBTEMP[row['IP']] = [row]
# ---------------------------------------------------------------------
sheet = pandas.read_excel(SPREADSHEET, sheet_name=SHEET_4UHV, dtype=str)
sheet = sheet.replace('nan', '')
for index, row in sheet.iterrows():

    if row['IP'] == '':
        logger.error('4UHV: Ip not set for {}'.format(row))
        continue

    if row['IP'] in DATA_4UHV:
        DATA_4UHV[row['IP']].append(row)
    else:
        DATA_4UHV[row['IP']] = [row]

# ---------------------------------------------------------------------
sheet = pandas.read_excel(SPREADSHEET, sheet_name=SHEET_MKS, dtype=str)
sheet = sheet.replace('nan', '')
for index, row in sheet.iterrows():
    if row['IP'] == '':
        logger.error('MKS: Ip not set for {}'.format(row))
        continue
    if row['Configuracao'] == '':
        logger.error('MKS: Configuration not set for {}'.format(row))
        continue

    if row['IP'] in DATA_MKS:
        DATA_MKS[row['IP']].append(row)
    else:
        DATA_MKS[row['IP']] = [row]
# ---------------------------------------------------------------------