import os
from typing import List
import pandas as pd
from DbConnection import DbConnection

def initDB():

    dbConn = DbConnection()

    script = '''
    truncate table staging.movimientos;
    truncate table staging.subcategoria;
    truncate table staging.dia;
    truncate table staging.gastos_fact;
    truncate table public.gastos_fact;
    delete from public.subcategoria;
    delete from public.dia;
    insert into public.dia(dia_key, dia, mes, anio, fecha) values(0, 0, 0, 0,' 1900-01-01');
    insert into public.dia(dia_key, dia, mes, anio, fecha) values(-1,-1, -1, -1, '1900-01-01'); 
    insert into public.subcategoria(subcategoria_key, subcategoria, categoria) values(0,'UNKNOWN','UNKNOWN');
    insert into public.subcategoria(subcategoria_key, subcategoria, categoria) values(-1,'INVALID','INVALID');
    '''

    dbConn.exec_script(script)

def test_empty():
    '''
    Primera prueba: Gasto vacia, no inserta nada en las dimensiones
    '''

    dbConn = DbConnection()

    run_etl()

    query = "select count(*) as cuenta from staging.subcategoria, staging.dia, staging.gastos_fact;"

    df_result = dbConn.exec_query(query)

    resultado = "test_empty OK" if df_result.iloc[0].cuenta==0 else "test_empty KO"
    
    return resultado

def test_normal_run():

    dbConn = DbConnection()
    resultado = []

    script  = '''
    insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-1000, -500, '2021-01-02', 'CAT1', 'SUBCAT1');
    insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-2000, -1500, '2021-01-03', 'CAT2', 'SUBCAT2');
    insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-3000, -2500, '2021-01-02', 'CAT1', 'SUBCAT1');
    insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-4000, -3500, NULL, 'CAT4', 'SUBCAT4');
    insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-6000, -5500, '2021-06-01', NULL, 'SUBCAT6');
    insert into staging.movimientos(importe, saldo, fvalor, categoria, subcategoria) values (-7000, -6500, '2021-06-01', 'CAT7', NULL);
    '''

    dbConn.exec_script(script)

    run_etl()

    df_result = dbConn.exec_query("select sum(importe) as suma from staging.movimientos;")

    resultado.append(" test_normal_run 1 OK" if (df_result.iloc[0].suma==-23000) \
        else " test_normal_run 1 KO")

    df_result = dbConn.exec_query("select subcategoria from public.subcategoria;")

    resultado.append("test_normal_run 2 OK" if (df_result.subcategoria.str.strip()\
        .isin(["UNKNOWN", "INVALID", "SUBCAT1", "SUBCAT2", "SUBCAT4"]).all()) \
            else "test_normal_run 2 KO")
    
    
    df_result = dbConn.exec_query("select fecha from public.dia;")

    resultado.append("test_normal_run 3 OK" if (df_result.fecha.astype(str).str.strip()\
        .isin(["1900-01-01", "2021-01-02", "2021-01-03", "2021-06-01"]).all()) \
            else "test_normal_run 3 KO")
    
    return resultado

def run_etl():
    os.system("..\\etl\\run_full C:/Users/Carlos/Proyectos/gastos/etl >> salida.log")

if __name__=="__main__":
    # Este código lo hice con mi hijo Manuel

    resultado = []

    # initDB()

    # resultado.append(test_empty())

    resultado.append(test_normal_run())

    print(resultado)