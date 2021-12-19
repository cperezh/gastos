import pandas as pd
from DbConnector import DbConnector


class DbConnection:
    '''
    This is class is usefull to execute querys to db. 
    Uses Singleton patter for db connection, ony 1 connection
    '''

    connector = DbConnector()

    def exec_query(self, query):
        ''' Executes query'''

        conn = self.connector.getConnection()

        df = pd.read_sql_query(query,con=conn)

        self.connector.closeConnection()

        return df


if __name__=="__main__":
    
    db = DbConnection()
    df = db.exec_query("select * from staging.movimientos")

    print(len(df))
    
    db2 = DbConnection()
    df2 = db2.exec_query("select * from staging.movimientos")
    print(len(df2))
    
