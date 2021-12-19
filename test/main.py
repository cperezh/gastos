import os
import pandas as pd
from DbConnection import DbConnection

def test_empty(dbConn:DbConnection):
    '''
    Primera prueba: Gasto vacia, no inserta nada en las dimensiones
    '''

    #run_etl()

    query = '''
    select 30 from staging.subcategoria, staging.dia, staging.gastos_fact;
    '''
    df_result = dbConn.exec_query(query)

    print(df_result)

    if len(df_result)==0:
        resultado = "OK"
    else:
        resultado = "KO"
    
    return resultado

def run_etl():
    os.system("..\\etl\\run_dwh C:/Users/Carlos/Proyectos/gastos/etl >>salida.log")

if __name__=="__main__":
    # Este código lo hice con mi hijo Manuel

    dbConnection = DbConnection()
    
    resultado = test_empty(dbConnection)

    print(resultado)