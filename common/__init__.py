#!/usr/bin/python3
import logging
import os
import pandas

logger = logging.getLogger()
handler = logging.StreamHandler()
formatter = logging.Formatter('%(asctime)s %(name)-12s %(levelname)-8s %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)
logger.setLevel(logging.INFO)

SPREADSHEET = os.path.dirname(os.path.realpath(__file__)) + '/Redes e Beaglebones.xlsx'

SHEET_MBTEMP = 'PVs MBTemp'
SHEET_4UHV = 'PVs Agilent 4UHV'
SHEET_MKS = 'PVs MKS937b'
SHEET_COUNTING_PRU = 'PVs Counting PRU'

class DbData():
    def __init__(self, sheet_name, ip='IP', aditional_check = None):
        '''
        :param sheet_name: xlsx sheet name.
        :param ip: column name containing the ip address.
        :param aditional_check: a function that receives row and sheet_name and returns True or False depending on the check result.
        '''
        self.data = {}
        sheet = pandas.read_excel(SPREADSHEET, sheet_name=sheet_name, dtype=str)
        sheet = sheet.replace('nan', '')
        for index, row in sheet.iterrows():
            if row[ip] == '':
                logger.error('%s: Ip not set for %s {}.' % (sheet_name, row))
                continue

            if aditional_check and not aditional_check(row, sheet_name):
                continue

            if row[ip] in self.data:
                self.data[row[ip]].append(row)
            else:
                self.data[row[ip]] = [row]
        logger.info('Generated data structure from sheet %s.' % sheet_name)

def mks_check(row, sheet_name):
    if row['Configuracao'] == '':
        logger.error('%s: Configuration not set for {}'.format(sheet_name, row))
        return False
    return True

'''
    Data structures will contain a vector of entries related to a single IP
'''
DATA_MBTEMP = DbData(SHEET_MBTEMP).data
DATA_4UHV = DbData(SHEET_4UHV).data
DATA_MKS = DbData(SHEET_MKS, aditional_check=mks_check).data
DATA_COUNTING_PRU = DbData(SHEET_COUNTING_PRU).data
