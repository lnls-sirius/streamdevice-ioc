import os


class Config:
    def __init__(self):
        self._spreahsheet = None

    def set_spreadsheet(self, name: str):
        self._spreahsheet = name

    def get_spreadsheet(self) -> str:
        return self._spreahsheet


config: Config = Config()

# SPREADSHEET_FILE = "../spreadsheet/Redes e Beaglebones.xlsx"
# SPREADSHEET = os.path.join(
#    os.path.dirname(os.path.realpath(__file__)), SPREADSHEET_FILE
# )

HISTORY_DIR = os.path.join(
    os.path.dirname(os.path.realpath(__file__)), "../streamdevice-ioc-history"
)
