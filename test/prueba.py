import os
import psycopg2
import pandas as pd

def connect():
    conn = psycopg2.connect(host="localhost"
    , database="gastos"
    , user="postgres"
    , password="postgres")

    conn.set_session(autocommit=True)

    return conn

def close_conn(conn):
    conn.close()

def test_empty(conn):
    '''
    Primera prueba: Gasto vacia, no inserta nada en las dimensiones
    '''

    run_etl()

    query = '''
    select count(*) from staging.subcategoria, staging.dia, staging.gastos_fact;
    '''
    df_result = run_query(query, conn)

    if len(df_result)==0:
        resultado = "OK"
    else:
        resultado = "KO"
    
    return resultado

def run_etl():
    os.system("..\\etl\\run_dwh")

def run_query(query, conn):
   
    df = pd.read_sql_query(query,con=conn)

    return df

if __name__=="__main__":
    # Este código lo hice con mi hijo Manuel

    db_conn = connect()
    
    run_etl()
    #resultado = test_empty(db_conn)

    #print(resultado)

    close_conn(db_conn)