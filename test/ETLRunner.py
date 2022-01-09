import os

class ETLRunner:

    ETL_PATH = "C:/Users/Carlos/Proyectos/Gastos/etl"
    ETL_SCRIPT = ETL_PATH+"/run_full"
    MOVEMENTS_FILE_PATH = ETL_PATH + "/in/"

    def __init__(self):
        self.file = None
    
    def run_etl(self, movements_file:str):
        os.system(self.ETL_SCRIPT+" "+self.ETL_PATH+" "+self.MOVEMENTS_FILE_PATH+movements_file)