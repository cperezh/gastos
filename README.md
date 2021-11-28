# Source code structure

- **etl**: etl processes
- **doc**: documentation
- **jupyter**: notebooks
- **db**: database 

# ETL

## RUN

- Run ```run.bat``` to process movements on file ```/in/Movements.csv``` and load DWH

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
3. Run ```gastos_env/Scripts/activate```
4. Run ```jupyter notebook```

# DB
TODO

