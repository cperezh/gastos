import pandas as pd

if __name__ == "__main__":
   
    df = pd.read_csv("etl/in/Movements.csv", encoding="UTF-8")

    df.head()