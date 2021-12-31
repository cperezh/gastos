# Source code structure

- **etl**: etl processes
- **doc**: documentation
- **jupyter**: notebooks
- **db**: database 

# ETL

## Design

1. Load Staging
2. Load Enterprise DWH
3. Load Datamarts

## RUN

- Run ```run_full.bat``` to process movements on file and load DWH
- By default run this command: ```run_full <local_dir>/gastos/etl Movements.csv```. The first parameter is the route to etl folder 
in the project and the second parameter is the file with the new movements. We will use a different file for testing purposes


## Fichero de datos
- ```/staging/in/Movements.csv```: Para añadir nuevos datos, descargar el fichero excel de ING, convertir en CSV y añadirlos a este fichero para cargarlos. No importa que hay duplicados, ya que se omiten.
- ```/staging/in/Movements - all.csv```: Fichero backup con todos los movimientos

# DOC
- File ```doc/dimensional.drawio```

![Screenshot](doc/dimensional.drawio.png)


# Jupyter

## Installation

1. Run CMD
2. Navigate to **jupyter** folder
3. Run ```python -m venv gastos_env```
4. Run ```gastos_env/Scripts/activate```
5. @**jupyter** folder, run ```pip install -r requirements.txt```

## Run

1. Run CMD
2. Navigate to **jupyter** folder
3. Run ```run_jupyter.bat```

# DB

## Installation

1. Install PostgreSQL 11.4
2. Create ```gastos``` db 
3. Set **postgres** user password to **postgres**
3. Run ```starting_schema.sql```
4. Run ```inserts.sql```

## Testing

1. Run ```test.sql``` step by step. After each step, run 

# Testing

1. Run CMD
2. Navigate to **test** folder
3. Run ```python -m venv test_env```
4. @**test** folder, run ```pip install -r requirements.txt``
5. Run ```main.py```
