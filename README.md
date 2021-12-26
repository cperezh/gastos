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

- Run ```run_full.bat``` to process movements on file ```/in/Movements.csv``` and load DWH
- Run ```run_dwh.bat``` to load DWH with movements in stating (for testing purpose)

## Extra - Load in parts
			   
- Run ```movimientos.ktr``` to load new Movements onto staging area

- Run ```main.kjb``` after loading new movements in staging to update public analysis model (DWH)

## Fichero de datos
- ```/in/Movements.csv```: Para añadir nuevos datos, descargar el fichero excel de ING, convertir en CSV y añadirlos a este fichero para cargarlos. No importa que hay duplicados, ya que se omiten.


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
