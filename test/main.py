import os
from typing import List
import pandas as pd
from DbConnection import DbConnection
from ETLRunner import ETLRunner

def initDB():

    dbConn = DbConnection()

    script = '''
    truncate table staging.movimientos;
    truncate table edw.movimientos;
    truncate table dtm.gastos_fact;
    delete from dtm.subcategoria;
    delete from dtm.dia;
    insert into dtm.dia(dia_key, dia, mes, anio, fecha) values(0, 0, 0, 0,' 1900-01-01');
    insert into dtm.subcategoria(subcategoria_key, subcategoria, categoria) values(0,'UNKNOWN','UNKNOWN');
    insert into dtm.subcategoria(subcategoria_key, subcategoria, categoria) values(-1,'INVALID','INVALID');
    '''

    dbConn.exec_script(script)

def test_empty():

    '''Primera prueba: Gasto vacia, no inserta nada en las dimensiones'''

    ETLRunner().run_etl("test_Movements_empty.csv")

    query = "select count(*) as cuenta from dtm.subcategoria, dtm.dia, dtm.gastos_fact;"

    df_result = DbConnection().exec_query(query)

    resultado = "test_empty OK" if df_result.iloc[0].cuenta==0 else "test_empty KO"
    
    return resultado

def test_normal_run():

    dbConn = DbConnection()
    resultado = []

    ETLRunner().run_etl("test_Movevents_normal_run.csv")

    df_result = dbConn.exec_query("select sum(importe) as suma from dtm.gastos_fact;")

    resultado.append(" test_normal_run 1 OK" if (df_result.iloc[0].suma==16000) \
        else " test_normal_run 1 KO")

    df_result = dbConn.exec_query("select subcategoria from dtm.subcategoria order by 1;")

    resultado.append("test_normal_run 2 OK" if (df_result.subcategoria.str.strip().tolist()\
        ==["INVALID", "SUBCAT1", "SUBCAT2", "UNKNOWN"]) \
            else "test_normal_run 2 KO")
    
    df_result = dbConn.exec_query("select fecha from dtm.dia order by 1;")

    resultado.append("test_normal_run 3 OK" if (df_result.fecha.astype(str).str.strip().tolist()\
        ==["1900-01-01", "2021-01-02", "2021-01-03", "2021-06-01", "2021-07-01"]) \
            else "test_normal_run 3 KO")
    
    return resultado

def test_new_movement():

    dbConn = DbConnection()
    resultado = []

    ETLRunner().run_etl("test_Movevents_new_mov.csv")

    df_result = dbConn.exec_query("select sum(importe) as suma from dtm.gastos_fact;")

    resultado.append(" test_new_movement 1 OK" if (df_result.iloc[0].suma==24000) \
        else " test_new_movement 1 KO")
    
    df_result = dbConn.exec_query("select subcategoria from dtm.subcategoria order by 1;")

    resultado.append("test_new_movement 2 OK" if (df_result.subcategoria.str.strip().tolist()\
        ==["INVALID", "SUBCAT1", "SUBCAT2", "SUBCAT8", "UNKNOWN"]) \
            else "test_new_movement 2 KO")
    
    df_result = dbConn.exec_query("select fecha from dtm.dia order by 1;")

    resultado.append("test_new_movement 3 OK" if (df_result.fecha.astype(str).str.strip().tolist()\
        ==["1900-01-01", "2021-01-02", "2021-01-03", "2021-06-01", "2021-07-01"]) \
            else "test_new_movement 3 KO")
    
    return resultado

def test_change_movement():

    dbConn = DbConnection()
    resultado = []

    ETLRunner().run_etl("test_Movevents_change_mov.csv")

    df_result = dbConn.exec_query("select sum(importe) as suma from dtm.gastos_fact;")

    resultado.append(" test_change_movement 1 OK" if (df_result.iloc[0].suma==24000) \
        else " test_change_movement 1 KO")
    
    df_result = dbConn.exec_query("select subcategoria from dtm.subcategoria order by 1;")

    resultado.append("test_change_movement 2 OK" if (df_result.subcategoria.str.strip().tolist()\
        ==["INVALID", "SUBCAT1", "SUBCAT2", "SUBCAT4", "SUBCAT8_CAMBIO", "UNKNOWN"]) \
            else "test_change_movement 2 KO")
    
    df_result = dbConn.exec_query("select fecha from dtm.dia order by 1;")

    resultado.append("test_change_movement 3 OK" if (df_result.fecha.astype(str).str.strip().tolist()\
        ==["1900-01-01", "2021-01-02", "2021-01-03", "2021-06-01", "2021-07-01"]) \
            else "test_change_movement 3 KO")
    
    return resultado

if __name__=="__main__":
    # Este programa lo hice con mi hijo Manuel

    resultado = []

    initDB()

    resultado.append(test_empty())

    resultado.append(test_normal_run())

    # Segundo ejecuci??n para comprobar que no duplica
    resultado.append(test_normal_run())

    resultado.append(test_new_movement())

    resultado.append(test_change_movement())
    
    print(resultado)