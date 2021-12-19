import psycopg2

class DbConnector:
    
    def __init__(self) -> None:
        self.connection = None
    
    # if connected, returns the same connection
    def getConnection(self):
        if self.connection == None:
            self.connection = self._connect() 
        
        return self.connection

    # Private methos to connect to db
    def _connect(self):

        print("conectando...")
    
        conn = psycopg2.connect(host="localhost"
        , database="gastos"
        , user="postgres"
        , password="postgres")

        conn.set_session(autocommit=True)

        return conn